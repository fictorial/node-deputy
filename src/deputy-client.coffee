EventEmitter     = (require 'events').EventEmitter
JsonLineProtocol = (require 'json-line-protocol').JsonLineProtocol

uuid = require 'node-uuid'
net  = require 'net'
util = require 'util'

class Job extends EventEmitter
  constructor: (@type, @arg, @id) ->

class DeputyClient extends EventEmitter
  constructor: (port=11746, host='127.0.0.1') ->
    @workers = {}
    @jobs = {}

    @conn = net.createConnection port, host
    @conn.on 'connect', =>
      @conn.setKeepAlive true
      @conn.setNoDelay   true
      @conn.setEncoding 'utf8'
      @emit 'connect'

    @conn.on 'close', => @emit 'close'
    @conn.on 'error', (error) => @emit 'error', error

    protocol = new JsonLineProtocol

    protocol.on 'protocol-error', (error, line) =>
      console.error "internal error: #{error.toString} line:#{line}"
      @emit 'error', error, line
      @conn.close()

    @conn.on 'data', (data) =>
      protocol.feed data

    protocol.on 'value', (msg) =>
      switch msg.cmd
        when 'do'
          try
            @workers[msg.type] msg.arg, (result) =>
              @_write cmd:'did', id:msg.id, res:result
          catch error
            @_write cmd:'did', id:msg.id, res:error

        when 'did'
          @jobs[msg.id]?.emit 'done', msg.res
          delete @jobs[msg.id]

  _write: (value) ->
    @conn.write (JSON.stringify value) + '\r\n' if @conn.writable

  can_do: (object) ->
    job_types = []
    for job_type, method of object when typeof method is 'function'
      job_types.push job_type
      @workers[job_type] = method
    @_write cmd:'can_do', types:job_types
    @

  do: (type, arg, id=null) ->
    id or= uuid()
    @_write {cmd:'do', type, id, arg}
    @jobs[id] = new Job type, arg, id

exports.DeputyClient = DeputyClient

# Deputy Client for Node.js

See [Deputy](https://github.com/fictorial/deputy) for 
information on the Deputy Job Server.

## Installation

    npm i deputy-client

## API

### DeputyClient

````javascript
var client = new(require('deputy-client').DeputyClient)(port, host)
````

#### can_do(handlers)

Job types are the property names of the object `handlers` while the
handler functions are the values. Such a function is called when the
client / worker is assigned a job.  The function is passed the input
argument (singular) to the job as submitted and a callback function that
is to be called with the output/result of the job.

````javascript
client.can_do({
  identity: function (arg, cb) { cb(arg) }
})
````

#### var job = client.do(job_type, arg)

Submits a job to the server to be done by some worker.  The returned
`job` emits 'done' when the result is ready.

#### Events

DeputyClient emits events 'connect' (), 'close' (), and 'error' 
(error, more\_info).

## Author

Brian Hammond <brian@fictorial.com> (http://fictorial.com)

## License

MIT



#!/usr/bin/env coffee

workers =
  sum: (arg, callback) ->
    x = 0
    for value in arg
      x += value
    callback x

client = new (require 'deputy-client').DeputyClient
client.can_do workers

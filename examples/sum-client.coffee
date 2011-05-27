#!/usr/bin/env coffee

client = new (require 'deputy-client').DeputyClient

console.time 'sum tiny array 500x'

waiting_for = 500

for i in [1..500]
  job = client.do 'sum', [1,2,3]
  job.on 'done', (result) ->
    if --waiting_for is 0
      console.timeEnd 'sum tiny array 500x'
      process.exit 0



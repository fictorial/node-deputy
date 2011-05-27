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

Copyright (c) 2011 Fictorial LLC.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.



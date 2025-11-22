// Node.js program to demonstrate the
// fs.watch() method

fs = require('fs')
execSync = require('child_process').execSync

executeCommand = command => {
  return execSync(command).toString('utf8').replace(/[\n\r\s]+$/, '')
}

fs.watch(
  'beta',
  { recursive: true },
  (eventType, filename) => {
    if (eventType === 'change') {
      executeCommand("cd mcp/batch && watch.bat")
      console.log(filename, 'changed.')
    }
  }
)

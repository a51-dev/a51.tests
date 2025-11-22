/*
Created by Dario Passariello
*/

const
  dt = new Date(),
  padL = (nr, len = 2, chr = `0`) => `${nr}`.padStart(2, chr),
  dateTime = padL(dt.getMonth() + 1) + "/" +
    padL(dt.getDate()) + "/" +
    dt.getFullYear() + " " +
    padL(dt.getHours()) + ":" +
    padL(dt.getMinutes()) + ":" +
    padL(dt.getSeconds()),

  execSync = require('child_process').execSync,
  pjson = require('../../package.json'),

  executeGitCommand = command => {
    return execSync(command).toString('utf8').replace(/[\n\r\s]+$/, '')
  },

  BRANCH = executeGitCommand('git rev-parse --abbrev-ref HEAD'),
  COMMIT_SHA = executeGitCommand('git rev-parse HEAD')

//https://stackoverflow.com/questions/55021363/how-to-pass-current-datetime-in-npm-script-for-git-commit-message-in-windows-and

try {
  try { execSync(`git push --set-upstream origin ${BRANCH}`, { stdio: [0, 1, 2] }) } finally {
    // try { execSync(`git checkout -b ${BRANCH}`, { stdio: [0, 1, 2] }) } finally {
    // try { execSync(`git pull &&`, { stdio: [0, 1, 2] }) } finally {
    try { execSync(`git add -A`, { stdio: [0, 1, 2] }) } finally {
      try { execSync(`git commit -m \"${BRANCH} ${dateTime}\" && git push -f`, { stdio: [0, 1, 2] }) } finally {
        try {
          execSync(`git tag \"v${pjson.version}\" -am \"Modify content\" && git push --tags`)
        } catch (error) { console.log(`NO TAG GENERATED \n\n\n\n`) }
      }
    }
  }
} catch (error) {

  console.log(">", error)

}


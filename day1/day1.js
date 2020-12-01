const fs = require('fs');

const lines = fs.readFileSync('input.txt', { encoding: 'utf-8' }).split('\n').filter(x => x).map(x => parseInt(x))
const TOTAL = 2020

for (let i = 0; i < lines.length; i++) {
  for (let j = i + 1; j < lines.length; j++) {
    if (lines[i] + lines[j] == TOTAL) {
      console.log('solution1', lines[i] * lines[j])
      console.info(lines[i], lines[j])
    }
  }
}

for (let i = 0; i < lines.length; i++) {
  for (let j = i + 1; j < lines.length; j++) {
    for (let k = j + 1; k < lines.length; k++) {
      if (lines[i] + lines[j] + lines[k] == TOTAL) {
        console.log('solution2', lines[i] * lines[j] * lines[k])
        console.info(lines[i], lines[j], lines[k])
      }
    }
  }
}
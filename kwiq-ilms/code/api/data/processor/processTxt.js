/* eslint-disable new-cap */
/* eslint-disable no-console */
/* eslint-disable no-unused-expressions */
const fs = require('fs');
const readline = require('readline');
const stream = require('stream');
const path = require('path');

const rawFilename = './../raw/NEET-2018-raw.txt';
const filename = './../json/questions.json';

class Question {
  constructor() {
    this.qtionNo;
    this.qtion;
    this.optionA;
    this.optionB;
    this.optionC;
    this.optionD;
    this.year;
  }
}

const instream = fs.createReadStream(path.resolve(__dirname, rawFilename));
const outstream = new stream();
const rl = readline.createInterface(instream, outstream);

const txtData = [];
const pages = [];

const questionObjects = [];
const year = '2018';

const totalPages = 23;
let pageNo = 0;

function processData() {
  let page = [];

  for (let index = 0; index < txtData.length; index++) {
    const line = txtData[index];
    page.push(line);
    if (line == `----------------Page (${pageNo}) Break----------------`) {
      pages.push(page);
      pageNo++;
      page = [];
    }
  }

  rl.on('line', (_line) => {
    // process line here
    txtData.push(_line);
  });

  rl.on('close', () => {
    console.log('txtData', txtData.length);
    processData();
  });

  console.log(` Pages length${pages.length}`);

  const startPage = 1;
  const endPage = 20;

  let questionNo = 1;

  let questionStarts = false;
  let optionStarts = false;
  let opAStarts = false;
  let opBStarts = false;
  let opCStarts = false;
  let opDStarts = false;

  let question = '';
  let opA = '';
  let opB = '';
  let opC = '';
  let opD = '';

  let lastPage = false;

  for (let pageIndex = startPage; pageIndex <= endPage; pageIndex++) {
    if (pageIndex == endPage) {
      lastPage = true;
    }
    //
    console.log(`pageIndex${pageIndex}`);
    //
    page = pages[pageIndex];
    console.log(`page length :${page.length}`);
    //
    for (let lineIndex = 0; lineIndex < page.length; lineIndex++) {
      //
      let line = page[lineIndex];
      // console.log('line :' + line);
      //
      if (line.startsWith(`${questionNo}.`)) {
        // console.log('line startsWith question');

        if (opDStarts) {
          const qObj = new Question();
          qObj.qtionNo = questionNo - 1;
          qObj.qtion = question;
          qObj.optionA = opA;
          qObj.optionB = opB;
          qObj.optionC = opC;
          qObj.optionD = opD;
          qObj.year = year;

          questionObjects.push(qObj);

          question = '';
          opA = '';
          opB = '';
          opC = '';
          opD = '';
        }

        questionNo++;
        questionStarts = true;
        //
        optionStarts = false;
        opAStarts = false;
        opBStarts = false;
        opCStarts = false;
        opDStarts = false;
      }

      if (line.startsWith('(1)')) {
        // console.log('line startsWith option 1');
        questionStarts = false;
        optionStarts = true;
        opAStarts = true;
      }
      if (line.startsWith('(2)')) {
        // console.log('line startsWith option 2');
        opAStarts = false;
        opBStarts = true;
      }
      if (line.startsWith('(3)')) {
        // console.log('line startsWith option 3');
        opCStarts = true;
        opBStarts = false;
      }
      if (line.startsWith('(4)')) {
        // console.log('line startsWith option 4');
        opDStarts = true;
        opCStarts = false;
      }

      //
      if (line.startsWith('ACHLA/AA/Page') || line.startsWith('----------------Page')) {
        line = '';
      }

      if (questionStarts) {
        question += line;
      }
      if (opAStarts) {
        opA += line;
      }
      if (opBStarts) {
        opB += line;
      }
      if (opCStarts) {
        opC += line;
      }
      if (opDStarts) {
        opD += line;
      }

      // if last question dont have any options
      const lastLine = lineIndex == page.length - 1;

      if (lastLine) {
        if (!opDStarts || lastPage) {
          const qObj = new Question();
          qObj.qtionNo = questionNo - 1;
          qObj.qtion = question;
          qObj.optionA = opA;
          qObj.optionB = opB;
          qObj.optionC = opC;
          qObj.optionD = opD;
          qObj.year = year;

          questionObjects.push(qObj);

          question = '';
          opA = '';
          opB = '';
          opC = '';
          opD = '';
        }
      }
      //
    }
  }
  console.log(`questionObjects.length${questionObjects.length}`);
  fs.writeFileSync(path.resolve(__dirname, filename), JSON.stringify(questionObjects));
}

/* eslint-disable no-plusplus */
/* eslint-disable no-console */
const fs = require('fs');
const path = require('path');

const models = require('../../src/setup/models');

const filename = './../json/questions.json';

let questions = [];

try {
  //
  questions = JSON.parse(fs.readFileSync(path.resolve(__dirname, filename)));
  //
  console.log(questions.length);
  //
  for (let index = 0; index < questions.length; index++) {
    const question = questions[index];
    const { qtionNo } = question;
    const qtion = question.qtion.replace(`${qtionNo}. `, '');
    const optionA = question.optionA.replace('(1) ', '');
    const optionB = question.optionB.replace('(2) ', '');
    const optionC = question.optionC.replace('(3) ', '');
    const optionD = question.optionD.replace('(4) ', '');
    const { year } = question;

    models.Question.create({
      question: qtion,
      optionA,
      optionB,
      optionC,
      optionD,
      neetQuestionyear: year,
      neetQuestionNo: qtionNo,
      isActive: false,
    }).then((qus) => {
      console.log(qus.id);
    });
  }

  console.log('Completed ....');
} catch (err) {
  console.log('Error parsing JSON string:', err.message);
}

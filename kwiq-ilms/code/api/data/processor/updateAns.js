const fs = require('fs');
const path = require('path');
const csv = require('csv-parser');

const models = require('../../src/setup/models');

const filename = './../ans/2018_NEET_ANS.csv';

try {
  //
  fs.createReadStream(path.resolve(__dirname, filename))
    .pipe(csv())
    .on('data', (data) => {
      try {
        console.log(`QNO is: ${data.QNO}`);
        console.log(`ANS is: ${data.ANS}`);

        models.Question.update(
          {
            answer: data.ANS,
          },
          {
            where: {
              neetQuestionNo: data.QNO,
              neetQuestionyear: 2018,
            },
          },
        );
      } catch (err) {
        console.log('Error while updating the table :', err.message);
      }
    })
    .on('end', () => {
      console.log('Completed ....');
    });
} catch (error) {
  console.log('Error while reading the file:', error.message);
}

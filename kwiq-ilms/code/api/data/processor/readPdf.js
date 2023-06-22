const fs = require('fs');
const PDFParser = require('pdf2json');
const path = require('path');

const pdfFilename = './../pdf/NEET-2018.pdf';
const rawTxtFilename = './../raw/NEET-2018-raw.txt';

const pdfParser = new PDFParser(this, 1);

pdfParser.on('pdfParser_dataError', errData => console.error(errData.parserError));
pdfParser.on('pdfParser_dataReady', (pdfData) => {
  fs.writeFileSync(path.resolve(__dirname, rawTxtFilename), pdfParser.getRawTextContent());
});

pdfParser.loadPDF(path.resolve(__dirname, pdfFilename));

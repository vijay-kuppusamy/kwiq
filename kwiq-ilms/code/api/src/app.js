const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const homeRouter = require('./routers/homeRouter');
const userRouter = require('./routers/userRouter');
const courseRouter = require('./routers/courseRouter');
const subjectRouter = require('./routers/subjectRouter');
const chapterRouter = require('./routers/chapterRouter');
const unitRouter = require('./routers/unitRouter');
const questionRouter = require('./routers/questionRouter');
const examRouter = require('./routers/examRouter');
const mockExamRouter = require('./routers/mockExamRouter');
//
const locationRouter = require('./routers/locationRouter');

const { authenticateAdmin } = require('./middlewares/authentication');

const { PORT, HOST } = require('./config/env');

const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use(cors());
app.options('*', cors());

app.use('/', homeRouter);
app.use('/users', authenticateAdmin, userRouter);
app.use('/courses', courseRouter);
app.use('/subjects', subjectRouter);
app.use('/chapters', chapterRouter);
app.use('/units', unitRouter);
app.use('/questions', questionRouter);
app.use('/exams', examRouter);
app.use('/mockexam', mockExamRouter);
//
app.use('/tracking', locationRouter);
//
app.listen(PORT, HOST, () => {
  console.log(`Server running at http://${HOST}:${PORT}/`);
});

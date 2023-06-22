/* eslint-disable react-hooks/exhaustive-deps */
import React from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';
import { Redirect } from 'react-router-dom';
import { makeStyles } from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import Typography from '@material-ui/core/Typography';

import { AppContext } from '../common/AppContext';

const useStyles = makeStyles(theme => ({
  container: {
    display: 'flex',
    flexWrap: 'wrap',
  },
  textField: {
    marginLeft: theme.spacing(1),
    marginRight: theme.spacing(1),
  },
  dense: {
    marginTop: theme.spacing(2),
  },
  menu: {
    width: 200,
  },
  paper: {
    padding: theme.spacing(2),
  }
}));

const QuestionForm = (props) => {

const classes = useStyles();
const id = props.match.params.id;

const [state, setState] = React.useContext(AppContext);
const { user } = state;

const [redirect, setRedirect] = React.useState(false);

const [values, setValues] = React.useState({
    id:"",
    question: "",
    optionA: "",
    optionB: "",
    optionC: "",
    optionD: "",
    neetQuestionyear:"",
    neetQuestionNo:"",
    answer:"",
    isActive:"",
    subjectId:"",
    chapterId:""
  });

const handleChange = name => event => {
    setValues({ ...values, [name]: event.target.value });
};

const saveQuestion = e => {
  e.preventDefault();

  const url = process.env.REACT_APP_API_SERVER_URL+"/questions/";
  const headers = { headers: {"Authorization" : `Bearer ${user.token}`} };
  //alert(JSON.stringify(headers));
  try {
    axios.put(url, values, headers)
      .then(response => response.data)
      .then((data) => {
        console.log(" Response Data "+data);
        alert(JSON.stringify(data));
        setRedirect(true);
      })
  } catch (error) {
    console.error(`Request error: ${error.message}`);
  }

  //var jObj = JSON.stringify(values);
  //alert(jObj);
};  

React.useEffect(() => {
  axios.get(process.env.REACT_APP_API_SERVER_URL+`/questions/${id}`)
    .then(response => response.data)
    .then((data) => {
        setValues({ ...values, 
        id: data.id,
        question: data.question, 
        optionA: data.optionA,
        optionB: data.optionB,
        optionC: data.optionC,
        optionD: data.optionD,
        neetQuestionyear: data.neetQuestionyear,
        neetQuestionNo: data.neetQuestionNo,
        answer: data.answer,
        isActive: data.isActive,
        subjectId: data.subjectId,
        chapterId: data.chapterId
      });
    })
    .catch(err => console.log(err));
  }, []);

  if (redirect) {
    return <Redirect to='/questions' />;
  }

  return (
    <React.Fragment>

    <Paper className={classes.paper}>
    <Typography variant="h6" gutterBottom>
        Question Form
    </Typography>
        <form className={classes.container} onSubmit={saveQuestion} autoComplete="off">
        <Grid container spacing={2}>
        <Grid item xs={12} sm={3}>
          <TextField
            id="outlined-full-width"
            label="Subject"
            placeholder="Subject"
            multiline
            fullWidth
            value={values.subjectId}
            onChange={handleChange('subjectId')}
            className={classes.textField}
            margin="normal"
            variant="outlined"
            InputLabelProps={{
              shrink: true,
            }}
          />
        </Grid>
        <Grid item xs={12} sm={3}>
          <TextField
            id="outlined-full-width"
            label="Chapter"
            placeholder="Chapter"
            multiline
            fullWidth
            value={values.chapterId}
            onChange={handleChange('chapterId')}
            className={classes.textField}
            margin="normal"
            variant="outlined"
            InputLabelProps={{
              shrink: true,
            }}
          />
        </Grid>
        <Grid item xs={12} sm={3}>
          <TextField
            id="outlined-full-width"
            label="Year"
            placeholder="Year"
            multiline
            fullWidth
            value={values.neetQuestionyear}
            onChange={handleChange('neetQuestionyear')}
            className={classes.textField}
            margin="normal"
            variant="outlined"
            InputLabelProps={{
              shrink: true,
            }}
          />
        </Grid>
        <Grid item xs={12} sm={3}>
        </Grid>
        <Grid item xs={12} sm={3}>
          <TextField
            id="outlined-full-width"
            label="Q No"
            placeholder="Q NO"
            multiline
            fullWidth
            value={values.neetQuestionNo}
            onChange={handleChange('neetQuestionNo')}
            className={classes.textField}
            margin="normal"
            variant="outlined"
            InputLabelProps={{
              shrink: true,
            }}
          />
        </Grid>
        <Grid item xs={12} sm={3}>
              <TextField
                id="outlined-full-width"
                label="Active"
                placeholder="Active"
                multiline
                fullWidth
                value={values.isActive}
                onChange={handleChange('isActive')}
                className={classes.textField}
                margin="normal"
                variant="outlined"
                InputLabelProps={{
                  shrink: true,
                }}
              />
        </Grid>
        <Grid item xs={12} sm={3}>
              <TextField
                id="outlined-full-width"
                label="Answer"
                placeholder="Answer"
                multiline
                fullWidth
                value={values.answer}
                onChange={handleChange('answer')}
                className={classes.textField}
                margin="normal"
                variant="outlined"
                InputLabelProps={{
                  shrink: true,
                }}
              />
        </Grid>
        <Grid item xs={12} sm={3}>
        </Grid>
        <Grid item xs={12} sm={6}>
            <TextField
                id="outlined-full-width"
                label="Question"
                placeholder="Question"
                multiline
                fullWidth
                rows="4"
                value={values.question}
                onChange={handleChange('question')}
                className={classes.textField}
                margin="normal"
                variant="outlined"
                InputLabelProps={{
                shrink: true,
                }}
            />
        </Grid>
        <Grid item xs={12} sm={6}>
            <div  style={{margin: 10, padding: 10}} dangerouslySetInnerHTML={{__html: values.question}} />
        </Grid>
        <Grid item xs={12} sm={6}>
            <TextField
                id="outlined-multiline-flexible"
                label="Option A"
                multiline
                fullWidth
                rows="2"
                value={values.optionA}
                onChange={handleChange('optionA')}
                placeholder="Option A"
                className={classes.textField}
                margin="normal"
                variant="outlined"
                InputLabelProps={{
                shrink: true,
                }}
            />

        </Grid>
        <Grid item xs={12} sm={6}>
            <div  style={{margin: 10, padding: 10}} dangerouslySetInnerHTML={{__html: values.optionA}} />
        </Grid>
        <Grid item xs={12} sm={6}>
            <TextField
                id="outlined-multiline-flexible"
                label="Option B"
                multiline
                fullWidth
                rows="2"
                value={values.optionB}
                onChange={handleChange('optionB')}
                placeholder="Option B"
                className={classes.textField}
                margin="normal"
                variant="outlined"
                InputLabelProps={{
                shrink: true,
                }}
            />
        </Grid>
        <Grid item xs={12} sm={6}>
            <div  style={{margin: 10, padding: 10}} dangerouslySetInnerHTML={{__html: values.optionB}} />
        </Grid>
        <Grid item xs={12} sm={6}>
            <TextField
                id="outlined-multiline-flexible"
                label="Option D"
                multiline
                fullWidth
                rows="2"
                value={values.optionC}
                onChange={handleChange('optionC')}
                placeholder="Option C"
                className={classes.textField}
                margin="normal"
                variant="outlined"
                InputLabelProps={{
                shrink: true,
                }}
            />
        </Grid>
        <Grid item xs={12} sm={6}>
            <div  style={{margin: 10, padding: 10}} dangerouslySetInnerHTML={{__html: values.optionC}} />
        </Grid>
        <Grid item xs={12} sm={6}>
            <TextField
                id="outlined-multiline-flexible"
                label="Option D"
                multiline
                fullWidth
                rows="2"
                value={values.optionD}
                placeholder="Option D"
                onChange={handleChange('optionD')}
                className={classes.textField}
                margin="normal"
                variant="outlined"
                InputLabelProps={{
                shrink: true,
                }}
            />
        </Grid>
        <Grid item xs={12} sm={6}>
            <div  style={{margin: 10, padding: 10}} dangerouslySetInnerHTML={{__html: values.optionD}} />
        </Grid>
        <Grid item xs={8} sm={2}>
            <Button type="submit" variant="contained" fullWidth size="medium" color="primary">
            Save
          </Button>
        </Grid>
        <Grid item xs={8} sm={2}>
            <Link to={'/questions'} style={{ textDecoration: 'none' }}>
            <Button variant="contained" fullWidth size="medium" color="primary">
            Cancel
          </Button>
          </Link>
        </Grid>

        </Grid>
    </form>
    </Paper>
    </React.Fragment>
  );
}

export default QuestionForm;
/* eslint-disable react-hooks/exhaustive-deps */

import React from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';
import Grid from '@material-ui/core/Grid';
import { makeStyles } from '@material-ui/core/styles';
import { Table, TableBody, TableCell, TableHead, TableRow} from '@material-ui/core';
import TablePagination from '@material-ui/core/TablePagination';
import { TextField, Button, Checkbox } from '@material-ui/core';
import DeleteIcon from '@material-ui/icons/Delete';
import EditIcon from '@material-ui/icons/Edit';
import AddIcon from '@material-ui/icons/Add';
import SearchIcon from '@material-ui/icons/Search';

import { AppContext } from '../common/AppContext';
import Title from '../common/Title';

const useStyles = makeStyles(theme => ({
  container: {
    display: 'flex',
    flexWrap: 'wrap',
  },
  textField: {
    marginLeft: theme.spacing(1),
    marginRight: theme.spacing(1),
  },
  button: {
    marginTop: theme.spacing(1),
    width: 170,
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

function QuestionsList () {

  const classes = useStyles();
  //
  const [state, setState] = React.useContext(AppContext);

  const [page, setPage] = React.useState(0);
  const [rowsPerPage, setRowsPerPage] = React.useState(50);

  const [questions, setQuestions] = React.useState([]);

  //const { values } = state;
  const [values, setValues] = React.useState({
    year:"2018",
    subjectId:"1",
   });

  const handleChangePage = (event, newPage) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = event => {
    setRowsPerPage(+event.target.value);
    setPage(0);
  };

  const handleChange = name => event => {
    setValues({ ...values, [name]: event.target.value });
  };

  const searchQuestions = e => {
    e.preventDefault();
    loadQuestions();
  }

  const loadQuestions = () => {
    const url = process.env.REACT_APP_API_SERVER_URL + `/questions/search/${values.year}/${values.subjectId}`;
    axios.get(url)
      .then(response => response.data)
      .then((data) => {
        //console.log(data);
        setQuestions(data);
      })
      .catch(err => console.log(err));
  }

  return (
    <React.Fragment>
      <Title>
        <span>Questions</span>
      </Title>

      <form className={classes.container} onSubmit={searchQuestions} autoComplete="off">

      <Grid container alignItems="center" justify="center" spacing={3}>
      <Grid item xs={3}>
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
      <Grid item xs={3}>
        <TextField
              id="outlined-full-width"
              label="Year"
              placeholder="Year"
              multiline
              fullWidth
              value={values.year}
              onChange={handleChange('year')}
              className={classes.textField}
              margin="normal"
              variant="outlined"
              InputLabelProps={{
                shrink: true,
              }}
            />
      </Grid>
      <Grid item xs={3}>
        <Button type="submit" variant="contained" color="primary">
          <SearchIcon style={{ fontSize: 15}} />
          Search
        </Button>
      </Grid>
      <Grid item xs={3}>
        <Button variant="contained" color="primary">
         <AddIcon style={{ fontSize: 15}} />
         Create Question
        </Button>
      </Grid>
      </Grid>
    </form>

    <br></br>
    <Table size="small">
        <TableHead>
          <TableRow>
            <TableCell>Neet Year</TableCell>
            <TableCell>Question No</TableCell>
            <TableCell>Subject</TableCell>
            <TableCell>Chapter</TableCell>
            <TableCell>Answer</TableCell>
            <TableCell>Active</TableCell>
            <TableCell>Actions</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
        {questions.slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage).map(row => (
          <TableRow key={row.id}>
          <TableCell style={{minWidth:50, maxWidth:50}}>{row.neetQuestionyear}</TableCell>
          <TableCell style={{minWidth:50, maxWidth:50}}>{row.neetQuestionNo}</TableCell>
          <TableCell style={{minWidth:50, maxWidth:50}}>{row.subjectId}</TableCell>
          <TableCell style={{minWidth:50, maxWidth:50}}>{row.chapterId}</TableCell>
          <TableCell style={{minWidth:50, maxWidth:50}}>{row.answer}</TableCell>
          <TableCell>
          {row.isActive}
            <Checkbox
                checked={ row.isActive === 1 ? true:false }
                onChange={ () => {} }
                value="isActive"
                color="primary"
                inputProps={{
                  'aria-label': 'primary checkbox',
                }}
            />
          </TableCell>
          <TableCell>
            <Link to={`/question/${row.id}`} style={{ textDecoration: 'none' }}>
              <Button variant="contained" size="small" color="primary" style={{margin: 1}}>
              Edit
              <EditIcon style={{fontSize: 15, margin: 1,}} />
              </Button>
            </Link>
            <Button variant="contained" size="small" color="secondary" style={{margin: 1}}>
            Delete
            <DeleteIcon style={{fontSize: 15, margin: 1,}} />
            </Button>
          </TableCell>
          </TableRow>
        ))}

        </TableBody>
      </Table>

      <TablePagination
          rowsPerPageOptions={[10, 25, 50]}
          component="div"
          count={questions.length}
          rowsPerPage={rowsPerPage}
          page={page}
          backIconButtonProps={{
            'aria-label': 'previous page',
          }}
          nextIconButtonProps={{
            'aria-label': 'next page',
          }}
          onChangePage={handleChangePage}
          onChangeRowsPerPage={handleChangeRowsPerPage}
        />

    </React.Fragment>
  );
}

export default QuestionsList;

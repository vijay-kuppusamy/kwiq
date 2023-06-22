/* eslint-disable react-hooks/exhaustive-deps */

import React from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';
import Grid from '@material-ui/core/Grid';
import { makeStyles } from '@material-ui/core/styles';
import { TextField, Button } from '@material-ui/core';
import { Table, TableBody, TableCell, TableHead, TableRow } from '@material-ui/core';
import MenuItem from '@material-ui/core/MenuItem';
import DeleteIcon from '@material-ui/icons/Delete';
import EditIcon from '@material-ui/icons/Edit';
//import AddIcon from '@material-ui/icons/Add';

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
        width: 150,
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

const ContentsList = () => {
    const classes = useStyles();

    var [courses, setCourses] = React.useState([{
        value: "1",
        label: "NEET",
    }]);

    var [subjects, setSubjects] = React.useState([]);
    var [chapters, setChapters] = React.useState([]);
    var [units, setUnits] = React.useState([]);
    
    var [values, setValues] = React.useState({
        course: 1,
        subject: "",
        chapter:"",
        page: 0,
        search: false
    });
    
    const loadSubjects = () => {
        const url = process.env.REACT_APP_API_SERVER_URL+`/subjects/${values.course}`;
        axios.get(url)
            .then(response => response.data)
            .then((data) => {
                var objects = []
                data.forEach(element => {
                    var sub = { value: element.id, label: element.name, };
                    objects.push(sub);
                });
                setSubjects(objects);
            })
            .catch(err => console.log(err));
    }

    const loadChapters = (input) => {
        const url = process.env.REACT_APP_API_SERVER_URL+`/chapters/${input}`;
        axios.get(url)
            .then(response => response.data)
            .then((data) => {
                var objects = [];
                data.forEach(element => {
                    var chap = { value: element.id, label: element.name, };
                    objects.push(chap);
                });
                setChapters(objects);
            })
            .catch(err => console.log(err));
    }

    const loadUnits = () => {
        const url = process.env.REACT_APP_API_SERVER_URL+`/units/${values.chapter}`;
        axios.get(url)
            .then(response => response.data)
            .then((data) => {
                setUnits(data);
            })
            .catch(err => console.log(err));
    }

    React.useEffect(() => {
        loadSubjects();
    }, [values.course]);

    const handleChange = name => event => {
        setValues({ ...values, [name]: event.target.value });
    };

    const handleSubjectChange = name => event => {
        setValues({ ...values, [name]: event.target.value });
        loadChapters(event.target.value);
    };

    const searchUnits = e => {
        e.preventDefault();
        loadUnits();
    }

    return(
        <React.Fragment>
            <Title>
                <span>Course Contents</span>
            </Title>
            <form className={classes.container} onSubmit={searchUnits} autoComplete="off">
                <Grid container spacing={2}>
                    <Grid item xs={12} sm={2}>
                        <TextField
                            id="outlined-select"
                            select
                            label="Course"
                            placeholder="Course"
                            fullWidth
                            value={values.course}
                            onChange={handleChange('course')}
                            SelectProps={{
                                MenuProps: {
                                    className: classes.menu,
                                },
                            }}
                            className={classes.textField}
                            margin="normal"
                            variant="outlined"
                            InputLabelProps={{
                                shrink: true,
                            }}
                        >
                        {courses.map(option => (
                            <MenuItem key={option.value} value={option.value}>
                                {option.label}
                            </MenuItem>
                        ))}
                        </TextField>
                    </Grid>
                    <Grid item xs={12} sm={3}>
                        <TextField
                            id="outlined-select"
                            select
                            label="Subject"
                            placeholder="Subject"
                            fullWidth
                            value={values.subject}
                            onChange={handleSubjectChange('subject')}
                            SelectProps={{
                                MenuProps: {
                                    className: classes.menu,
                                },
                            }}
                            className={classes.textField}
                            margin="normal"
                            variant="outlined"
                            InputLabelProps={{
                                shrink: true,
                            }}
                        >
                        {
                            subjects.map(option => (
                            <MenuItem key={option.value} value={option.value}>
                                {option.label}
                            </MenuItem>
                            ))
                        }
                        </TextField>
                    </Grid>
                    <Grid item xs={12} sm={4}>
                        <TextField
                            id="outlined-select"
                            select
                            label="Chapter"
                            placeholder="Chapter"
                            fullWidth
                            value={values.chapter}
                            onChange={handleChange('chapter')}
                            SelectProps={{
                                MenuProps: {
                                    className: classes.menu,
                                },
                            }}
                            className={classes.textField}
                            margin="normal"
                            variant="outlined"
                            InputLabelProps={{
                                shrink: true,
                            }}
                        >
                            {chapters.map(option => (
                                <MenuItem key={option.value} value={option.value}>
                                    {option.label}
                                </MenuItem>
                            ))}
                        </TextField>
                    </Grid>

                    <Grid align="center" item xs={12} sm={3}>

                        <Grid container direction="column">
                        <Grid>
                        <Link to={`/unit/${0}/${values.chapter}`} style={{ textDecoration: 'none' }}>
                            <Button variant="contained" fullWidth className={classes.button} size="small" color="primary">
                                    Create Content
                            </Button>
                        </Link>
                        </Grid>
                        <Grid> 
                        <Button type="submit" fullWidth className={classes.button} variant="contained" size="small" color="primary">
                            Search
                        </Button>
                        </Grid>
                        
                    </Grid>

                    </Grid>

                </Grid>
            </form>

            <Table size="small">
                <TableHead>
                    <TableRow>
                        <TableCell>S. No</TableCell>
                        <TableCell>Unit</TableCell>
                        <TableCell>Content</TableCell>
                        <TableCell>Actions</TableCell>
                    </TableRow>
                </TableHead>
                <TableBody>
                    {units.map(row => (
                        <TableRow key={row.id}>
                            <TableCell style={{ minWidth: 50, maxWidth: 50 }}>{row.id}</TableCell>
                            <TableCell style={{ minWidth: 50, maxWidth: 50 }}>{row.name}</TableCell>
                            <TableCell style={{ whiteSpace: 'nowrap', overflow: 'hidden', minWidth: 250, maxWidth: 250 }}>
                                {row.content}
                            </TableCell>

                            <TableCell>
                                <Link to={`/unit/${row.id}/${0}`} style={{ textDecoration: 'none' }}>
                                    <Button variant="contained" size="small" color="primary" style={{ margin: 1 }}>
                                        Edit
                                        <EditIcon style={{ fontSize: 15, margin: 1, }} />
                                    </Button>
                                </Link>
                                <Button variant="contained" size="small" color="secondary" style={{ margin: 1 }}>
                                    Delete
                                    <DeleteIcon style={{ fontSize: 15, margin: 1, }} />
                                </Button>
                            </TableCell>
                        </TableRow>
                    ))}

                </TableBody>
            </Table>

        </React.Fragment>
    );

}

export default ContentsList;
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

const UnitForm = (props) => {

    const classes = useStyles();
    const unitId = props.match.params.unitId;
    const chapterId = props.match.params.chapterId;

    const [state, setState] = React.useContext(AppContext);
    const { user } = state;

    const [redirect, setRedirect] = React.useState(false);

    const [values, setValues] = React.useState({
        id: unitId,
        name: "",
        content: "",
        chapterId: chapterId
    });

    const handleChange = name => event => {
        setValues({ ...values, [name]: event.target.value });
    };

    const saveContent = e => {
        e.preventDefault();
        const url = process.env.REACT_APP_API_SERVER_URL+"/units/";
        const headers = { headers: {"Authorization" : `Bearer ${user.token}`} };
        try {
            axios.put(url, values, headers)
                .then(response => response.data)
                .then((data) => {
                    alert('Data Saved');
                    setRedirect(true);
                })
        } catch (error) {
            console.error(`Request error: ${error.message}`);
        }
    };

    const getUnit = () => {
        axios.get(process.env.REACT_APP_API_SERVER_URL+`/units/${unitId}/0`)
            .then(response => response.data)
            .then((data) => {
                setValues({
                    ...values,
                    id: data.id,
                    name: data.name,
                    content: data.content,
                    chapterId: data.chapterId
                });
            })
            .catch(err => console.log(err));
    }

    React.useEffect(() => {
        if (unitId !== undefined && unitId !== null && unitId !== 0) {
            getUnit();
        }

    }, []);

    if (redirect) {
        return <Redirect to='/units' />;
    }

    return (
        <React.Fragment>

            <Paper className={classes.paper}>
                <Typography variant="h6" gutterBottom>
                    Content Form
                </Typography>
                <form className={classes.container} onSubmit={saveContent} autoComplete="off">
                    <Grid container spacing={2}>
                        <Grid item xs={12} sm={10}>
                            <TextField
                                id="outlined-full-width"
                                label="Unit Name"
                                placeholder="Unit Name"
                                multiline
                                fullWidth
                                value={values.name}
                                onChange={handleChange('name')}
                                className={classes.textField}
                                margin="normal"
                                variant="outlined"
                                InputLabelProps={{
                                    shrink: true,
                                }}
                            />
                        </Grid>
                        <Grid item xs={12} sm={10}>
                            <TextField
                                id="outlined-full-width"
                                label="Content"
                                placeholder="Content"
                                multiline
                                fullWidth
                                rows="10"
                                value={values.content}
                                onChange={handleChange('content')}
                                className={classes.textField}
                                margin="normal"
                                variant="outlined"
                                InputLabelProps={{
                                    shrink: true,
                                }}
                            />
                        </Grid>
                        <Grid item xs={12} sm={10}>
                            <div style={{ margin: 10, padding: 10 }} dangerouslySetInnerHTML={{ __html: values.content }} />
                        </Grid>
                        <Grid item xs={12} sm={2}>
                            <div>  </div>
                        </Grid>
                        <Grid item xs={12} sm={2}>
                            <Button type="submit" variant="contained" fullWidth size="medium" color="primary">
                                Save
                            </Button>
                        </Grid>
                        
                        <Grid item xs={12} sm={2}>
                            <Link to={'/units'} style={{ textDecoration: 'none' }}>
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

export default UnitForm;
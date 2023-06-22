import React from 'react';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
import { makeStyles } from '@material-ui/core/styles';

import UnitsList from './UnitsList';
import { AppContext } from '../common/AppContext';

const useStyles = makeStyles(theme => ({
    paper: {
        padding: theme.spacing(2),
        display: 'flex',
        overflow: 'auto',
        flexDirection: 'column',
    }
}));

const Contents = () => {
    const classes = useStyles();

    const [state, setState] = React.useContext(AppContext);
    const { user } = state;

    return (
        <Grid container spacing={3}>
            <Grid item xs={12}>
                <Paper className={classes.paper}>
                    <UnitsList />
                </Paper>
            </Grid>
        </Grid>
    );
}

export default Contents;
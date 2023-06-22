import React from 'react';
import Grid from '@material-ui/core/Grid';
import Paper from '@material-ui/core/Paper';
//import clsx from 'clsx';
import { makeStyles } from '@material-ui/core/styles';

import Title from '../common/Title';

const useStyles = makeStyles(theme => ({
  paper: {
    padding: theme.spacing(2),
    display: 'flex',
    overflow: 'auto',
    flexDirection: 'column',
  },
  fixedHeight: {
    height: 240,
  },
}));

const Dashboard = () => {
  const classes = useStyles();
  //const fixedHeightPaper = clsx(classes.paper, classes.fixedHeight);
    return (
      <React.Fragment>
        <Grid container spacing={3}>
          <Grid item xs={12}>
            <Paper className={classes.paper}>
              <Title>
                <span>Admin Dashboard</span>
              </Title>
              <div> Dashboard </div>
            </Paper>
          </Grid>
        </Grid>
      </React.Fragment>
    );
}

export default Dashboard;
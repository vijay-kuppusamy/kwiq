import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom'
import { makeStyles } from '@material-ui/core/styles';
import CssBaseline from '@material-ui/core/CssBaseline';
import Container from '@material-ui/core/Container';

import HomeAppBar from './HomeAppBar';
import HomeDrawer from './HomeDrawer';
import Copyright from './Copyright';
import Dashboard from '../dashboard/Dashboard';
import Units from '../course/Units';
import UnitForm from '../course/UnitForm';
import Questions from '../question/Questions';
import QuestionForm from '../question/QuestionForm';

import { AppContext } from '../common/AppContext';

const drawerWidth = 240;

const useStyles = makeStyles(theme => ({
  root: {
    display: 'flex',
  },
  toolbar: {
    paddingRight: 24, // keep right padding when drawer closed
  },
  toolbarIcon: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'flex-end',
    padding: '0 8px',
    ...theme.mixins.toolbar,
  },
  appBar: {
    zIndex: theme.zIndex.drawer + 1,
    transition: theme.transitions.create(['width', 'margin'], {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.leavingScreen,
    }),
  },
  appBarShift: {
    marginLeft: drawerWidth,
    width: `calc(100% - ${drawerWidth}px)`,
    transition: theme.transitions.create(['width', 'margin'], {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.enteringScreen,
    }),
  },
  menuButton: {
    marginRight: 36,
  },
  menuButtonHidden: {
    display: 'none',
  },
  title: {
    flexGrow: 1,
  },
  drawerPaper: {
    position: 'relative',
    whiteSpace: 'nowrap',
    width: drawerWidth,
    transition: theme.transitions.create('width', {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.enteringScreen,
    }),
  },
  drawerPaperClose: {
    overflowX: 'hidden',
    transition: theme.transitions.create('width', {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.leavingScreen,
    }),
    width: theme.spacing(7),
    [theme.breakpoints.up('sm')]: {
      width: theme.spacing(9),
    },
  },
  appBarSpacer: theme.mixins.toolbar,
  content: {
    flexGrow: 1,
    height: '100vh',
    overflow: 'auto',
  },
  container: {
    paddingTop: theme.spacing(4),
    paddingBottom: theme.spacing(4),
  },
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

function Home(props) {
  //alert(process.env.REACT_APP_API_SERVER_URL);
  const classes = useStyles();

  const [state, setState] = React.useContext(AppContext);
  const { user } = state;
  const [open, setOpen] = React.useState(false);

  if (JSON.stringify(user) === JSON.stringify({})) {
    setState({user:props.user});
  }

  const handleDrawerOpen = () => {
    setOpen(true);
  };
  const handleDrawerClose = () => {
    setOpen(false);
  };

  

  return (
    <React.Fragment>
    
    <Router>
    <>
    <div className={classes.root}>
      <CssBaseline />
      <HomeAppBar classes={classes} open={open} handleDrawerOpen={handleDrawerOpen} />
      <HomeDrawer classes={classes} open={open} handleDrawerClose={handleDrawerClose} />

      <main className={classes.content}>
        <div className={classes.appBarSpacer} />
        <Container maxWidth="lg" className={classes.container}>  
            <Switch>
              <Route exact path='/dashboard' component={Dashboard} />
              <Route exact path='/units' component={Units} />
              <Route exact path='/questions' component={Questions} />
              <Route exact path='/question/:id' component={QuestionForm} />
              <Route exact path='/unit/:unitId/:chapterId' component={UnitForm} />
            </Switch>
        </Container>
        <Copyright />
      </main>
    </div>
    </>
    </Router>
    </React.Fragment>
  );
}

export default Home;
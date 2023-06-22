import React from 'react';
import Avatar from '@material-ui/core/Avatar';
import Button from '@material-ui/core/Button';
import CssBaseline from '@material-ui/core/CssBaseline';
import TextField from '@material-ui/core/TextField';
import FormControlLabel from '@material-ui/core/FormControlLabel';
import Checkbox from '@material-ui/core/Checkbox';
import Link from '@material-ui/core/Link';
import Grid from '@material-ui/core/Grid';
import Box from '@material-ui/core/Box';
import LockOutlinedIcon from '@material-ui/icons/LockOutlined';
import Typography from '@material-ui/core/Typography';
import { makeStyles } from '@material-ui/core/styles';
import Container from '@material-ui/core/Container';
import axios from 'axios';

import Home from './Home';
import Copyright from './Copyright';

const useStyles = makeStyles(theme => ({
  '@global': {
    body: {
      backgroundColor: theme.palette.common.white,
    },
  },
  paper: {
    marginTop: theme.spacing(8),
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
  },
  avatar: {
    margin: theme.spacing(1),
    backgroundColor: theme.palette.secondary.main,
  },
  form: {
    width: '100%', // Fix IE 11 issue.
    marginTop: theme.spacing(1),
  },
  submit: {
    margin: theme.spacing(3, 0, 2),
  },
}));

const SignIn = () => {
    const classes = useStyles();
    const [user, setUser] = React.useState({});
    const [redirect, setRedirect] = React.useState(false);

    const [values, setValues] = React.useState({
        email: "",
        password: "",
        userRole: "admin"
    });

    const handleChange = name => event => {
        setValues({ ...values, [name]: event.target.value });
    };

    const login = e => {
        e.preventDefault();
        const url = process.env.REACT_APP_API_SERVER_URL+"/login/";
        try {
            axios.post(url, values)
                .then(response => response.data)
                .then((data) => {
                    if (data.error) {
                      alert("You do not have access to this domain. Please use valid login details");
                    } else {
                      setUser(data);
                      setRedirect(true);
                    }
                })
        } catch (error) {
            console.error(`Request error: ${error.message}`);
        }
    };

    if (redirect) {
        return <Home user = {user} />;
    }

  return (
    <Container component="main" maxWidth="xs">
      <CssBaseline />
      <div className={classes.paper}>
        <Avatar className={classes.avatar}>
          <LockOutlinedIcon />
        </Avatar>
        <Typography component="h1" variant="h5">
          Sign in
        </Typography>
        <form className={classes.form} onSubmit={login} noValidate>
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            id="email"
            label="Email Address"
            placeholder="Email Address"
            name="email"
            autoComplete="email"
            onChange={handleChange('email')}
            autoFocus
            InputLabelProps={{
                              shrink: true,
                            }}
          />
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            name="password"
            label="Password"
            placeholder="Password"
            type="password"
            id="password"
            onChange={handleChange('password')}
            autoComplete="current-password"
            InputLabelProps={{
                                shrink: true,
                              }}
          />
          <FormControlLabel
            control={<Checkbox value="remember" color="primary" />}
            label="Remember me"
          />
          <Button
            type="submit"
            fullWidth
            variant="contained"
            color="primary"
            className={classes.submit}
          >
            Sign In
          </Button>
          <Grid container>
            <Grid item xs>
              <Link href="#" variant="body2">
                Forgot password?
              </Link>
            </Grid>
            <Grid item>
              <Link href="#" variant="body2">
                {"Don't have an account? Sign Up"}
              </Link>
            </Grid>
          </Grid>
        </form>
      </div>
      <Box mt={8}>
        <Copyright />
      </Box>
    </Container>
  );
}

export default SignIn;
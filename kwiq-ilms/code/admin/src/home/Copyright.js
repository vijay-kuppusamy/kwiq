import React from 'react';
import Typography from '@material-ui/core/Typography';
import Link from '@material-ui/core/Link';

function Copyright() {
    return (
        <React.Fragment>
        <Typography variant="body2" color="textSecondary" align="center">
            {'Copyright © '}
            <Link color="inherit" href="http://kwiqacademy.in">
                Kwiq Academy
            </Link>{' '}
            {new Date().getFullYear()}
        </Typography>
        <br></br>
        </React.Fragment>
    );
}

export default Copyright;
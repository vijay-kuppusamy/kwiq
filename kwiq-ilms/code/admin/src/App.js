import React from 'react';

import {AppProvider} from './common/AppContext';
import SignIn from './home/SignIn';

import './App.css';

function App() {
  return (
    <React.Fragment>
      <AppProvider>
        <SignIn />
      </AppProvider>  
    </React.Fragment>
  );
}

export default App;
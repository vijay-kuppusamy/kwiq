import React from 'react';

export const AppContext = React.createContext();

export function AppProvider({children}) {

    let intialState = {
        user: {},
        values : {year: "2018", subjectId: "1"}
    };

    const [state, setState] = React.useState(intialState);

    return(
        <AppContext.Provider value={[state, setState]}>
            {children}
        </AppContext.Provider> 
    );
}
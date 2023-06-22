import React from 'react';
import {View} from 'react';

export default class OnePage extends Component {

render() {
return <React.Fragment>
<View style={{ flex: 2, backgroundColor: "royalblue" }} />
<View style={{ flex: 2, backgroundColor: "yellow" }}/>
<View style={{ flex: 2, backgroundColor: "green" }} />
</React.Fragment>

}
}
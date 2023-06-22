import React, { Component } from "react";
import { View, Text } from "react-native";
// import '@fortawesome/fontawesome-free/css/all.min.css';
// import "bootstrap-css-only/css/bootstrap.min.css";
// import "mdbreact/dist/css/mdb.css";
// import { MDBBtn, MDBInput, MDBModal, MDBModalBody, MDBModalHeader, MDBModalFooter, MDBIcon, MDBBadge, MDBContainer, MDBRow, MDBCol} from "mdbreact";

export default class Home extends Component {
  render() {
    return  <View style={{ flex: 1, backgroundColor: "royalblue" }} >
              <Text style={{ flex: 1, fontWeight: '500', alignItems: 'center', justifyContent: 'center' }} >Kwiq Academy Landing for learming !!! </Text>
            </View>
            
{/* <MDBContainer>
            <MDBRow>
            <MDBCol lg="6">Left column> */}

            {/* </MDBCol>
            <MDBCol lg="6">Right column</MDBCol>
            </MDBRow>
        </MDBContainer> */}
        
    
    
  }
}
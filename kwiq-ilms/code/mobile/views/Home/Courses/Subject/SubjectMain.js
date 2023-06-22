import React, { Component } from "react";
import { ActivityIndicator, Text, View, FlatList } from "react-native";
//import courses from './courses.json';

export default class SubjectMain extends Component {

  constructor(props) {
    super(props);
    this.state = {
      isLoading: true,
      subjectlistData: [], 
    }
  }
  componentDidMount() {
    console.log("Course ID : " + this.props.navigation.state.params.courseId);
    let subjectURL = 'http://api.kwiqacademy.in/subjects/' + this.props.navigation.state.params.courseId;
    return fetch(subjectURL)
      .then((response) => response.json())
      .then((responseJson) => {
        console.log("Subject Response json : " + responseJson);
       // just setState here e.g. 
       this.setState({ 
         
        subjectlistData: responseJson,
           isLoading: false,  
       });  
            
      })
      .catch((error) => {
        console.error(error);
      });
  }
  render() {
    
    if (this.state.isLoading) {
      return (
        <View style={{flex: 1, paddingTop: 20}}>
          <ActivityIndicator />
        </View>
      );
    }

    return (
      <View style={{flex: 1, paddingTop: 20}}>
        <FlatList
          data={this.state.subjectlistData}
          renderItem={({item}) =><Text onPress={() => this.props.navigation.navigate("Chapter", {subjectId: item.id})}>{item.name}</Text>}
          keyExtractor={(item, index) => index.toString()}
        />
      </View>
    );
  }

 
  
}
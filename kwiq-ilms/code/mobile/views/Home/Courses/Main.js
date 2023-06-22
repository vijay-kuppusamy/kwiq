import React, { Component } from "react";
import { ActivityIndicator, Text, View, FlatList } from "react-native";
//import courses from './courses.json';

export default class Main extends Component {

  constructor(props) {
    super(props);
    this.state = {
      isLoading: true,
      courseslistData: [], 
    }
  }
  componentDidMount() {
    return fetch('http://api.kwiqacademy.in/courses')
      .then((response) => response.json())
      .then((responseJson) => {
        console.log("course Response json : " + responseJson);
       // just setState here e.g. 
       this.setState({ 
         
        courseslistData: responseJson,
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
          data={this.state.courseslistData}
          renderItem={({item}) =><Text onPress={() => this.props.navigation.navigate("Subject", {courseId: item.id})}>{item.name}</Text>}
          keyExtractor={(item, index) => index.toString()}
        />
      </View>
    );
  }

 
  
}
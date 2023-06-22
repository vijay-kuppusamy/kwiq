import React, { Component } from "react";
import { ActivityIndicator, Text, View, FlatList, WebView, Button } from "react-native";
import Unit from "./Unit";

export default class ChapterMain extends Component {

  constructor(props) {
    super(props);
    this.state = {
      isLoading: true,
      chapterlistData: [], 
    }
  }
  componentDidMount() {
    console.log("Subject ID : " + this.props.navigation.state.params.subjectId);
    let chapterURL = 'http://api.kwiqacademy.in/chapters/' + this.props.navigation.state.params.subjectId;
    return fetch(chapterURL)
      .then((response) => response.json())
      .then((responseJson) => {
        console.log("Chapter Response json : " + responseJson);
       // just setState here e.g. 
       this.setState({ 
         
        chapterlistData: responseJson,
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
    return <View style={{ flex: 1, backgroundColor: "#7ec1f6" }} >

        <FlatList
          data={this.state.chapterlistData}
          renderItem={({item}) =><Text onPress={() => this.props.navigation.navigate("Unit", {chapterId: item.id})}>{item.name}</Text>}
          keyExtractor={(item, index) => index.toString()}
        />
  
      {/* <View style={{ flex: 1, backgroundColor: "#7ec1f6", width:500, height:500 }} >
         <Unit/>
      </View>
      <View style={{ flex: 1, backgroundColor: "#7ec1f6", width:100, height:100 }} >
        <Button
          title="Activity"
          onPress={() => this.props.navigation.navigate("Activity")}
        />
      </View> */}
    </View>;
  }
}
import React, { Component } from "react";
import { View, WebView, Text, ActivityIndicator, FlatList } from "react-native";

export default class Unit extends Component {

    constructor(props) {
        super(props);
        this.state = {
          isLoading: true,
          unitlistData: [], 
        }
      }
      componentDidMount() {
        console.log("Chapter ID : " + this.props.navigation.state.params.chapterId);
        let unitURL = 'http://api.kwiqacademy.in/units/' + this.props.navigation.state.params.chapterId;
        return fetch(unitURL)
          .then((response) => response.json())
          .then((responseJson) => {
            console.log("Unit Response json : " + responseJson);
           // just setState here e.g. 
           this.setState({ 
             
            unitlistData: responseJson,
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

    return <View style={{ flex: 1, backgroundColor: "#7ec1f6", width:500, height:500 }} >
      <FlatList
          data={this.state.unitlistData}
          renderItem={({item}) =>
         
            <Text >{item.name} + {item.content}</Text>
         
          
        }
          keyExtractor={(item, index) => index.toString()}
        />
         <WebView
          ref={ref => (this.webview = ref)}
          source={{ uri: 'https://youtu.be/VtEcBIn8kRo' }}
          onError={console.error.bind(console, 'error')}
          bounces={false}
          onShouldStartLoadWithRequest={() => true}
          javaScriptEnabledAndroid={true}
          startInLoadingState={true}
          style={{ flex: 1 }}
        />
      </View>;
    
  }
}
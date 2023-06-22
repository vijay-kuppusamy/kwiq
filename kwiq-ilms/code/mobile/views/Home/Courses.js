import { createStackNavigator } from "react-navigation";

import Main from "./Courses/Main";
import Subject from "./Courses/Subject";


const CoursesNavigator = createStackNavigator({
  Main: {
    navigationOptions: {
      header: null
    },
    screen: Main
  },

  Subject: {
    navigationOptions: {
      header: null
    },
    screen: Subject
  },


});

CoursesNavigator.navigationOptions = ({ navigation }) => ({
  tabBarVisible: navigation.state.index === 0,
  swipeEnabled: navigation.state.index === 0
});

export default CoursesNavigator;
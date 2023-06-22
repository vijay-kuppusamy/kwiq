import { createStackNavigator } from "react-navigation";

import SubjectMain from "./Subject/SubjectMain";
import Chapter from "./Subject/Chapter";


const SubjectNavigator = createStackNavigator({
  SubjectMain: {
    navigationOptions: {
      header: null
    },
    screen: SubjectMain
  },

  Chapter: {
    navigationOptions: {
      header: null
    },
    screen: Chapter
  }

});

SubjectNavigator.navigationOptions = ({ navigation }) => ({
  tabBarVisible: navigation.state.index === 0,
  swipeEnabled: navigation.state.index === 0
});

export default SubjectNavigator;
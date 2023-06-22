import { createStackNavigator } from "react-navigation";

import ChapterMain from "./ChapterMain";
import Unit from "./Unit";
import Activity from "./Activity"

const ChapterNavigator = createStackNavigator({
  ChapterMain: {
    navigationOptions: {
      header: null
    },
    screen: ChapterMain
  },

  Unit: {
    navigationOptions: {
      header: null
    },
    screen: Unit
  }
  

});

ChapterNavigator.navigationOptions = ({ navigation }) => ({
  tabBarVisible: navigation.state.index === 0,
  swipeEnabled: navigation.state.index === 0
});

export default ChapterNavigator;
import { createMaterialTopTabNavigator } from "react-navigation";

import Home from "../../views/Home/Home";
import Courses from "../../views/Home/Courses";
import Exams from "../../views/Home/Exams";
import Settings from "../../views/Home/Settings";

const CustomTabNavigator = createMaterialTopTabNavigator(
  {
    Home: {
      navigationOptions: {
        tabBarLabel: "Home"
      },
      screen: Home
    },
    Courses: {
      navigationOptions: {
        tabBarLabel: "Courses"
      },
      screen: Courses
    },
    Exams: {
      navigationOptions: {
        tabBarLabel: "Exams"
      },
      screen: Exams
    },
    Settings: {
      navigationOptions: {
        tabBarLabel: "Settings"
      },
      screen: Settings
    }
  },
  {
    tabBarPosition: "bottom"
  }
);

export default CustomTabNavigator;
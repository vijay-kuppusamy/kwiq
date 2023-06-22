import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './theme/theme.dart' as Theme;
import './models/my_app_model.dart';
import './screens/home/home.dart';
import './screens/home/article_screen.dart';
import './screens/user/login.dart';
import './screens/user/signup.dart';
import './screens/user/info.dart';
import './screens/user/edit_account.dart';
import './screens/user/reset_account.dart';
import './screens/user/account.dart';
import './screens/chapter/chapter_home.dart';
import './screens/unit/unit_home.dart';
import './screens/exam/start_exam.dart';
import './screens/exam/user_exam_home.dart';
import './screens/exam/exam_result.dart';
import './screens/exam/end_exam.dart';
import './screens/exam/my_exam_list.dart';
import './screens/unit/content_home.dart';
import './screens/unit/video_home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      builder: (context) => MyAppModel(),
      child: MyApp(),
    ),
  );
}

const HomeRoute = "/";
const ArticleScreenRoute = "/article_screen";
const InfoRoute = "/info";
const LoginRoute = "/login";
const SignupRoute = "/signup";
const EditAccountRoute = "/edit_account";
const ResetAccountRoute = "/reset_account";
const AccountRoute = "/account";
const ChapterHomeRoute = "/chapter_home";
const UnitHomeRoute = "/unit_home";
const StartExamRoute = "/start_exam";
const UserExamHomeRoute = "/user_exam_home";
const ExamResultRoute = "/exam_result";
const EndExamRoute = "/end_exam";
const MyExamListRoute = "/my_exam_list";
const VideoHomeRoute = "/video_home";
const ContentHomeRoute = "/content_home";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kwiq NEET Master',
      onGenerateRoute: _routes(),
      theme: Theme.theme,
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }

  // Routes
  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;

      switch (settings.name) {
        case HomeRoute:
          screen = Home();
          break;
        case LoginRoute:
          screen = Login();
          break;
        case SignupRoute:
          screen = Signup();
          break;
        case EditAccountRoute:
          screen = EditAccount();
          break;
        case ResetAccountRoute:
          screen = ResetAccount();
          break;
        case ArticleScreenRoute:
          screen = ArticleScreen(
            name: arguments['name'],
          );
          break;
        case InfoRoute:
          screen = Info(
            message: arguments['message'],
          );
          break;
        case AccountRoute:
          screen = Account();
          break;
        case ChapterHomeRoute:
          screen = ChapterHome(
              subjectId: arguments['subjectId'],
              subjectName: arguments['subjectName']);
          break;
        case UnitHomeRoute:
          screen = UnitHome(
            subjectId: arguments['subjectId'],
            subjectName: arguments['subjectName'],
            chapterId: arguments['chapterId'],
            chapterName: arguments['chapterName'],
          );
          break;
        case StartExamRoute:
          screen = StartExam(
            userId: arguments['userId'],
            examId: arguments['examId'],
            examName: arguments['examName'],
          );
          break;
        case UserExamHomeRoute:
          screen = UserExamHome();
          break;
        case EndExamRoute:
          screen = EndExam();
          break;
        case ExamResultRoute:
          screen = ExamResult(
            model: arguments['model'],
          );
          break;
        case MyExamListRoute:
          screen = MyExamList(
            userId: arguments['userId'],
          );
          break;
        case VideoHomeRoute:
          screen = VideoHome(
            unitId: arguments['unitId'],
            unitName: arguments['unitName'],
            videoUrl: arguments['videoUrl'],
          );
          break;
        case ContentHomeRoute:
          screen = ContentHome(
            unitId: arguments['unitId'],
            unitName: arguments['unitName'],
          );
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
}

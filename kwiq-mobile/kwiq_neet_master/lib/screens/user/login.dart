import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../main.dart';
import '../../theme/theme.dart' as Theme;
import '../../components/common_app_bar.dart';
import '../../services/user_service.dart';
import '../../models/my_app_model.dart';
import '../../models/user.dart';

class Login extends StatefulWidget {
  //
  Login({Key key}) : super(key: key);
  //
  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  //
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool _autoValidate = false;
  MyAppModel model;

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    //App State Model
    model = Provider.of<MyAppModel>(context);

    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/app-bg.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CommonAppBar("Login"),
          resizeToAvoidBottomInset: false,
          body: buildLoginUI(context),
        )
      ],
    );
  }

  Widget buildLoginUI(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
        margin: new EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            children: <Widget>[
              new SizedBox(
                height: 50.0,
              ),
              new TextFormField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Email",
                    filled: true,
                    fillColor: Theme.Colors.white70,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                onSaved: (String value) {
                  email = value;
                },
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              new SizedBox(
                height: 20.0,
              ),
              new TextFormField(
                validator: _validatePassword,
                obscureText: hidePassword,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Password",
                    filled: true,
                    fillColor: Theme.Colors.white70,
                    errorMaxLines: 3,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    suffixIcon: IconButton(
                      icon: Icon(hidePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    )),
                onSaved: (String value) {
                  password = value;
                },
              ),
              new SizedBox(
                height: 20.0,
              ),
              Container(
                width: _width * 0.70,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.blue,
                  child: MaterialButton(
                    minWidth: double.infinity,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () => _login(context),
                    child: Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: Theme.TextStyles.button,
                    ),
                  ),
                ),
              ),
              new SizedBox(
                height: 20.0,
              ),
              homeLink(context),
              new SizedBox(
                height: 20.0,
              ),
              signUpLink(context),
              new SizedBox(
                height: 20.0,
              ),
              resetLink(context),
            ],
          ),
        ));
  }

  Widget homeLink(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RichText(text: TextSpan(text: 'Go to  ')),
          InkWell(
            child: RichText(
                text: TextSpan(text: 'Home', style: Theme.TextStyles.button)),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeRoute, (Route<dynamic> route) => false);
            },
          )
        ],
      ),
    );
  }

  Widget signUpLink(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RichText(text: TextSpan(text: 'Do not have an account?  ')),
          InkWell(
            child: RichText(
                text:
                    TextSpan(text: 'Sign Up', style: Theme.TextStyles.button)),
            onTap: () {
              Navigator.pushReplacementNamed(context, SignupRoute);
            },
          )
        ],
      ),
    );
  }

  Widget resetLink(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RichText(text: TextSpan(text: 'Forgot your password?  ')),
          InkWell(
            child: RichText(
                text: TextSpan(
                    text: 'Reset Password', style: Theme.TextStyles.button)),
            onTap: () {
              Navigator.pushReplacementNamed(context, ResetAccountRoute);
            },
          )
        ],
      ),
    );
  }

  void _login(BuildContext context) {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      //
      Map data = {"email": email, "password": password};
      UserService.login(data).then((value) {
        Map response = jsonDecode(value);
        var error = response['error'];
        if (error != null) {
          _errorDialog(error);
        } else {
          var user = User.fromJson(response);
          if (model != null) {
            model.setUser(user);
          }
          _loginSuccess(context);
          //_successDialog("message");
        }
      });
      //
    } else {
      setState(() => _autoValidate = true);
    }
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return "Enter Password";
    }
    RegExp regExp =
        new RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,10}$');
    if (regExp.hasMatch(value)) {
      return null;
    }
    return 'password should contain 6 to 10 characters, one small case character, one upper case character and one numer';
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter email address";
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return 'Email is not valid';
  }

  _loginSuccess(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, HomeRoute, (Route<dynamic> route) => false);
  }

  Future<void> _errorDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
                Text('Please correct the details'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

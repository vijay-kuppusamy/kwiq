import 'package:flutter/material.dart';
import 'dart:convert';

import '../../main.dart';
import '../../theme/theme.dart' as Theme;
import '../../components/common_app_bar.dart';
import '../../services/user_service.dart';

class Signup extends StatefulWidget {
  //
  Signup({Key key}) : super(key: key);
  //
  @override
  _SignupState createState() {
    return _SignupState();
  }
}

class _SignupState extends State<Signup> {
  //
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name;
  String email;
  String password;
  bool _autoValidate = false;

  final String emailExp = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";

  @override
  Widget build(BuildContext context) {
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
          appBar: CommonAppBar("Sign Up"),
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
                    hintText: "Name",
                    filled: true,
                    fillColor: Theme.Colors.white70,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
                onSaved: (String value) {
                  name = value;
                },
                validator: _validateName,
              ),
              new SizedBox(
                height: 20.0,
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
                    padding: EdgeInsets.all(10),
                    onPressed: () => _signup(context),
                    child: Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                      style: Theme.TextStyles.button,
                    ),
                  ),
                ),
              ),
              new SizedBox(
                height: 20.0,
              ),
              loginLink(context),
            ],
          ),
        ));
  }

  Widget loginLink(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RichText(text: TextSpan(text: 'Already have an account.. ')),
          InkWell(
            child: RichText(
                text: TextSpan(text: 'Login', style: Theme.TextStyles.button)),
            onTap: () {
              Navigator.pushReplacementNamed(context, LoginRoute);
            },
          )
        ],
      ),
    );
  }

  String _validateName(String value) {
    if (value.length < 6)
      return 'Name must be more than 5 charater';
    else
      return null;
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return "Enter email address";
    }
    RegExp regExp = new RegExp(emailExp);
    if (regExp.hasMatch(value)) {
      return null;
    }
    return 'Email is not valid';
  }

  void _signup(BuildContext context) {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      //
      Map data = {"username": name, "email": email};
      UserService.registerUser(data).then((value) {
        Map response = jsonDecode(value);
        var error = response['error'];
        var message = response['message'];
        if (error != null) {
          _errorDialog(error);
        }
        if (message != null) {
          _signupSuccess(context, message);
        }
      });
      //
    } else {
      setState(() => _autoValidate = true);
    }
  }

  _signupSuccess(BuildContext context, String message) {
    Navigator.pushReplacementNamed(context, InfoRoute,
        arguments: {"message": message});
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

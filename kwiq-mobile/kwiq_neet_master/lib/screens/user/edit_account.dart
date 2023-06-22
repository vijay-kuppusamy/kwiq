import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../main.dart';
import '../../models/my_app_model.dart';
import '../../models/user.dart';
import '../../components/common_app_bar.dart';
import '../../services/user_service.dart';

import '../../theme/theme.dart' as Theme;

class EditAccount extends StatefulWidget {
  //
  EditAccount({Key key}) : super(key: key);
  //
  @override
  _EditAccountState createState() {
    return _EditAccountState();
  }
}

class _EditAccountState extends State<EditAccount> {
  //
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name;
  String email;
  String password;
  String newPassword;
  bool _autoValidate = false;
  bool hidePassword = true;
  bool hideNewPassword = true;
  bool hideConfirmPassword = true;

  final String emailExp = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";

  @override
  Widget build(BuildContext context) {
    //
    final model = Provider.of<MyAppModel>(context);
    final User user = model.getUser();

    name = user?.getName() ?? "";
    email = user?.getEmail() ?? "";

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
          appBar: CommonAppBar("Edit Account"),
          resizeToAvoidBottomInset: false,
          body: buildLoginUI(context, name, email),
        )
      ],
    );
  }

  Widget buildLoginUI(BuildContext context, String _name, String _email) {
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
                initialValue: _name,
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
              new TextFormField(
                validator: _validateNewPassword,
                obscureText: hideNewPassword,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "New Password",
                    filled: true,
                    fillColor: Theme.Colors.white70,
                    errorMaxLines: 3,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    suffixIcon: IconButton(
                      icon: Icon(hideNewPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          hideNewPassword = !hideNewPassword;
                        });
                      },
                    )),
                onSaved: (String value) {
                  newPassword = value;
                },
              ),
              new SizedBox(
                height: 20.0,
              ),
              new TextFormField(
                validator: _validateConfirmPassword,
                obscureText: hideConfirmPassword,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Confirm New Password",
                    filled: true,
                    fillColor: Theme.Colors.white70,
                    errorMaxLines: 3,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    suffixIcon: IconButton(
                      icon: Icon(hideConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          hideConfirmPassword = !hideConfirmPassword;
                        });
                      },
                    )),
              ),
              new SizedBox(
                height: 20.0,
              ),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.blue,
                child: MaterialButton(
                  minWidth: double.infinity,
                  padding: EdgeInsets.all(10),
                  onPressed: () => _save(context, _email),
                  child: Text(
                    "Save",
                    textAlign: TextAlign.center,
                    style: Theme.TextStyles.button,
                  ),
                ),
              ),
              new SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ));
  }

  void _save(BuildContext context, String email) {
    //
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      //
      Map data = {
        "email": email,
        "username": name,
        "password": password,
        "newPassword": newPassword
      };
      UserService.updateUser(data).then((value) {
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

  String _validateName(String value) {
    if (value.length < 6)
      return 'Name must be more than 5 charater';
    else
      return null;
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

  String _validateNewPassword(String value) {
    if (value.isEmpty) {
      return "Enter New Password";
    }
    RegExp regExp =
        new RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,10}$');
    if (regExp.hasMatch(value)) {
      newPassword = value;
      return null;
    }
    return 'password should contain 6 to 10 characters, one small case character, one upper case character and one numer';
  }

  String _validateConfirmPassword(String value) {
    if (value != newPassword) {
      return "New Password and Confirm Password do not match";
    } else {
      return null;
    }
  }

  _signupSuccess(BuildContext context, String message) {
    final model = Provider.of<MyAppModel>(context);
    model.setUser(null);
    Navigator.pushNamedAndRemoveUntil(
        context, InfoRoute, (Route<dynamic> route) => false,
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

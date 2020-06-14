import 'dart:async';
import 'dart:convert';
import 'package:fitr/models/user.dart';
import 'package:fitr/pages/dashboard_page.dart';
import 'package:http/http.dart' as http;
import 'package:fitr/components/custom-input-field.dart';
import 'package:flutter/material.dart';
import 'package:fitr/globals.dart' as globals;

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var _formError = '';

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _vh = MediaQuery.of(context).size.height;
    double _vw = MediaQuery.of(context).size.width;

    return new Scaffold(
        body: Form(
      key: _formKey,
      child: Container(
          width: _vw,
          height: _vh,
          color: globals.primaryColor,
          child: Center(
            child: Container(
                width: _vw * 0.74,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35),
                      child: Text(
                        'Fitr',
                        style: TextStyle(
                            color: globals.primaryTextColor,
                            fontSize: (_vw * 0.74) / 6,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Lobster',
                            letterSpacing: 0.5),
                      ),
                    ),
                    CustomInputField('username', _userNameController, false),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: CustomInputField(
                          'password', _passwordController, true),
                    ),
                    getFormErrors(),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: ButtonTheme(
                        minWidth: 200,
                        height: 50,
                        child: RaisedButton(
                          color: globals.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 8,
                          textColor: globals.primaryTextColor,
                          onPressed: () {
                            if (_formKey.currentState.validate()) login();
                          },
                          child: Text('Login'),
                        ),
                      ),
                    ),
                  ],
                )),
          )),
    ));
  }

  Future<User> authenticate(String userName, String password) async {
    var url = globals.baseApiUrl;

    final response = await http.post(
      '$url/api/users/authenticate',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
          <String, String>{'userName': userName, 'password': password}),
    );

    return (response.statusCode == 201)
        ? User.fromJson(json.decode(response.body))
        : null;
  }

  void login() {
    var userName = _userNameController.text.replaceAll('\t', '');
    var password = _passwordController.text.replaceAll('\t', '');

    authenticate(userName, password).then((User user) => {
          if (user == null)
            setState(() => {_formError = 'Bad username and/or password'}),
          if (user.token != null) goToDashboard(user)
        });
  }

  void goToDashboard(User user) {
    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new DashboardPage(user: user)));
  }

  Widget getFormErrors() {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Text(_formError,
          style: TextStyle(color: globals.errorColor, fontFamily: 'Roboto')),
    );
  }
}

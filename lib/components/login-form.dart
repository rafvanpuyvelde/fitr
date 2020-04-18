import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fitr/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:fitr/components/custom-input-field.dart';
import 'package:flutter/material.dart';

Future<User> authenticate(String userName, String password) async {
  final response = await http.post(
    'https://fa9cec72.ngrok.io/api/users/authenticate',
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

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<User> _futureUser;

  void login() {
    _futureUser =
        authenticate(_userNameController.text, _passwordController.text);

    _futureUser.then((User user) => {
          if (user.token != null)
            {Navigator.pushReplacementNamed(context, '/dashboard')}
        });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Form(
      key: _formKey,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color.fromARGB(255, 29, 29, 29),
          child: Center(
            child: Container(
                width: 400,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35),
                      child: Text(
                        'Fitr',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 254),
                            fontSize: 42,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Lobster',
                            letterSpacing: 0.5),
                      ),
                    ),
                    CustomInputField('username', _userNameController, false),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: CustomInputField(
                          'password', _passwordController, true),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            login();
                          }
                        },
                        child: Text('Login'),
                      ),
                    ),
                  ],
                )),
          )),
    ));
  }
}

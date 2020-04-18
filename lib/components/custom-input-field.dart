import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String _hintText;
  final TextEditingController _loginController;
  final bool _obscureText;

  CustomInputField(this._hintText, this._loginController, this._obscureText);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: 300,
        child: Material(
            elevation: 1,
            child: TextFormField(
              decoration: InputDecoration(
                  fillColor: Color.fromARGB(255, 255, 255, 254),
                  hintText: _hintText,
                  filled: true,
                  border: InputBorder.none),
              style: TextStyle(
                  color: Color.fromARGB(255, 29, 29, 29),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Roboto'),
              obscureText: _obscureText,
              validator: (value) {
                if (value.isEmpty) return 'Please enter your $_hintText';
                return null;
              },
              controller: _loginController,
            )),
      ),
    );
  }
}

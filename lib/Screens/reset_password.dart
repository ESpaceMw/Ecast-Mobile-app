import 'dart:io';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmed = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  _fetchToken() async {}

  @override
  void initState() {
    _fetchToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                    child: Image(
                  image: AssetImage('assets/logos/logo.png'),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _password,
                    validator: (value) {
                      if (value == '') {
                        return 'Please create your new Password';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: whiteColor,
                      ),
                      hintText: "Create a new Password",
                      labelText: "Password",
                      fillColor: whiteColor,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: whiteColor,
                          width: 1.0,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: errorColor,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: errorColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _confirmed,
                    obscureText: true,
                    validator: (value) {
                      if (value == '') {
                        return 'Please confirm your password';
                      } else if (_password.text != _confirmed.text) {
                        return 'Make sure the password match';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: whiteColor,
                      ),
                      hintText: "Please confirm your password",
                      labelText: "Confirm Password",
                      fillColor: whiteColor,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: whiteColor,
                          width: 1.0,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: errorColor,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: errorColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    final form = _formkey.currentState;
                    if (form != null && form.validate()) {
                      // resetPassword();
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.all(14.5),
                    decoration: btnStyle,
                    child: const Text(
                      "Reset Password",
                      textAlign: TextAlign.center,
                      style: textStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future resetPassword() async {
  //   Dialogs.showLoadingDialog(context, keyLoader);
  //   final email = ModalRoute.of(context)!.settings.arguments as String;

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   try {
  //     var response = await http.post(
  //       Uri.parse("$baseUrl/api/v1/auth/password-reset"),
  //       body: {
  //         'token': prefs.getString("reset_token"),
  //         "email": email,
  //         "password": _password.text,
  //       },
  //     );
  //     if (response.statusCode != 400 && response.statusCode == 200) {
  //       var jsonData = convert.jsonDecode(response.body);

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text(
  //             "Password changed successfully changed",
  //           ),
  //         ),
  //       );
  //       Navigator.pushReplacementNamed(context, '/signin');
  //     } else {
  //       Navigator.pop(context);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text(
  //             "Invalid Token",
  //           ),
  //         ),
  //       );
  //     }
  //   } on HttpException {
  //     Navigator.pop(context);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text(
  //           "Internal server error.Contact the system Administrator",
  //         ),
  //       ),
  //     );
  //   } on SocketException {
  //     Navigator.pop(context);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text(
  //           "Please, Check your Internet connection",
  //         ),
  //       ),
  //     );
  //   } catch (e) {
  //     Navigator.pop(context);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text(
  //           "Oops! something went wrong",
  //         ),
  //       ),
  //     );
  //   }
  // }
}

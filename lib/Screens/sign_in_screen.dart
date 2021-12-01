import 'dart:io';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  var url = 'http://10.0.2.2:8000/api/v1/auth/login';
  final GlobalKey<State> keyLoader = GlobalKey<State>();
  final _formkey = GlobalKey<FormState>();
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                    child: Image(
                  image: AssetImage('assets/logos/logo.png'),
                )),
                const SizedBox(
                  height: 15,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == '') {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: whiteColor,
                          ),
                          hintText: "Email",
                          labelText: "Email",
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
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == '') {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        controller: _password,
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: whiteColor,
                          ),
                          suffixIcon: Icon(
                            Icons.visibility,
                            color: whiteColor,
                          ),
                          hintText: "Password",
                          labelText: "Password",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: errorColor,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
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
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          final form = _formkey.currentState;
                          if (form != null && form.validate()) {
                            submitData();
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: const EdgeInsets.all(14.5),
                          decoration: btnStyle,
                          child: const Text(
                            "Sign in",
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/forgotpassword');
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          const Text('Don\'t have an account Yet?'),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/signup'),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: kPrimaryColor,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future submitData() async {
    Dialogs.showLoadingDialog(context, keyLoader);

    try {
      var response = await http.post(Uri.parse(url), body: {
        "email": _email.text,
        "password": _password.text,
      });

      var token = convert.jsonDecode(response.body);
      if (token['message'] != 'These credentials do not match our records' &&
          response.statusCode == 200) {
        // ignore: non_constant_identifier_names
        Map decode_options = convert.jsonDecode(response.body);
        String? user = convert.jsonEncode(decode_options['user']);
        prefs.then((SharedPreferences prefs) {
          return prefs.setString("user", user);
        });
        prefs.then((SharedPreferences prefs) {
          return prefs.setBool("loggedin", true);
        });

        prefs.then((SharedPreferences prefs) {
          return prefs.setString("token", token['access_token']);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Login Successfull!",
              textAlign: TextAlign.center,
              style: snackBarText,
            ),
            backgroundColor: btnColor,
            elevation: 17,
          ),
        );
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "User does not exists",
              textAlign: TextAlign.center,
              style: snackBarText,
            ),
            backgroundColor: btnColor,
            elevation: 17,
          ),
        );
      }
    } on HttpException {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Server error, contact system admistartor",
            textAlign: TextAlign.center,
            style: snackBarText,
          ),
          backgroundColor: btnColor,
          elevation: 17,
        ),
      );
    } on SocketException {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Check your internet connection",
            textAlign: TextAlign.center,
            style: snackBarText,
          ),
          backgroundColor: btnColor,
          elevation: 17,
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Oops! something went wrong",
            textAlign: TextAlign.center,
            style: snackBarText,
          ),
          backgroundColor: btnColor,
          elevation: 17,
        ),
      );
    }
  }
}

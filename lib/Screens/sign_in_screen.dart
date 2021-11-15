import 'package:ecast/Utils/constants.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
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
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
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
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: whiteColor,
                              width: 2,
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
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: whiteColor,
                              width: 2,
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
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(14.5),
                        decoration: const BoxDecoration(
                          color: btnColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8.6,
                            ),
                          ),
                        ),
                        child: const Text(
                          "Sign in",
                          textAlign: TextAlign.center,
                          style: textStyle,
                        ),
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
}

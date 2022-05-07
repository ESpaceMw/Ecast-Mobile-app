import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<State> keyLoader = GlobalKey<State>();
  final _formkey = GlobalKey<FormState>();
  bool _visible = true;

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
                BlocConsumer<UserCubit, UserState>(
                  listener: (context, state) {
                    if (state is LoginError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                        ),
                      );
                    } else if (state is LoginDone) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.msg),
                        ),
                      );
                      Navigator.pushReplacementNamed(context, home);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return Center(
                          child: Column(
                        children: const [
                          CircularProgressIndicator(
                            color: btnColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Signing in into Your Account")
                        ],
                      ));
                    } else {
                      return Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  return 'Please enter your Email';
                                }
                                return null;
                              },
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              enableSuggestions: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
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
                              controller: password,
                              obscureText: _visible,
                              keyboardType: TextInputType.emailAddress,
                              enableSuggestions: true,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: whiteColor,
                                ),
                                suffixIcon: _visible == true
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _visible = false;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.visibility_off,
                                          color: whiteColor,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _visible = true;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.visibility,
                                          color: whiteColor,
                                        ),
                                      ),
                                hintText: "Password",
                                labelText: "Password",
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: errorColor,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: errorColor,
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
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
                                // Navigator.pushNamed(context, home);
                                if (form != null && form.validate()) {
                                  BlocProvider.of<UserCubit>(context).login();
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
                                    Navigator.pushNamed(
                                        context, forgetPassword);
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
                                      Navigator.pushNamed(context, signUp),
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
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

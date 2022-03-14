import 'dart:developer';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<State> keyLoader = GlobalKey<State>();
  final _formkey = GlobalKey<FormState>();

  // Future _prefs() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   print(prefs.getBool("loggedin"));
  //   return prefs.getBool("loggedin");
  // }

  // late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    var data =
        prefs.then((SharedPreferences prefs) => prefs.getBool("loggedin"));
    print(data);
  }

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
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("Error")));
                    }

                    if (state is LoginDone) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login Successfully")));
                      Navigator.pushReplacementNamed(context, home);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return Center(
                          child: Column(
                        children: const [
                          CircularProgressIndicator(),
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
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                              controller: email,
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
                              controller: password,
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

//   Future submitData() async {
//     Dialogs.showLoadingDialog(context, keyLoader);

//     try {
//       var response = await http.post(Uri.parse(url), body: {
//         "email": _email.text,
//         "password": _password.text,
//       });

//       var token = convert.jsonDecode(response.body);
//       if (token['message'] != 'These credentials do not match our records' &&
//           response.statusCode == 200) {
//         // ignore: non_constant_identifier_names
//         Map decode_options = convert.jsonDecode(response.body);
//         String? user = convert.jsonEncode(decode_options['user']);
//         prefs.then((SharedPreferences prefs) {
//           return prefs.setString("user", user);
//         });
//         prefs.then((SharedPreferences prefs) {
//           return prefs.setBool("loggedin", true);
//         });

//         prefs.then((SharedPreferences prefs) {
//           return prefs.setString("token", token['access_token']);
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//               "Login Successfull!",
//               textAlign: TextAlign.center,
//               style: snackBarText,
//             ),
//             backgroundColor: btnColor,
//             elevation: 17,
//           ),
//         );
//         Navigator.pushReplacementNamed(context, '/home');
//       } else {
//         Navigator.pop(context);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//               "User does not exists",
//               textAlign: TextAlign.center,
//               style: snackBarText,
//             ),
//             backgroundColor: btnColor,
//             elevation: 17,
//           ),
//         );
//       }
//     } on HttpException {
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Server error, contact system admistartor",
//             textAlign: TextAlign.center,
//             style: snackBarText,
//           ),
//           backgroundColor: btnColor,
//           elevation: 17,
//         ),
//       );
//     } on SocketException {
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Check your internet connection",
//             textAlign: TextAlign.center,
//             style: snackBarText,
//           ),
//           backgroundColor: btnColor,
//           elevation: 17,
//         ),
//       );
//     } catch (e) {
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Oops! something went wrong",
//             textAlign: TextAlign.center,
//             style: snackBarText,
//           ),
//           backgroundColor: btnColor,
//           elevation: 17,
//         ),
//       );
//     }
//   }
// }

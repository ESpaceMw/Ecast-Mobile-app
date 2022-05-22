import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                BlocConsumer<UserCubit, UserState>(listener: (context, state) {
                  // TODO: implement listener
                }, builder: (context, state) {
                  if (state is ResettingPassword) {
                    return Column(children: const [
                      Text("Resetting your Password"),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(
                        color: btnColor,
                      )
                    ]);
                  } else {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: email,
                            validator: (value) {
                              if (value == '') {
                                return 'Please enter your email';
                              }
                              return null;
                            },
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
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            final form = _formkey.currentState;
                            if (form != null && form.validate()) {
                              BlocProvider.of<UserCubit>(context)
                                  .resetPassword();
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: const EdgeInsets.all(14.5),
                            decoration: btnStyle,
                            child: const Text(
                              "Send Code",
                              textAlign: TextAlign.center,
                              style: textStyle,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

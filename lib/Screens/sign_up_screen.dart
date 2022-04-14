import 'package:ecast/Utils/constants.dart';
import 'package:ecast/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListView(
              children: [
                Center(
                  child: Image(
                    image: const AssetImage(
                      'assets/logos/logo.png',
                    ),
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                ),
                BlocConsumer<UserCubit, UserState>(
                  listener: (context, state) {
                    if (state is LoginError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                        ),
                      );
                    }

                    if (state is RegistrationDone) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.msg),
                        ),
                      );
                      Navigator.pushReplacementNamed(context, home);
                    }
                  },
                  builder: (context, state) {
                    if (state is RegisteringUser) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(
                            color: btnColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Creating Your Account, Please Wait.")
                        ],
                      ));
                    } else {
                      return Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  return 'Please Enter your First name';
                                }
                                return null;
                              },
                              controller: firstname,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: whiteColor,
                                ),
                                hintText: "First Name",
                                labelText: "First Name",
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
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  return 'Please Enter your Last Name';
                                }
                                return null;
                              },
                              controller: lastname,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: whiteColor,
                                ),
                                hintText: "Last Name",
                                labelText: "Last Name",
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
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  return 'Please Enter your Username';
                                }
                                return null;
                              },
                              controller: username,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: whiteColor,
                                ),
                                hintText: "Username",
                                labelText: "Username",
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
                                  return 'Please Enter your Email';
                                }
                                return null;
                              },
                              controller: email,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: whiteColor,
                                ),
                                hintText: "Input your email",
                                labelText: "Email",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: whiteColor,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
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
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  return 'Please Enter your Email';
                                }
                                return null;
                              },
                              controller: birthdate,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.date_range,
                                  color: whiteColor,
                                ),
                                hintText: "yyyy-mm-dd",
                                labelText: "Date of Birth",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: whiteColor,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
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
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: whiteColor,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(
                                  5.0,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: gender,
                                  hint: Text('Gender'),
                                  onChanged: (val) {
                                    setState(() {
                                      gender = val.toString();
                                    });
                                  },
                                  items: gvals.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  return 'Please Enter your Country';
                                }
                                return null;
                              },
                              controller: country,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.location_on,
                                  color: whiteColor,
                                ),
                                hintText: "Country",
                                labelText: "Country",
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
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  return 'Please Enter your city';
                                }
                                return null;
                              },
                              controller: city,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.location_city,
                                  color: whiteColor,
                                ),
                                hintText: "City",
                                labelText: "City",
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
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  return 'Please Enter your Phone number';
                                }
                                return null;
                              },
                              controller: phone,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: whiteColor,
                                ),
                                hintText: "Phone Number",
                                labelText: "Phone Number",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: whiteColor,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
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
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  return 'Please create a new password';
                                }
                                return null;
                              },
                              controller: password,
                              obscureText: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: whiteColor,
                                ),
                                suffixIcon: Icon(
                                  Icons.visibility,
                                  color: whiteColor,
                                ),
                                hintText: "Create a password",
                                labelText: "Password",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: whiteColor,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
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
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  return 'Please Confirm your password';
                                } else if (password.text != confirmed.text) {
                                  return 'Make sure the passwords match';
                                }
                                return null;
                              },
                              controller: confirmed,
                              obscureText: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: whiteColor,
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: errorColor,
                                    width: 2,
                                  ),
                                ),
                                hintText: "Confirm your password",
                                labelText: "Password Confirmation",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: whiteColor,
                                    width: 1.0,
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
                            GestureDetector(
                              onTap: () {
                                final form = _formkey.currentState;
                                if (form != null && form.validate()) {
                                  BlocProvider.of<UserCubit>(context)
                                      .register();
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                padding: const EdgeInsets.all(14.5),
                                decoration: btnStyle,
                                child: const Text(
                                  "Sign Up",
                                  textAlign: TextAlign.center,
                                  style: textStyle,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Already have an account?'),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pushNamed(context, '/signin'),
                                  child: const Text(
                                    'Sign in',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

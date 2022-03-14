import 'package:ecast/Services/api.dart';
import 'package:ecast/Utils/constants.dart';
import 'package:ecast/Utils/loader.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmed = TextEditingController();
  final TextEditingController _phonenumber = TextEditingController();
  var gender = 'M';
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _city = TextEditingController();
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
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == '') {
                            return 'Please Enter yout first name';
                          }
                          return null;
                        },
                        controller: _firstname,
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
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == '') {
                            return 'Please Enter yout Last name';
                          }
                          return null;
                        },
                        controller: _lastname,
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
                        controller: _email,
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
                            return 'Please Enter your Phone number';
                          }
                          return null;
                        },
                        controller: _phonenumber,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: whiteColor,
                          ),
                          hintText: "Enter your Phone Number",
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
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            // color: whiteColor,
                            border: Border.all(color: whiteColor, width: 1.0),
                            borderRadius: BorderRadius.circular(8.7),
                            boxShadow: const [
                              BoxShadow(
                                color: kBackgroundColor,
                                blurRadius: 7.8,
                              )
                            ]),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: gender,
                            onChanged: (data) {
                              setState(() {
                                gender = data.toString();
                              });
                            },
                            items: genders
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    value,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == '') {
                            return 'Please Enter your Country';
                          }
                          return null;
                        },
                        controller: _country,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.flag,
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
                            return 'Please Enter your City';
                          }
                          return null;
                        },
                        controller: _city,
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
                            return 'Please create a new password';
                          }
                          return null;
                        },
                        controller: _password,
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
                          } else if (_password.text != _confirmed.text) {
                            return 'Make sure the passwords match';
                          }
                          return null;
                        },
                        controller: _confirmed,
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
                            registerUser();
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future registerUser() async {
    var firstname = _firstname.text,
        lastname = _lastname.text,
        email = _email.text,
        country = _country.text,
        phonenumber = _phonenumber.text,
        password = _password.text,
        city = _city.text;
    Dialogs.showLoadingDialog(context, keyLoader);
    try {
      // ApiCalls()
      //     .signup(firstname, lastname, email, country, phonenumber, gender,
      //         city, password)
      //     .then(
      //       (user) => {
      //         Navigator.pushReplacementNamed(context, '/signin'),
      //       },
      //     );
      // validate/sanitize data
      // Register logic
    } catch (e) {
      // Handle error
      print(e);
    }
  }
}

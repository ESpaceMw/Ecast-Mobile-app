import 'package:ecast/Utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NetworkService {
  get baseUrl => null;

  // login method
  Future<dynamic> login() async {
    try {
      final data = await http.post(
          Uri.parse(
            "$baseUrl/api/v1/auth/login",
          ),
          body: {
            'email': email.text,
            'password': password.text,
          });

      if (data.statusCode != 200) {
        return "error";
      } else {
        var res = convert.jsonDecode(data.body);
        state().then((prefs) => prefs.setBool("loggedin", true));
        state().then(
            (prefs) => prefs.setString("accessToken", res['access_token']));
        return "Login Successfully";
      }
    } catch (e) {
      return "error";
      // return [];
    }
  }
}

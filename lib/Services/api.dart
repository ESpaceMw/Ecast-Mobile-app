import 'package:ecast/Utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class NetworkService {
  // get baseUrl => null;
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  var url = 'https://jsonplaceholder.typicode.com/photos/?_limit=16';

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
        // ignore: non_constant_identifier_names
        Map decode_options = convert.jsonDecode(data.body);
        String? user = convert.jsonEncode(decode_options['user']);
        prefs.then((SharedPreferences prefs) {
          return prefs.setString("user", user);
        });
        prefs.then((SharedPreferences prefs) {
          return prefs.setBool("loggedin", true);
        });
        prefs.then((SharedPreferences prefs) {
          return prefs.setString("accessToken", res['access_token']);
        });
        return "Login Successfully";
      }
    } catch (e) {
      return "error";
      // return [];
    }
  }

  Future<String> fetchSubscriptions() async {
    final data = await http.get(Uri.parse(url));
    // var res = convert.jsonDecode(data.body);
    return data.body;
  }

  Future<String> fetchCharts() async {
    final data = await http.get(Uri.parse(url));
    return data.body;
  }
}

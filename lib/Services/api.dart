import 'dart:io';

import 'package:ecast/Utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class NetworkService {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  var baseUrl = 'http://159.223.234.130';
  var url = 'https://jsonplaceholder.typicode.com/photos/?_limit=16';

  Future signup() async {
    try {
      var req =
          await http.post(Uri.parse('$baseUrl/rest-auth/registration/'), body: {
        'username': username.text.trim(),
        'password1': password.text.trim(),
        'password2': confirmed.text.trim(),
        'email': email.text,
      });

      if (req.statusCode == 400) {
        var errinfo = convert.jsonDecode(req.body);
        bool keyExists = errinfo.containsKey('email');
        if (keyExists) {
          return {'err': true, 'msg': "User with that account already exists"};
        } else {
          return {'err': true, 'msg': "Your Password is weak"};
        }
      }
      var res = convert.jsonDecode(req.body);
      print(res);
      return {'err': false, 'msg': "Account created Successfully"};
    } on HttpException {
      return {
        'err': true,
        'msg': "Oops! something went wrong, contact system administrator"
      };
    } on SocketException {
      return {
        'err': true,
        'msg': "Error, check your internet connection",
      };
    } catch (e) {
      print(e);
    }
  }

  // login method
  Future<dynamic> login() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = await http.post(
          Uri.parse(
            "$baseUrl/rest-auth/login",
          ),
          body: {
            'email': email.text,
            'password': password.text,
          });

      if (data.statusCode != 200) {
        return {'err': true, 'msg': "Error"};
      } else {
        var res = convert.jsonDecode(data.body);
        // ignore: non_constant_identifier_names
        print(res);
        // Map decode_options = convert.jsonDecode(data.body);
        // String? user = convert.jsonEncode(decode_options['user']);
        // prefs.then((SharedPreferences prefs) {
        //   return prefs.setString("user", user);
        // });
        // prefs.then((SharedPreferences prefs) {
        //   return prefs.setBool("loggedin", true);
        // });
        // prefs.then((SharedPreferences prefs) {
        //   return prefs.setString("accessToken", res['access_token']);
        // });
        return {'err': false, 'msg': "Login Successfully"};
      }
    } on SocketException {
      return {
        'err': true,
        'msg': 'The internet and i are not talking at the moment'
      };
    } on HttpException {
      return {'err': true, 'msg': 'Server error, Contact system admin'};
    } catch (e) {
      return {'err': true, 'msg': "Error, Contact system admin"};
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

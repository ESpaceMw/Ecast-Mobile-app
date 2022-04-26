import 'dart:io';

import 'package:ecast/Utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class NetworkService {
  // final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  var baseUrl = 'http://159.223.234.130';
  var url = 'https://jsonplaceholder.typicode.com/photos/?_limit=16';

  Future signup() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var req =
          await http.post(Uri.parse('$baseUrl/rest-auth/registration/'), body: {
        'username': username.text.trim(),
        'first_name': firstname.text.trim(),
        'last_name': lastname.text.trim(),
        'country': country.text.trim(),
        'city': city.text.trim(),
        'birth_date': birthdate.text,
        'gender': gender,
        'phone_number': phone.text.trim(),
        'password1': password.text.trim(),
        'password2': confirmed.text.trim(),
        'email': email.text,
      });

      if (req.statusCode == 400) {
        var errinfo = convert.jsonDecode(req.body);
        print(errinfo);
        bool keyExists = errinfo.containsKey('email');
        bool userNameExists = errinfo.containsKey('username');
        bool birth = errinfo.containsKey('birth_date');
        if (keyExists) {
          return {'err': true, 'msg': "User with that account already exists"};
        } else if (userNameExists) {
          return {'err': true, 'msg': "User with that username already Exists"};
        } else if (birth) {
          return {'err': true, 'msg': "Date format is wrong"};
        } else {
          return {'err': true, 'msg': "Your Password is weak"};
        }
      }
      var res = convert.jsonDecode(req.body);
      prefs.setBool("loggedin", true);
      prefs.setString("token", res['key']);
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
      var data = await http.post(
          Uri.parse(
            "$baseUrl/rest-auth/login/",
          ),
          body: {
            'username': username.text,
            'password': password.text,
          });
      // print(data);
      if (data.statusCode != 200) {
        print(data.body);
        return {'err': true, 'msg': "Error"};
      } else {
        var res = convert.jsonDecode(data.body);
        // ignore: non_constant_identifier_names
        prefs.setBool("loggedin", true);
        prefs.setString("token", res['key']);
        print(res);
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

  Future logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var request = await http.post(Uri.parse("$baseUrl/rest-auth/logout/"),
          headers: {'Authorization': "Token $token"});
      prefs.setBool("loggedin", false);
      prefs.setString("token", "");
      var res = convert.jsonDecode(request.body);
      print(res);
      return {'err': false, 'msg': "Logged out successfully"};
    } on SocketException {
      return {"err": true, 'type': "net", 'msg': 'Network Error'};
    } on HttpException {
    } catch (e) {
      return {
        "err": true,
        'type': "http",
        "msg": "Server error, contact system admin"
      };
    }
  }

  Future<String> fetchSubscriptions() async {
    final data = await http.get(Uri.parse(url));
    // var res = convert.jsonDecode(data.body);
    return data.body;
  }

  Future fetchCharts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      final request = await http.get(
          Uri.parse("$baseUrl/podcast/api/v1/podcast/chats/"),
          headers: {'Authorization': "Token $token"});
      if (request.statusCode == 400 || request.statusCode == 403) {
        prefs.setBool("loggedin", false);
        prefs.setString("token", "");
        return {
          "err": true,
          'type': 'tkError',
          'msg': 'Your session has expired'
        };
      } else {
        var req2 = await http.get(
            Uri.parse("$baseUrl/podcast/api/v1/listpodcasts/"),
            headers: {'Authorization': "Token $token"});
        var response = convert.jsonDecode(request.body);
        var res2 = convert.jsonDecode(req2.body);
        return {"err": false, 'msg': response, 'pod': res2};
      }
    } on SocketException {
      return {'err': true, 'type': 'net', 'msg': "No internet connection"};
    } on HttpException {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server error, contact system admin'
      };
    } catch (e) {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server error, contact system admin'
      };
    }
  }

  Future fetchUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var request = await http.get(Uri.parse("$baseUrl/rest-auth/user"),
          headers: {'Authorization': 'Token $token'});
      var response = convert.jsonDecode(request.body);
      return {'err': false, 'msg': response};
    } on SocketException {
      return {'err': true, 'msg': "The internet and i are not talking"};
    } on HttpException {
      return {"err": true, 'msg': "Server error, contact system admin"};
    } catch (e) {
      return {"err": true, 'msg': "Server error, contact system admin"};
    }
  }

  Future fetcharts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var request = await http.get(
          Uri.parse("$baseUrl/podcast/api/v1/podcast/filter/?categoty=Arts"),
          headers: {'Authorization': "Token $token"});
      var response = convert.jsonDecode(request.body);
      print(response);
      return {'err': false, 'msg': response};
    } on SocketException {
      return {
        'err': true,
        'type': 'net',
        'msg': "Sorry the internet and i are not speaking"
      };
    } on HttpException {
      return {
        'err': true,
        'type': 'http',
        'msg': "Server error, contact system admin"
      };
    } catch (e) {
      return {
        'err': true,
        'type': 'http',
        'msg': "Server error, contact system admin"
      };
    }
  }

  Future fetchPodcastList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var request = await http.get(
          Uri.parse("$baseUrl/podcast/api/v1/listpodcasts/"),
          headers: {'Authorization': "Token $token"});
      var response = convert.jsonDecode(request.body);
      return {'err': false, 'msg': response};
    } on SocketException {
      return {
        'err': true,
        'msg': "The internet and i are not talking at the moment"
      };
    } on HttpException {
      return {'err': true, 'msg': 'Server Error, Contact system admin'};
    } catch (e) {
      return {'err': true, 'msg': 'Server Error, Contact system admin'};
    }
  }

  Future fetchEpisodes(var id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var request = await http.get(
          Uri.parse("$baseUrl/podcast/api/v1/podcast/$id"),
          headers: {'Authorization': "Token $token"});

      // check status code
      var response = convert.jsonDecode(request.body);
      // print(response['podcast_episodes']);
      return {'err': false, 'msg': response['podcast_episodes']};
    } on SocketException {
      return {'err': true, 'msg': "No internet connection"};
    } on HttpException {
      return {"err": true, 'msg': 'Server Error, contact system admin'};
    } catch (e) {
      return {"err": true, 'msg': 'Server Error, contact system admin'};
    }
  }
}

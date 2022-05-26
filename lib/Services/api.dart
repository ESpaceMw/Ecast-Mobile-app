import 'dart:io';

import 'package:ecast/Utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class NetworkService {
  // var baseUrl = 'http://159.223.234.130';
  var baseUrl = 'http://10.0.2.2:8080';
  // final baseUrl = 'http://192.168.43.141:8080';
  var url = 'https://jsonplaceholder.typicode.com/photos/?_limit=16';

// register a new account
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
      var request = await http.post(
          Uri.parse(
            "$baseUrl/rest-auth/login/",
          ),
          body: {
            'email': email.text,
            'password': password.text,
          });
      if (request.statusCode != 200) {
        var err = convert.jsonDecode(request.body);
        return {
          'err': true,
          'msg': err['non_field_errors'][0],
        };
      } else {
        var res = convert.jsonDecode(request.body);
        // ignore: non_constant_identifier_names
        prefs.setBool("loggedin", true);
        prefs.setString("token", res['key']);
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

  Future resetPassword() async {
    try {
      final request = await http
          .post(Uri.parse('$baseUrl/rest-auth/password/reste'), body: {
        'email': email.text,
      });
      if (request.statusCode != 200) {
        print(request.body);
      } else {
        final response = convert.jsonDecode(request.body);
        print(response);
        return {'err': false, 'msg': response};
      }
    } on SocketException {
      return {
        'err': true,
        'type': 'net',
        'msg': 'Network Error! Check your connection'
      };
    } on HttpException {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server Error! Contact system Admin'
      };
    } catch (e) {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Error! Contact system Admin'
      };
    }
  }

  Future logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      await http.post(Uri.parse("$baseUrl/rest-auth/logout/"),
          headers: {'Authorization': "Token $token"});
      prefs.setBool("loggedin", false);
      prefs.setString("token", "");
      return {'err': false, 'msg': "Logged out successfully"};
    } on SocketException {
      return {"err": true, 'type': "net", 'msg': 'Network Error'};
    } on HttpException {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server error, contact system admin'
      };
    } catch (e) {
      return {
        "err": true,
        'type': "http",
        "msg": "Server error, contact system admin"
      };
    }
  }

  Future fetchSubscriptions() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var request = await http.get(
          Uri.parse('$baseUrl/podcast/api/v1/follow/show_following'),
          headers: {'Authorization': 'Token $token'});
      if (request.statusCode != 200) {
        return {'err': true, 'type': 'tk', 'msg': "Invalid token"};
      } else {
        var res = convert.jsonDecode(request.body);
        return {'err': false, 'msg': res};
      }
    } on SocketException {
      return {
        'err': true,
        'type': 'net',
        'msg': "Failed to make request to host"
      };
    } on HttpException {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server Error, contact system admin'
      };
    } catch (e) {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server Error, contact system admin'
      };
    }
  }

  Future fetchCharts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      final request = await http.get(
          Uri.parse("$baseUrl/podcast/api/v1/podcast/chats/"),
          headers: {'Authorization': "Token $token"});
      if (request.statusCode == 400 ||
          request.statusCode == 403 ||
          request.statusCode == 401) {
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
        final request3 = await http.get(
          Uri.parse('$baseUrl/podcast/api/v1/getAdminPlaylist'),
          headers: {'Authorization': 'Token $token'},
        );
        var response = convert.jsonDecode(request.body);
        var res2 = convert.jsonDecode(req2.body);
        var res3 = convert.jsonDecode(request3.body);
        // print(res3);
        return {"err": false, 'msg': response, 'pod': res2, 'playlists': res3};
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
      print(token);
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
      return {'err': false, 'msg': response['podcast_episodes']};
    } on SocketException {
      return {'err': true, 'msg': "No internet connection"};
    } on HttpException {
      return {"err": true, 'msg': 'Server Error, contact system admin'};
    } catch (e) {
      return {"err": true, 'msg': 'Server Error, contact system admin'};
    }
  }

// subscribe
  Future subscribe(var id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var request = await http
          .post(Uri.parse('$baseUrl/podcast/api/v1/follow/podcast'), headers: {
        'Authorization': 'Token $token'
      }, body: {
        'podcast_id': id,
      });

      if (request.statusCode != 200) {
        return {'err': true, 'type': 'tk', 'msg': "Invalid token"};
      } else {
        var response = convert.jsonDecode(request.body);
        return {'err': false, 'msg': response};
      }
    } on SocketException {
      return {'err': true, 'type': 'net', 'msg': "Failed to make requests"};
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
        'msg': 'System failure, contact admin'
      };
    }
  }

// unsubscribe to podcast
  Future unsubscribe(id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var request = await http.post(
          Uri.parse('$baseUrl/podcast/api/v1/unfollow/podcast'),
          headers: {
            'Authorization': 'Token $token'
          },
          body: {
            'podcast_id': id,
          });
      if (request.statusCode != 200) {
        return {'err': true, 'type': 'tk', 'msg': "Error"};
      } else {
        return {'err': false, 'msg': 'unSubscribed Successfully'};
      }
    } on SocketException {
      return {'err': true, 'type': 'net', 'msg': "Network Error"};
    } on HttpException {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server Error, contact system admin'
      };
    } catch (e) {}
  }

  // Fetch user playlist
  Future fetchPlaylist() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      // await http.get(url)
      final request = await http.get(
        Uri.parse('$baseUrl/'),
        headers: {'Authorization': 'Token $token'},
      );

      if (request.statusCode == 401) {
        prefs.setBool("loggedin", false);
        prefs.setString("token", "");
        return {
          'err': true,
          'type': 'tk',
          'msg': "Invalid token! login again",
        };
      } else {
        final response = convert.jsonDecode(request.body);
        return {'err': false, 'msg': response};
      }
    } on SocketException {
      return {
        'err': true,
        'type': 'net',
        'msg': "Error! check your network connection"
      };
    } on HttpException {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server error! Contact system admin'
      };
    } catch (e) {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server error! Contact system admin'
      };
    }
  }

  //Create user playlist
  Future createPlaylist(title) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      final request = await http.post(
        Uri.parse("$baseUrl/"),
        headers: {
          'Authorization': 'Token $token',
        },
        body: {
          'podcast_title': title,
        },
      );

      if (request.statusCode == 401) {
        return {
          'err': true,
          'type': 'tk',
          'msg': "Invalid token! Please log in again"
        };
      } else {
        final response = convert.jsonDecode(request.body);
        return {'err': false, 'msg': response};
      }
    } on SocketException {
      return {
        'err': true,
        'type': 'net',
        'msg': "Network Error! Check your Connection"
      };
    } on HttpException {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server Error! Contact System Admin'
      };
    } catch (e) {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server Error! Contact System Admin'
      };
    }
  }

  Future fetchAdminPlaylist() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      final request = await http.get(
        Uri.parse('$baseUrl/podcast/api/v1/getAdminPlaylist'),
        headers: {'Authorization': 'Token $token'},
      );

      if (request.statusCode != 200) {
        return {'err': true, 'type': 'tk', 'msg': 'Invalid token login again'};
      } else {
        final response = convert.jsonDecode(request.body);
        return {'err': false, 'msg': response};
      }
    } on SocketException {
      return {
        'err': true,
        'type': 'net',
        'msg': 'Network error, check your connection'
      };
    } on HttpException {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server Error, contact system admin'
      };
    } catch (e) {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Error! Contact system admin'
      };
    }
  }

  // fetch categories
  Future fetchCategories() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      final request = await http.get(
          Uri.parse("$baseUrl/podcast/api/v1/listcategories/"),
          headers: {'Authorization': 'Token $token'});
      if (request.statusCode != 200) {
        return {
          'err': true,
          'type': 'tk',
          'msg': 'Invalid token! Sign in again'
        };
      } else {
        final response = convert.jsonDecode(request.body);
        return {'err': false, 'msg': response};
      }
    } catch (e) {}
  }

  Future filterCategories(title) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      final request = await http.get(
        Uri.parse(
          "$baseUrl/podcast/api/v1/podcast/filter/main?category=$title",
        ),
        headers: {'Authorization': 'Token $token'},
      );

      if (request.statusCode != 200) {
        print(request.body);
      } else {
        final response = convert.jsonDecode(request.body);
        return {'err': false, 'msg': response['podcast_set']};
      }
    } on SocketException {
      return {
        "err": true,
        'type': "net",
        'msg': 'Network Error! Check Your Connection'
      };
    } on HttpException {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server Error! Contact system Admin'
      };
    } catch (e) {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server Error! Contact system Admin'
      };
    }
  }

  Future searchPodcast(title) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      final request = await http.get(
        Uri.parse('$baseUrl/podcast/api/v1/search/podcast?term=$title'),
        headers: {'Authorization': 'Token $token'},
      );
      if (request.statusCode != 200) {
        print(request.body);
      } else {
        final response = convert.jsonDecode(request.body);
        return {'err': false, 'msg': response};
      }
    } on SocketException {
      return {
        'err': true,
        'type': 'net',
        'msg': 'Network Error! Check your Connection'
      };
    } on HttpException {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server Error! Contact system admin'
      };
    } catch (e) {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server Error! Contact system admin'
      };
    }
  }

  Future userPlaylist() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
    } on SocketException {
      return {
        'err': true,
        'type': 'net',
        'msg': 'Network Error! Check your connection'
      };
    } on HttpException {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server Error! Contact System Admin'
      };
    } catch (e) {
      return {
        'err': true,
        'type': 'http',
        'msg': 'Server Error! Contact System Admin'
      };
    }
  }
}

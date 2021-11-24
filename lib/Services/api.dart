import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

var url = 'https://ecast.espacemw.com';

class ApiCalls {
  signin(email, password) async {
    try {
      var response =
          await http.post(Uri.parse("$url/api/v1/auth/login"), body: {
        "email": email,
        "password": password,
      });

      var jsonData = convert.jsonDecode(response.body);
      return jsonData;
    } catch (e) {
      print(e);
    }
  }

  signup(firstname, lastname, email, country, phonenumber, password) async {
    try {
      var response =
          await http.post(Uri.parse('$url/api/v1/auth/register'), body: {
        "first_name": firstname,
        'last_name': lastname,
        "email": email,
        "country": country,
        "phone_number": phonenumber,
        "password": password,
      });
      var jsonData = convert.jsonDecode(response.body);
      return jsonData;
    } catch (e) {
      print(e);
    }
  }
}

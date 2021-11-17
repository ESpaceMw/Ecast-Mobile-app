import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

var url = 'https://api.ecast.espacemw.com/api/v1/auth/login';

class ApiCalls {
  signin(email, password) async {
    try {
      var response = await http
          .post(Uri(host: url), body: {"email": email, "password": password});

      var jsonData = convert.jsonDecode(response.body);
      return jsonData;
    } catch (e) {
      print(e);
    }
  }
}

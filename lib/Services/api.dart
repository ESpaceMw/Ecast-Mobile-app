import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

var url = 'http://10.0.2.2:8000';

class ApiCalls {
  signup(firstname, lastname, email, country, phonenumber, gender, city,
      password) async {
    try {
      var response =
          await http.post(Uri.parse('$url/api/v1/auth/register'), body: {
        "first_name": firstname,
        'last_name': lastname,
        "email": email,
        "country": country,
        "phone_number": phonenumber,
        "password": password,
        "gender": gender,
        "date_of_birth": "2001-01-31",
        "city": city,
      });
      var jsonData = convert.jsonDecode(response.body);
      return jsonData;
    } catch (e) {
      print(e);
    }
  }
}

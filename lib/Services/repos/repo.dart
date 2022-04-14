import 'package:ecast/Models/channels.dart';
import 'package:ecast/Models/charts.dart';
import 'package:ecast/Models/user_model.dart';
import 'package:ecast/Services/api.dart';
import 'dart:convert' as convert;

class Repository {
  final NetworkService networkService;

  Repository({required this.networkService});

  Future signin() async {
    return networkService.login();
  }

  Future SignUp() async {
    return networkService.signup();
  }

  Future fetchUser() async {
    return networkService.fetchUser();
  }

  Future logout() async {
    return networkService.logout();
  }

  List<Channels> parsePhotos(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Channels>((json) => Channels.fromJson(json)).toList();
  }

  Future<List<Channels>> fetchSubscription() async {
    final data = await networkService.fetchSubscriptions();
    return parsePhotos(data);
  }

  List<Charts> parseCharts(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Charts>((json) => Charts.fromJson(json)).toList();
  }

  Future fetchCharts() async {
    final data = await networkService.fetchCharts();
    // return parseCharts(data);
    return data;
  }

  Future arts() async {
    final data = await networkService.fetcharts();
    return data;
  }
}

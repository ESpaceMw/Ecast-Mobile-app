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

  Future fetchSubscription() async {
    final data = await networkService.fetchSubscriptions();
    return data;
  }

  Future fetchCharts() async {
    final data = await networkService.fetchCharts();
    // return parseCharts(data);
    return data;
  }

  Future podcasts() async {
    final data = await networkService.fetchPodcastList();
    return data;
  }

  Future episodes(var id) async {
    final data = await networkService.fetchEpisodes(id);
    return data;
  }

  Future arts() async {
    final data = await networkService.fetcharts();
    return data;
  }

  Future subscribe(var id) async {
    final data = await networkService.subscribe(id);
    return data;
  }

  Future singleEp() async {}
}

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

  Future fetchSubscription() async {
    final data = await networkService.fetchSubscriptions();
    return data;
  }

  Future fetchCharts() async {
    final data = await networkService.fetchCharts();
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

  Future subscribes(var id) async {
    final data = await networkService.subscribe(id);
    return data;
  }

  Future unsubscribe(id) async {
    final data = await networkService.unsubscribe(id);
    return data;
  }

  Future fetchPlaylist() async {
    final playlist = await networkService.fetchPlaylist();
    return playlist;
  }

  Future createPlaylist(title) async {
    final data = await networkService.createPlaylist(title);
    return data;
  }

  Future cats() async {
    final categories = await networkService.fetchCategories();
    return categories;
  }

  Future filter(title) async {
    final filteredCats = await networkService.filterCategories(title);
    return filteredCats;
  }

  Future singleEp() async {}
}

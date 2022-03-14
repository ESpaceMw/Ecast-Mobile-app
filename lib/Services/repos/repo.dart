import 'package:ecast/Models/user_model.dart';
import 'package:ecast/Services/api.dart';

class Repository {
  final NetworkService networkService;

  Repository({required this.networkService});

  Future signin() async {
    return networkService.login();
  }
}

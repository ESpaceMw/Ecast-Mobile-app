import 'package:audio_service/audio_service.dart';
import 'package:ecast/Utils/backgroundService.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerSingleton<AudioHandler>(await initAudioService());
}

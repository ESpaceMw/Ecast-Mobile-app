import 'package:ecast/Utils/Notifiers/progressNotifier.dart';
import 'package:ecast/Utils/Notifiers/repeat_Btn_Notifier.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';
import 'getter.dart';

enum ButtonState { playing, paused, loading }

class AudioManager {
  final _audioHandler = getIt<AudioHandler>();
  // ignore: non_constant_identifier_names
  final CurrentSongTitle = ValueNotifier<String>("");
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final repeatNotifier = RepeatBtnNotifier();
  final progressNotifier = ProgressNotifier();
  static const url =
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3";
  late AudioPlayer _audioPlayer;

  late ConcatenatingAudioSource _playlist;

  void _init(source, index) async {
    // _audioPlayer = AudioPlayer();
    await _loadInitialPlaylist(source, index);
    _listenPlaybackState();
    _listenToTotalDuration();
    _listenToBufferedPosition();
    _listenToCurrentPosition();
    _listenToSongChange();
    // _setupPodcastPlalylist(source, index);
    // _listenPlayerState();
    // _changeInPlayerPosition();
    // _changeInBufferPosition();
    // _changeInDurationPosition();
    // _sequenceChangelistener();
  }

  void init(source, index) {}

  Future<void> _loadInitialPlaylist(source, index) async {
    final mediaItems = source.map<MediaItem>((podcast) {
      return MediaItem(
          id: podcast['id'].toString(),
          title: podcast['name'],
          extras: {
            'url': podcast['audio'],
          });
    }).toList();

    _audioHandler.addQueueItems(mediaItems);
  }

  void _listenPlaybackState() {
    _audioHandler.playbackState.listen((state) {
      final playing = state.playing;
      final processingState = state.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        btnNotifier.value = ButtonState.loading;
      } else if (!playing) {
        btnNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        btnNotifier.value = ButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void seek(Duration position) => _audioHandler.seek(position);

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenToBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );
    });
  }

  void _listenToSongChange() {
    _audioHandler.mediaItem.listen((event) {
      CurrentSongTitle.value = event?.title ?? '';
      _updateSkipButtons();
    });
  }

  void _updateSkipButtons() {
    final mediItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;
    if (playlist.length < 2 || mediItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediItem;
      isLastSongNotifier.value = playlist.last == mediItem;
    }
  }

  void repeat() {
    repeatNotifier.nextState();
    final repeatMode = repeatNotifier.value;
    switch (repeatMode) {
      case RepeatState.off:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case RepeatState.repeatSong:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
    }
  }

  AudioManager(source, index) {
    _init(source, index);
  }

  void play() => _audioHandler.play();
  void pause() => _audioHandler.pause();

  void onPreviousBtn() => _audioHandler.skipToPrevious();

  void onNextBtn() => _audioHandler.skipToNext();

  // void play() {
  //   _audioPlayer.play();
  // }

  // void pause() {
  //   _audioPlayer.pause();
  // }

  // void seek(Duration position) {
  //   _audioPlayer.seek(position);
  // }

  // void _setupPodcastPlalylist(source, index) async {
  //   print(source);
  //   _playlist = ConcatenatingAudioSource(
  //     children: source.map<AudioSource>((data) {
  //       return AudioSource.uri(
  //         Uri.parse(
  //           data['audio'],
  //         ),
  //         tag: data['name'],
  //       );
  //     }).toList(),
  //   );
  //   await _audioPlayer.setAudioSource(_playlist, initialIndex: index);
  // }

  // void _sequenceChangelistener() {
  //   _audioPlayer.sequenceStateStream.listen((sequence) {
  //     if (sequence == null) return;

  //     final currentItem = sequence.currentSource;
  //     final title = currentItem?.tag as String;
  //     CurrentSongTitle.value = title;
  //     final playlist = sequence.effectiveSequence;

  //     if (playlist.isEmpty || currentItem == null) {
  //       isFirstSongNotifier.value = true;
  //       isLastSongNotifier.value = true;
  //     } else {
  //       isFirstSongNotifier.value = playlist.first == currentItem;
  //       isLastSongNotifier.value = playlist.last == currentItem;
  //     }
  //   });
  // }

  // void _listenPlayerState() {
  //   _audioPlayer.playerStateStream.listen((playerState) {
  //     final isPlaying = playerState.playing;
  //     final processingState = playerState.processingState;
  //     if (processingState == ProcessingState.loading ||
  //         processingState == ProcessingState.buffering) {
  //       btnNotifier.value = ButtonState.loading;
  //     } else if (!isPlaying) {
  //       btnNotifier.value = ButtonState.paused;
  //     } else if (processingState != ProcessingState.completed) {
  //       btnNotifier.value = ButtonState.playing;
  //     } else {
  //       _audioPlayer.seek(Duration.zero);
  //       _audioPlayer.pause();
  //     }
  //   });
  // }

  // void _changeInPlayerPosition() {
  //   _audioPlayer.positionStream.listen((position) {
  //     final oldState = ProgressNotifier.value;
  //     ProgressNotifier.value = ProgressBarState(
  //       current: position,
  //       buffered: oldState.buffered,
  //       total: oldState.total,
  //     );
  //   });
  // }

  // void _changeInBufferPosition() {
  //   _audioPlayer.bufferedPositionStream.listen((position) {
  //     final oldState = ProgressNotifier.value;
  //     ProgressNotifier.value = ProgressBarState(
  //       current: oldState.current,
  //       buffered: position,
  //       total: oldState.total,
  //     );
  //   });
  // }

  // void _changeInDurationPosition() {
  //   _audioPlayer.durationStream.listen((position) {
  //     final oldState = ProgressNotifier.value;
  //     ProgressNotifier.value = ProgressBarState(
  //       current: oldState.current,
  //       buffered: oldState.buffered,
  //       total: position ?? Duration.zero,
  //     );
  //   });
  // }

  // void onRepeatlistener() {
  //   repeatNotifier.nextState();
  //   switch (repeatNotifier.value) {
  //     case RepeatState.off:
  //       _audioPlayer.setLoopMode(LoopMode.off);
  //       break;
  //     case RepeatState.repeatSong:
  //       _audioPlayer.setLoopMode(LoopMode.one);
  //       break;
  //     case RepeatState.repeatPlaylist:
  //       _audioPlayer.setLoopMode(LoopMode.all);
  //       break;
  //   }
  // }

  // void dispose() {
  //   _audioPlayer.dispose();
  // }

  // final ProgressNotifier = ValueNotifier<ProgressBarState>(
  //   ProgressBarState(
  //     current: Duration.zero,
  //     buffered: Duration.zero,
  //     total: Duration.zero,
  //   ),
  // );

  final btnNotifier = ValueNotifier<ButtonState>(ButtonState.paused);
}

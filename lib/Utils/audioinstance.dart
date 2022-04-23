import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ProgressBarState {
  final Duration current;
  final Duration buffered;
  final Duration total;

  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });
}

enum ButtonState { playing, paused, loading }

class AudioManager {
  // ignore: non_constant_identifier_names
  final CurrentSongTitle = ValueNotifier<String>("");
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final isLastSongNotifier = ValueNotifier<bool>(true);
  static const url =
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3";
  late AudioPlayer _audioPlayer;

  late ConcatenatingAudioSource _playlist;

  void _init(source) async {
    _audioPlayer = AudioPlayer();
    _setupPodcastPlalylist(source);
    _listenPlayerState();
    _changeInPlayerPosition();
    _changeInBufferPosition();
    _changeInDurationPosition();
    _sequenceChangelistener();
  }

  AudioManager(source) {
    _init(source);
  }

  void play() {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void _setupPodcastPlalylist(source) async {
    _playlist = ConcatenatingAudioSource(
      children: source.map<AudioSource>((data) {
        return AudioSource.uri(
          Uri.parse(
            data['audio'],
          ),
          tag: data['name'],
        );
      }).toList(),
    );
    await _audioPlayer.setAudioSource(_playlist);
  }

  void _sequenceChangelistener() {
    _audioPlayer.sequenceStateStream.listen((sequence) {
      if (sequence == null) return;

      final currentItem = sequence.currentSource;
      final title = currentItem?.tag as String;
      CurrentSongTitle.value = title;
      final playlist = sequence.effectiveSequence;

      if (playlist.isEmpty || currentItem == null) {
        isFirstSongNotifier.value = true;
        isLastSongNotifier.value = true;
      } else {
        isFirstSongNotifier.value = playlist.first == currentItem;
        isLastSongNotifier.value = playlist.last == currentItem;
      }
    });
  }

  void _listenPlayerState() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        btnNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        btnNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        btnNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });
  }

  void _changeInPlayerPosition() {
    _audioPlayer.positionStream.listen((position) {
      final oldState = ProgressNotifier.value;
      ProgressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _changeInBufferPosition() {
    _audioPlayer.bufferedPositionStream.listen((position) {
      final oldState = ProgressNotifier.value;
      ProgressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: position,
        total: oldState.total,
      );
    });
  }

  void _changeInDurationPosition() {
    _audioPlayer.durationStream.listen((position) {
      final oldState = ProgressNotifier.value;
      ProgressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: position ?? Duration.zero,
      );
    });
  }

  void onPreviousBtn() {
    _audioPlayer.seekToPrevious();
  }

  void onNextBtn() {
    _audioPlayer.seekToNext();
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  final ProgressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );

  final btnNotifier = ValueNotifier<ButtonState>(ButtonState.paused);
}

// ignore_for_file: non_constant_identifier_names

import 'package:ecast/Utils/Notifiers/progressNotifier.dart';
import 'package:ecast/Utils/Notifiers/repeat_Btn_Notifier.dart';
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'getter.dart';

enum ButtonState { playing, paused, loading }

class AudioManager {
  final _audioHandler = getIt<AudioHandler>();
  final CurrentSongTitle = ValueNotifier<String>("");
  final CurrentArtist = ValueNotifier<String>("");
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final repeatNotifier = RepeatBtnNotifier();
  final progressNotifier = ProgressNotifier();
  final artWork = ValueNotifier<String>("");

  void _init(source, index, cover, author) async {
    await _loadInitialPlaylist(source, index, cover, author);
    _listenPlaybackState();
    _listenToTotalDuration();
    _listenToBufferedPosition();
    _listenToCurrentPosition();
    _listenToSongChange();
    _listenToArtistChange();
    _listenToArtChange();
  }

  void init(source, index) {}

  Future<void> _loadInitialPlaylist(source, index, cover, author) async {
    final mediaItems = source.map<MediaItem>((podcast) {
      return MediaItem(
          id: podcast['id'].toString(),
          title: podcast['name'],
          artUri: Uri.parse(cover),
          artist: author ?? '',
          extras: {
            'url': podcast['audio'],
            'art': cover,
          });
    }).toList();

    _audioHandler.addQueueItems(mediaItems);
    // _audioHandler.skipToQueueItem(index);
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

  void _listenToArtistChange() {
    _audioHandler.mediaItem.listen((event) {
      CurrentArtist.value = event?.artist ?? '';
    });
  }

  void _listenToArtChange() {
    _audioHandler.mediaItem.listen((event) {
      artWork.value = event?.extras!['art'];
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

  AudioManager(source, index, cover, author) {
    _init(source, index, cover, author);
  }

  void play() => _audioHandler.play();
  void pause() => _audioHandler.pause();

  void onPreviousBtn() => _audioHandler.skipToPrevious();

  void onNextBtn() => _audioHandler.skipToNext();

  final btnNotifier = ValueNotifier<ButtonState>(ButtonState.paused);
}

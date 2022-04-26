// ignore_for_file: file_names

import 'package:flutter/material.dart';

class RepeatBtnNotifier extends ValueNotifier<RepeatState> {
  RepeatBtnNotifier() : super(_initialValue);
  static const _initialValue = RepeatState.off;

  void nextState() {
    final next = (value.index + 1) % RepeatState.values.length;
    value = RepeatState.values[next];
  }
}

enum RepeatState { off, repeatSong, repeatPlaylist }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';

import 'package:just_audio_background/just_audio_background.dart';

void main() async {
  if (Env.radioFeature.isEnabled || Env.podcastFeature.isEnabled) {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.amarehotels.amare_music.radio',
      androidNotificationChannelName: 'Amàre Radio',
      androidNotificationOngoing: true,
    );
  }
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const App());
}

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'package:rxdart/rxdart.dart';

class PlayerStatus {
  final String? stream;
  final bool isPlaying;
  final Duration currentTime;

  PlayerStatus(this.stream, this.isPlaying, this.currentTime);
}

class PlayableSource {
  final String id, title, subtitle, streamUrl;
  final String? coverUrl;

  PlayableSource(
      this.id, this.title, this.subtitle, this.streamUrl, this.coverUrl);

  UriAudioSource toAudioSource() {
    return AudioSource.uri(
      Uri.parse(streamUrl),
      tag: MediaItem(
        id: id,
        album: title,
        title: subtitle,
        artUri: coverUrl != null ? Uri.parse(coverUrl!) : null,
      ),
    );
  }
}

class AMPLayer {
  static final shared = AMPLayer._privateConstructor();

  final _player = AudioPlayer();
  final PublishSubject<PlayerStatus> publishStatus = PublishSubject();

  String? _stream;

  get isPlaying {
    return _player.playing;
  }

  get currentStream {
    return _stream;
  }

  AMPLayer._privateConstructor() {
    registerAudioInterruptionsObserver();
  }

  void registerAudioInterruptionsObserver() async {
    final session = await AudioSession.instance;

    session.interruptionEventStream.listen((event) {
      if (event.begin) {
        switch (event.type) {
          case AudioInterruptionType.duck:
            pause();
            break;
          case AudioInterruptionType.pause:
          case AudioInterruptionType.unknown:
            pause();
            break;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.duck:
            play();
            break;
          case AudioInterruptionType.pause:
            play();
            break;
          case AudioInterruptionType.unknown:
            break;
        }
      }
    });
  }

  void registerPlayerEventsObserver() async {
    _player.playerStateStream.listen((state) {
      report();
      debugPrint(state.processingState.toString());
      switch (state.processingState) {
        case ProcessingState.idle:
          break;
        case ProcessingState.loading:
          break;
        case ProcessingState.buffering:
          break;
        case ProcessingState.ready:
          break;
        case ProcessingState.completed:
          break;
      }
    });

    _player.positionStream
        .debounceTime(const Duration(milliseconds: 100))
        .listen((position) {
      report();
    });

    _player.durationStream.listen((totalDuration) {
      debugPrint(totalDuration.toString());
    });
  }

  setupPlayer(PlayableSource source, bool autoplay) {
    _stream = source.streamUrl;
    registerPlayerEventsObserver();

    if (autoplay) {
      replaceStream(source);
    }
  }

  replaceStream(PlayableSource source) async {
    _stream = source.streamUrl;

    _player.pause();
    await _player.setAudioSource(source.toAudioSource());
    _player.play();

    report();
  }

  play() {
    _player.play();
    report();
  }

  pause() {
    _player.pause();
    report();
  }

  togglePlay() {
    isPlaying ? _player.pause() : _player.play();
    report();
  }

  seekTo(Duration position) {
    _player.seek(position);
  }

  report() {
    publishStatus.add(PlayerStatus(_stream, isPlaying, _player.position));
  }
}

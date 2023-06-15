import 'dart:async';

import 'package:amare/helpers/circle_painter.dart';
import 'package:amare/providers/hearth_this_api/models/track.dart';
import 'package:amare/providers/local_storage/local_storage.dart';
import 'package:amare/sections/components/am_background.dart';
import 'package:amare/services/am_player.dart';
import 'package:amare/theme/app_theme.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

class PodcastPlayerArguments {
  final Track track;

  PodcastPlayerArguments(this.track);
}

class PodcastPlayerScreen extends StatefulWidget {
  static String routerName = 'PodcastPlayerScreen';
  const PodcastPlayerScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PodcastPlayerScreenState();
}

class _PodcastPlayerScreenState extends State<PodcastPlayerScreen> {
  final player = AMPLayer.shared;
  PlayerStatus? playerStatus;
  StreamSubscription? disposable;

  late Track track;
  bool isPlaying = false;
  Duration currentProgress = const Duration(seconds: 0);

  @override
  void initState() {
    super.initState();

    disposable = AMPLayer.shared.publishStatus.listen((status) {
      if (mounted) {
        setState(() {
          isPlaying = status.isPlaying && (status.stream == track.stream_url);
          if (status.stream == track.stream_url) {
            currentProgress = status.currentTime;
          }
        });
      }
    });

    player.report();
  }

  @override
  void dispose() {
    disposable?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as PodcastPlayerArguments;

    track = args.track;

    return Scaffold(
      body: Stack(children: [
        const AMBackground(),
        Container(
          padding: const EdgeInsets.only(top: 48, bottom: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      iconSize: 32,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: track.image_large != null &&
                                track.image_large!.startsWith("http")
                            ? Image.network(
                                track.image_large!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/placeholder.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          track.author.name,
                          style: TextStyle(
                            color: AppTheme.accent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        AppTheme.spacerV8,
                        Text(
                          track.name,
                          style: TextStyle(
                            color: AppTheme.accent,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    AppTheme.spacerV32,
                    Center(
                      child: Stack(children: [
                        CustomPaint(
                          painter: CirclePainter(),
                        ),
                        IconButton(
                            iconSize: 50,
                            onPressed: () {
                              if (isPlaying) {
                                AMPLayer.shared.togglePlay();
                              } else {
                                if (AMPLayer.shared.currentStream ==
                                    track.stream_url) {
                                  AMPLayer.shared.togglePlay();
                                } else {
                                  AMPLayer.shared.replaceStream(PlayableSource(
                                      track.name,
                                      track.author.name,
                                      track.name,
                                      track.stream_url!,
                                      track.image_large));
                                  LocalStorageProvider.saveRecentlyPlayed(
                                      track);
                                }
                              }
                            },
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: AppTheme.accent,
                            )),
                      ]),
                    ),
                    AppTheme.spacerV32,
                    ProgressBar(
                      barCapShape: BarCapShape.round,
                      progress: currentProgress,
                      buffered: const Duration(milliseconds: 0),
                      total: Duration(seconds: track.duration_secods),
                      onSeek: (position) {
                        if (isPlaying) {
                          player.seekTo(position);
                        }
                      },
                      thumbColor: AppTheme.accent,
                      baseBarColor: AppTheme.accent.withAlpha(50),
                      progressBarColor: AppTheme.accent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Powered by",
                  style: TextStyle(
                    color: AppTheme.accent,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "BALEARICA MUSIC",
                  style: TextStyle(
                    color: AppTheme.accent,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
        )
      ]),
      backgroundColor: Colors.white,
    );
  }
}

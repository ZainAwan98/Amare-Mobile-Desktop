import 'dart:async';

import 'package:amare/app.dart';
import 'package:amare/helpers/circle_painter.dart';
import 'package:amare/sections/components/am_background.dart';
import 'package:amare/sections/components/upper_bar.dart';
import 'package:amare/services/am_player.dart';
import 'package:amare/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final player = AMPLayer.shared;
  var isRadioPlaying = false;
  StreamSubscription? disposable;

  @override
  void initState() {
    super.initState();

    disposable = AMPLayer.shared.publishStatus.listen((status) {
      if (mounted) {
        setState(() {
          isRadioPlaying = status.isPlaying && status.stream == Env.radioStream;
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
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(children: [
        const AMBackground(),
        Container(
          padding: EdgeInsets.only(
              top: mediaHeight * 0.05, bottom: mediaHeight * 0.01),
          child: Column(
            children: [
              AMUpperBar(
                title: "Player",
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              Container(
                padding: EdgeInsets.only(
                    left: mediaWidth * 0.03,
                    right: mediaHeight * 0.020,
                    bottom: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset('assets/images/placeholder.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: mediaHeight * 0.01),
                    Text(
                      "Amàre Music",
                      style: TextStyle(
                        color: AppTheme.accent,
                        fontSize: 37.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "24 hour full music",
                      style: TextStyle(
                        color: AppTheme.accent,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    AppTheme.spacerV32,
                    AppTheme.spacerV12,
                    Stack(
                      children: [
                        CustomPaint(
                          painter: CirclePainter(),
                        ),
                        IconButton(
                            iconSize: 50,
                            onPressed: () async {
                              if (isRadioPlaying) {
                                player.togglePlay();
                              } else {
                                if (AMPLayer.shared.currentStream ==
                                    Env.radioStream) {
                                  player.togglePlay();
                                } else {
                                  AMPLayer.shared.replaceStream(PlayableSource(
                                      "radio_stream",
                                      "Amàre Radio",
                                      "24 hour full music",
                                      Env.radioStream,
                                      Env.radioCover));
                                }
                              }
                            },
                            icon: Icon(
                              isRadioPlaying ? Icons.pause : Icons.play_arrow,
                              color: AppTheme.accent,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: mediaHeight * 0.01),
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
        ),
      ]),
      backgroundColor: Colors.white,
    );
  }
}

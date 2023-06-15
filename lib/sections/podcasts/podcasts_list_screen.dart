import 'dart:async';

import 'package:amare/app.dart';
import 'package:amare/providers/hearth_this_api/hearth_this_api.dart';
import 'package:amare/providers/hearth_this_api/models/playlist.dart';
import 'package:amare/providers/hearth_this_api/models/track.dart';
import 'package:amare/sections/components/am_background.dart';
import 'package:amare/sections/components/cropped-text.dart';
import 'package:amare/sections/podcasts/player/podcast_player_screen.dart';
import 'package:amare/sections/podcasts/podcast_card.dart';
import 'package:amare/services/am_player.dart';
import 'package:amare/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PodcastsListArguments {
  final Playlist playlist;

  PodcastsListArguments(this.playlist);
}

class PodcastsListScreen extends StatefulWidget {
  static String routerName = 'PodcastListScreen';
  const PodcastsListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PodcastListScreenState();
}

class _PodcastListScreenState extends State<PodcastsListScreen> {
  final player = AMPLayer.shared;
  PlayerStatus? playerStatus;
  StreamSubscription? disposable;

  late Playlist playlist;
  var podcasts = [];

  @override
  void initState() {
    super.initState();

    disposable = AMPLayer.shared.publishStatus.listen((status) {
      if (mounted) {
        setState(() {
          playerStatus = status;
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

  void fetchSet(Playlist playlist) async {
    podcasts = await HearthThisApi(Env.username).fetchSet(playlist, 1, 100);
    setState(() {});
  }

  bool _isTrackPlaying(Track track) {
    if (playerStatus == null) return false;
    return playerStatus!.isPlaying && playerStatus!.stream == track.stream_url;
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    final args =
        ModalRoute.of(context)?.settings.arguments as PodcastsListArguments;

    playlist = args.playlist;

    fetchSet(args.playlist);

    return Scaffold(
      body: Stack(
        children: [
          const AMBackground(),
          Padding(
            padding: EdgeInsets.only(
                top: mediaHeight * 0.09, bottom: mediaHeight * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: IconButton(
                    icon: const Icon(Icons.chevron_left),
                    iconSize: 32,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, bottom: 24, top: 12),
                  child: Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: playlist.image != null &&
                                      playlist.image!.startsWith("http")
                                  ? Image.network(
                                      playlist.image!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/placeholder.png',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        AppTheme.spacerH12,
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                playlist.name,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: AppTheme.accent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                playlist.author.name,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: AppTheme.accent,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    AppTheme.spacerV12,
                    if (playlist.description != null &&
                        playlist.description!.isNotEmpty)
                      CroppedText(text: playlist.description!, canExpand: true)
                  ]),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: podcasts.length,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 16,
                      );
                    },
                    itemBuilder: (_, i) => PodcastCard(
                        track: podcasts[i],
                        isPlaying: _isTrackPlaying(podcasts[i]),
                        onTap: () => Navigator.pushNamed(
                              context,
                              PodcastPlayerScreen.routerName,
                              arguments: PodcastPlayerArguments(podcasts[i]),
                            )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

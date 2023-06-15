import 'package:amare/app.dart';
import 'package:amare/providers/hearth_this_api/hearth_this_api.dart';
import 'package:amare/providers/local_storage/local_storage.dart';
import 'package:amare/sections/podcasts/player/podcast_player_screen.dart';
import 'package:amare/sections/podcasts/playlist_tile.dart';
import 'package:amare/sections/podcasts/podcast_tile.dart';
import 'package:amare/sections/podcasts/podcasts_list_screen.dart';
import 'package:amare/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:amare/sections/components/am_background.dart';
import 'package:amare/sections/components/upper_bar.dart';

const maxRecentlyPlayedItems = 20;

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  var playlists = [];
  var recentlyPlayed = [];

  @override
  void initState() {
    super.initState();

    fetchPodcasts();
    fetchRecentlyPlayed();
  }

  void fetchPodcasts() async {
    var api = HearthThisApi(Env.username);
    playlists = await api.fetchPlaylists(1, 100);
    setState(() {});
  }

  void fetchRecentlyPlayed() async {
    recentlyPlayed = await LocalStorageProvider.recentlyPlayed;

    if (recentlyPlayed.length > maxRecentlyPlayedItems) {
      recentlyPlayed = recentlyPlayed.sublist(1, maxRecentlyPlayedItems);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(children: [
        const AMBackground(),
        Container(
          padding: EdgeInsets.only(top: mediaHeight * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AMUpperBar(
                title: 'Podcasts',
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTheme.spacerV10,
                    Text(
                      'Listen to our podcasts while relaxing',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: AppTheme.accent,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    AppTheme.spacerV24,
                    if (recentlyPlayed.isNotEmpty)
                      Text(
                        'Recently Played',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppTheme.accent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                  ],
                ),
              ),
              AppTheme.spacerV12,
              if (recentlyPlayed.isNotEmpty)
                SizedBox(
                  height: 188,
                  child: ListView.separated(
                    itemCount: recentlyPlayed.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 24,
                      );
                    },
                    itemBuilder: (_, i) => PodcastTile(
                        track: recentlyPlayed[i],
                        showSubtitle: false,
                        onTap: () => Navigator.pushNamed(
                              context,
                              PodcastPlayerScreen.routerName,
                              arguments:
                                  PodcastPlayerArguments(recentlyPlayed[i]),
                            )),
                  ),
                ),
              AppTheme.spacerV12,
              Expanded(
                child: GridView.count(
                  padding: EdgeInsets.only(
                      left: 24, right: 24, bottom: mediaHeight * 0.09),
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  crossAxisCount: 2,
                  childAspectRatio:
                      ((MediaQuery.of(context).size.width / 2) - 32) / 230,
                  children: playlists
                      .map((playlist) => PlaylistTile(
                            playlist: playlist,
                            onTap: () => Navigator.pushNamed(
                              context,
                              PodcastsListScreen.routerName,
                              arguments: PodcastsListArguments(playlist),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ]),
      backgroundColor: Colors.white,
    );
  }
}

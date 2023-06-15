import 'package:amare/app.dart';
import 'package:amare/sections/contact/contact_screen.dart';
import 'package:amare/sections/player/player_screen.dart';
import 'package:amare/sections/podcasts/podcasts_screen.dart';
import 'package:amare/services/am_player.dart';
import 'package:flutter/material.dart';

import 'package:amare/theme/app_theme.dart';

enum Section {
  player,
  podcasts,
  contact,
}

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  static String routerName = 'HomeScreen';
  var section = Env.radioFeature.isEnabled ? Section.player : Section.contact;

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    AMPLayer.shared.setupPlayer(
        PlayableSource("radio_stream", "Amàre Radio", "24 hour full music",
            Env.radioStream, Env.radioCover),
        Env.radioFeature.isEnabled);
  }

  @override
  Widget build(BuildContext context) {
    late Widget body;

    const player = PlayerScreen();
    const podcast = PodcastScreen();
    const contact = ContactScreen();

    switch (widget.section) {
      case Section.player:
        body = player;
        break;
      case Section.podcasts:
        body = podcast;
        break;
      case Section.contact:
        body = contact;
        break;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        backgroundColor: AppTheme.accent,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.only(left: 16),
              child: Image.asset(
                'assets/images/logo_amare.png',
                color: Colors.white,
                width: 176,
              ),
            ),
            if (Env.radioFeature.isEnabled)
              ListTile(
                leading: Image.asset(
                  'assets/icons/icon_drawer_play.png',
                  height: 32,
                  width: 32,
                ),
                title: const Text(
                  'Player',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                textColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                  setState(() => widget.section = Section.player);
                },
              ),
            if (Env.podcastFeature.isEnabled)
              ListTile(
                leading: Image.asset(
                  'assets/icons/icon_drawer_podcast.png',
                  height: 32,
                  width: 32,
                ),
                title: const Text(
                  'Podcasts',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                textColor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                  setState(() => widget.section = Section.podcasts);
                },
              ),
            ListTile(
              leading: Image.asset(
                'assets/icons/icon_drawer_contact.png',
                height: 32,
                width: 32,
              ),
              title: const Text(
                'Contact',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              textColor: Colors.white,
              onTap: () {
                Navigator.pop(context);
                setState(() => widget.section = Section.contact);
              },
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}

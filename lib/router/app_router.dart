import 'package:amare/sections/contact/privacy_screen.dart';
import 'package:amare/sections/podcasts/player/podcast_player_screen.dart';
import 'package:amare/sections/podcasts/podcasts_list_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:amare/sections/home/home_screen.dart';
import 'package:amare/sections/splash/splash_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> getRoutes = {
    SplashScreen.routerName: (_) => const SplashScreen(),
    HomeScreen.routerName: (_) => HomeScreen(),
    PodcastsListScreen.routerName: (_) => const PodcastsListScreen(),
    PodcastPlayerScreen.routerName: (_) => const PodcastPlayerScreen(),
    PrivacyScreen.routerName: (_) => const PrivacyScreen(),
  };
}

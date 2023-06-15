import 'package:amare/router/app_router.dart';
import 'package:amare/sections/contact/hotel/hotel.dart';
import 'package:amare/sections/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class Env {
  static String username = "amaremusic";
  static String radioStream = "http://stream.radiojar.com/pdbu4u49bkhvv";
  static String radioCover =
      "https://firebasestorage.googleapis.com/v0/b/amare-music.appspot.com/o/media%2Famare_music.png?alt=media";

  static String contactEmail = "booking@amarehotels.com";
  static String privacyUrl =
      "https://www.amarehotels.com/es/aviso-legal-y-privacidad/";

  static String legalAdvice =
      '<p>As the Data Controllers for the <strong>AMARE MUSIC</strong> app with the aim of providing the requested service.</p><p><strong>Rights</strong>: You can exercise your rights of access, rectification, deletion, opposition, portability and limitation of the processing of your data by contacting infogrupo@fuerte-group.com, as well as the right to file a claim with a control authority.</p><p>You can consult the additional and detailed information on Data Protection in our <strong><a href="https://www.amarehotels.com/es/aviso-legal-y-privacidad/">privacy policy</a></strong>.</p>';

  static Hotel ibizaHotel = const Hotel(
      name: 'Amàre Ibiza',
      address: 'Carrer La Rioja, 907829 Sant Josep de sa Talaia, Illes Balears',
      hotelPhone: '+34 971 80 45 80',
      bookPhone: '+34 917 94 12 85',
      email: 'booking@amarehotels.com',
      imagePath: 'assets/images/map_amare_ibiza.png');

  static Hotel marbellaHotel = const Hotel(
      name: 'Amàre Marbella',
      address: 'Avda. Severo Ochoa 829603, Marbella Málaga, España',
      hotelPhone: '+34 952 76 84 00',
      bookPhone: '+34 917 94 12 85',
      email: 'booking@amarehotels.com',
      imagePath: 'assets/images/map_amare_marbella.png');

  static Feature radioFeature = Feature(
      description: "Radio player",
      isEnabled: DateTime.now().isAfter(DateTime.parse('20221001')));
  static Feature podcastFeature =
      Feature(description: "Podcast lists", isEnabled: true);
}

class Feature {
  String description;
  bool isEnabled;

  Feature({required this.description, required this.isEnabled}) {
    debugPrint("Creating feature" + description);
    debugPrint(isEnabled.toString());
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Montserrat'),
      home: const SplashScreen(),
      routes: AppRoutes.getRoutes,
    );
  }
}

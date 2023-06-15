import 'package:amare/app.dart';
import 'package:amare/sections/components/am_background.dart';
import 'package:amare/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PrivacyScreen extends StatelessWidget {
  static String routerName = 'PrivacyScreen';

  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      'Legal Advice',
                      style: TextStyle(
                        color: AppTheme.accent,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Html(
                      data: Env.legalAdvice,
                      onLinkTap: (String? url, RenderContext context,
                          Map<String, String> attributes, dom.Element? element) {
                        launchUrlString(Env.privacyUrl);
                      }),
                ),
              )
            ],
          ),
        ),
      ]),
      backgroundColor: Colors.white,
    );
  }
}

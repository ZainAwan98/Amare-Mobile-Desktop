import 'package:amare/app.dart';
import 'package:amare/sections/contact/form/form.dart';
import 'package:amare/sections/contact/hotel/hotel_tile.dart';
import 'package:flutter/material.dart';
import 'package:amare/theme/app_theme.dart';
import 'package:amare/sections/components/am_background.dart';
import 'package:amare/sections/components/upper_bar.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const AMBackground(),
        Container(
          padding: const EdgeInsets.only(top: 48),
          child: Column(
            children: [
              AMUpperBar(
                title: 'Contact',
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'We’re ready to serve your vacations',
                            style: TextStyle(
                              color: AppTheme.accent,
                              fontSize: 16,
                            ),
                          ),
                          AppTheme.spacerV8,
                          const ContactForm(),
                          const SizedBox(height: 32),
                          Text(
                            'Ready to Relax?',
                            style: TextStyle(
                              color: AppTheme.accent,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Book now or just check availability, we're ready to serve you",
                            style: TextStyle(
                              color: AppTheme.accent,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HotelTile(hotel: Env.ibizaHotel),
                        const SizedBox(height: 40),
                        HotelTile(hotel: Env.marbellaHotel),
                      ],
                    )
                  ],
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

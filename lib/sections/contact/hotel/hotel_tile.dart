import 'package:amare/sections/contact/hotel/hotel.dart';
import 'package:amare/theme/app_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HotelTile extends StatelessWidget {
  final Hotel hotel;

  const HotelTile({Key? key, required this.hotel}) : super(key: key);

  void launchEmail(String email) async {
    final uri = Uri.encodeFull('mailto:$email');

    if (await canLaunchUrlString(uri)) {
      launchUrlString(uri);
    } else {
      Fluttertoast.showToast(
          msg: "Defaul email app not available on this device",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: AppTheme.accent,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void launchPhone(String phone) async {
    final uri = Uri.encodeFull('tel:$phone');

    if (await canLaunchUrlString(uri)) {
      launchUrlString(uri);
    } else {
      Fluttertoast.showToast(
          msg: "Defaul phone app not available on this device",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: AppTheme.accent,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hotel.name,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppTheme.accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.place_outlined),
                  const SizedBox(width: 16),
                  Flexible(
                    child: Text(
                      hotel.address,
                      style: TextStyle(
                        color: AppTheme.accent,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.phone_outlined),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Hotel: ",
                              style: TextStyle(
                                color: AppTheme.accent,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat",
                              ),
                            ),
                            TextSpan(
                              text: hotel.hotelPhone,
                              style: TextStyle(
                                color: AppTheme.accent,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat",
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchPhone(hotel.hotelPhone);
                                },
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Bookings: ",
                              style: TextStyle(
                                color: AppTheme.accent,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat",
                              ),
                            ),
                            TextSpan(
                              text: hotel.bookPhone,
                              style: TextStyle(
                                color: AppTheme.accent,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Montserrat",
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchPhone(hotel.bookPhone);
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.email_outlined),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      launchEmail(hotel.email);
                    },
                    child: Text(
                      hotel.email,
                      style: TextStyle(
                        color: AppTheme.accent,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 24),
        Image.asset(hotel.imagePath),
      ],
    );
  }
}

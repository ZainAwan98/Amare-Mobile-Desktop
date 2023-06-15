import 'package:amare/app.dart';
import 'package:amare/extensions/color_extension.dart';
import 'package:amare/sections/contact/form/text_input.dart';
import 'package:amare/sections/contact/hotel/hotel.dart';
import 'package:amare/sections/contact/privacy_screen.dart';
import 'package:amare/theme/app_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:country_picker/country_picker.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerSurname = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerComments = TextEditingController();

  Country? selectedCountry;
  Hotel? selectedHotel;

  var isClient = false;

  var acceptTerms = false;

  final hotelList = [Env.ibizaHotel, Env.marbellaHotel];

  void sendEmail() async {
    var errors = [];

    final name = controllerName.text;
    final surname = controllerSurname.text;
    final email = controllerEmail.text;
    final phone = controllerPhone.text;
    final comments = controllerComments.text;
    final hotel = selectedHotel?.name;
    final country = selectedCountry?.displayName;

    if (name.isEmpty) errors.add("Enter your name");
    if (surname.isEmpty) errors.add("Enter your surname");
    if (email.isEmpty) errors.add("Enter your email");
    if (phone.isEmpty) errors.add("Enter your phone");
    if (comments.isEmpty) errors.add("Enter your observations");
    if (hotel == null) errors.add("Select hotel");
    if (country == null) errors.add("Select your country");

    if (!acceptTerms) errors.add("You must accept legal conditions");

    if (errors.isNotEmpty) {
      Fluttertoast.showToast(
          msg: errors.join("\n"),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: AppTheme.accent,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    final message = [
      "",
      "Name: $name",
      "Surname: $surname",
      "Email: $email",
      "Phone: $phone",
      "Hotel: $hotel",
      "Country: $country",
      "",
      "Observations: $comments",
      "Already a client?: ${isClient ? "yes" : "no"}"
    ].join("\n");

    final uri = Uri.encodeFull(
        'mailto:${Env.contactEmail}?subject=Contact from Amàre music app&body=$message');

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

  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              AMTextInput(
                  type: FieldType.text,
                  label: "NAME",
                  hint: "Your name",
                  controller: controllerName),
              const SizedBox(height: 16),
              AMTextInput(
                  type: FieldType.text,
                  label: "SURNAME",
                  hint: "Your surname",
                  controller: controllerSurname),
              const SizedBox(height: 16),
              AMTextInput(
                  type: FieldType.email,
                  label: "EMAIL",
                  hint: "Your email",
                  controller: controllerEmail),
              const SizedBox(height: 16),
              AMTextInput(
                  type: FieldType.phone,
                  label: "TELEPHONE",
                  hint: "Your telephone",
                  controller: controllerPhone),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "HOTEL",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.accent,
                    ),
                  ),
                  DropdownButtonFormField(
                    items: hotelList.map((hotel) {
                      return DropdownMenuItem(
                        child: Text(hotel.name),
                        value: hotel,
                      );
                    }).toList(),
                    hint: const Text("Select hotel"),
                    onChanged: (hotel) {
                      selectedHotel = hotel as Hotel?;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: HexColor.fromHex("#C4C4C4"),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.accent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "COUNTRY",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.accent,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      primary: Colors.black,
                    ),
                    onPressed: () => {
                      showCountryPicker(
                        context: context,
                        onSelect: (Country country) {
                          selectedCountry = country;
                          setState(() {});
                        },
                      )
                    },
                    child: Row(children: [
                      Text(selectedCountry?.name ?? "Select country"),
                      const Spacer(),
                      const Icon(Icons.arrow_drop_down)
                    ]),
                  ),
                  Divider(color: AppTheme.accent)
                ],
              ),
              const SizedBox(height: 16),
              AMTextInput(
                  type: FieldType.text,
                  label: "OBSERVATIONS",
                  hint: "Your observations",
                  controller: controllerComments),
              AppTheme.spacerV12,
              AppTheme.spacerV8,
              const Text(
                  "The personal data you provide will be processed by FUERTEGROUP S.L. and the hotel where you are staying (AMARE)"),
              AppTheme.spacerV8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PrivacyScreen.routerName);
                    },
                    child: Text(
                      "See more",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: AppTheme.accent,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              AppTheme.spacerV12,
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "I have read the legal notice and accept the ",
                      style: TextStyle(
                        color: AppTheme.accent,
                        fontFamily: "Montserrat",
                      ),
                    ),
                    TextSpan(
                      text: 'PRIVACY POLICY',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.accent,
                        decoration: TextDecoration.underline,
                        fontFamily: "Montserrat",
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrlString(Env.privacyUrl);
                        },
                    ),
                  ]),
                ),
                value: acceptTerms,
                onChanged: (newValue) {
                  setState(() {
                    acceptTerms = newValue ?? false;
                  });
                },
                activeColor: AppTheme.accent,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Are you already a client?",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.accent,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: isClient,
                        onChanged: (newValue) {
                          setState(() {
                            isClient = true;
                          });
                        },
                        activeColor: AppTheme.accent,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Yes',
                          style: TextStyle(
                            color: AppTheme.accent,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                isClient = true;
                              });
                            },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Checkbox(
                        value: !isClient,
                        onChanged: (newValue) {
                          setState(() {
                            isClient = false;
                          });
                        },
                        activeColor: AppTheme.accent,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'No',
                          style: TextStyle(
                            color: AppTheme.accent,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                isClient = false;
                              });
                            },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppTheme.accent,
            minimumSize: const Size.fromHeight(50), // NEW
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // <-- Radius
            ),
          ),
          child: const Text(
            "SEND",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            sendEmail();
          },
        )
      ],
    );
  }
}

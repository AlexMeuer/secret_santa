import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class EndPage extends StatelessWidget {
  const EndPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox.expand(
              child: CachedNetworkImage(
                imageUrl: "https://source.unsplash.com/SUTfFCAHV_A/800x1900",
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(0.5)),
                    child: Center(
                      child: Text(
                        "That's all folks!",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: DefaultTextStyle(
                style: GoogleFonts.majorMonoDisplay()
                    .copyWith(fontWeight: FontWeight.bold),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: "Made by "),
                        TextSpan(
                          text: "Alex Meuer",
                          style: const TextStyle(color: Colors.lightBlue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launch("https://alexmeuer.com"),
                        ),
                        const TextSpan(text: " with "),
                        TextSpan(
                          text: "Flutter",
                          style: const TextStyle(color: Colors.lightBlue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launch("https://flutter.dev/"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

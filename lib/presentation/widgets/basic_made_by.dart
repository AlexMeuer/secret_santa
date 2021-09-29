import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BasicMadeBy extends StatelessWidget {
  const BasicMadeBy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.majorMonoDisplay().copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 10,
      ),
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
    );
  }
}

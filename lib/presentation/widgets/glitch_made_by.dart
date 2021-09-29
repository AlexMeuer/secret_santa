import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secretsanta/presentation/widgets/glitch.dart';
import 'package:url_launcher/url_launcher.dart';

class GlitchMadeBy extends StatelessWidget {
  const GlitchMadeBy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.majorMonoDisplay().copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const GlitchEffect(
              maxExtraPeriod: Duration(seconds: 5),
              minGlitchDuration: Duration(milliseconds: 100),
              child: Text("Made by  "),
            ),
            GlitchEffect(
              minPeriod: const Duration(seconds: 2),
              maxExtraPeriod: const Duration(seconds: 2),
              minGlitchDuration: const Duration(milliseconds: 1000),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => launch("https://alexmeuer.com"),
                  child: const Text(
                    " Alex Meuer ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            const GlitchEffect(
              maxExtraPeriod: Duration(seconds: 5),
              child: Text(
                "  with  ",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
            GlitchEffect(
              minPeriod: const Duration(seconds: 6),
              maxExtraPeriod: const Duration(seconds: 6),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => launch("https://flutter.dev"),
                  child: const Text(
                    "Flutter",
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

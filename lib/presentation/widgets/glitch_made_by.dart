import 'package:auto_size_text/auto_size_text.dart';
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
            const Flexible(
              flex: 2,
              child: GlitchEffect(
                maxExtraPeriod: Duration(seconds: 5),
                minGlitchDuration: Duration(milliseconds: 100),
                child: AutoSizeText("Made by  "),
              ),
            ),
            Flexible(
              flex: 5,
              child: GlitchEffect(
                minPeriod: const Duration(seconds: 2),
                maxExtraPeriod: const Duration(seconds: 2),
                minGlitchDuration: const Duration(milliseconds: 1000),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => launchUrl(Uri.https('alexmeuer.com')),
                    child: const AutoSizeText(
                      "Alex Meuer",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            const Flexible(
              flex: 2,
              child: GlitchEffect(
                maxExtraPeriod: Duration(seconds: 5),
                child: AutoSizeText(
                  "  with  ",
                  style: TextStyle(
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: GlitchEffect(
                minPeriod: const Duration(seconds: 6),
                maxExtraPeriod: const Duration(seconds: 6),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => launchUrl(Uri.https("flutter.dev")),
                    child: const AutoSizeText(
                      "Flutter",
                      textAlign: TextAlign.end,
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarSliver extends StatelessWidget {
  const AppBarSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          "Secret Santa",
          style: GoogleFonts.mountainsOfChristmas(),
        ),
        background: Image.asset(
          "assets/images/bg.jpg",
          fit: BoxFit.cover,
        ),
      ),
      collapsedHeight: 64,
      expandedHeight: 400,
    );
  }
}

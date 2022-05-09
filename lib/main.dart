import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xo/modules/common/constants/app_colors.dart';

import 'modules/game_screen/game_page.dart';

void main() => runApp(MyApp());

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: AppColors.darkGreen,
          elevation: 0,
          titleTextStyle: GoogleFonts.pressStart2p().copyWith(
            color: AppColors.lightGreen,
            fontSize: 24,
          ),
          foregroundColor: Colors.black,
        ),
        textTheme: GoogleFonts.quicksandTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: GamePage(),
    );
  }
}

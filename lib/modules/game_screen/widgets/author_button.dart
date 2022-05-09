import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xo/modules/game_screen/widgets/simple_button.dart';

import '../../../main.dart';
import '../../common/constants/app_colors.dart';

class AuthorDialogButton extends StatelessWidget {
  const AuthorDialogButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
            barrierDismissible: false,
            context: navigatorKey.currentContext!,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                    color: AppColors.lightGreen,
                    width: 2.0,
                  ),
                ),
                backgroundColor: AppColors.darkGreen,
                titleTextStyle: GoogleFonts.pressStart2p().copyWith(
                  color: AppColors.lightGreen,
                ),
                contentTextStyle: GoogleFonts.pressStart2p().copyWith(
                  color: AppColors.lightGreen,
                ),
                title: const Text("Crafted with ❤ by samvit.xyz"),
                actions: [
                  SimpleButton(
                    callBack: () {
                      Navigator.of(context).pop();
                    },
                    title: 'Okay',
                  )
                ],
              );
            });
      },
      icon: Icon(
        Icons.favorite,
        color: AppColors.lightGreen,
      ),
    );
  }
}

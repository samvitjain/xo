import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/constants/app_colors.dart';

typedef CallBack = void Function();

class SimpleButton extends StatelessWidget {
  CallBack callBack;
  String title;
  SimpleButton({
    Key? key,
    required this.callBack,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.lightGreen),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(
              color: AppColors.lightGreen,
              width: 2.0,
            ),
          ),
        ),
      ),
      child: Text(
        title,
        style: GoogleFonts.pressStart2p().copyWith(
          color: AppColors.darkGreen,
        ),
      ),
      onPressed: callBack,
    );
  }
}

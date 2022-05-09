import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:xo/modules/common/constants/app_colors.dart';
import 'package:xo/modules/game_ai/game_ai.dart';
import 'package:xo/modules/game_screen/widgets/simple_button.dart';

import '../../main.dart';

class GameBloc {
  final _boardSubject = BehaviorSubject<List<String>>.seeded([]);
  BehaviorSubject<List<String>> get board => _boardSubject;

  final _isOTurnSubject = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<bool> get isOTurn => _isOTurnSubject;

  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  // bool oTurn = true; // True => UserTurn

  void userInput(int index) {
    if (isOTurn.value && displayElement[index] == '') {
      displayElement[index] = 'O';
      filledBoxes++;
      board.add(displayElement);
      var winner = checkWinner();
      if (winner != null) {
        if (winner == 'DRAW') {
          _showDrawDialog();
        } else {
          _showWinDialog(winner);
        }
      }
      isOTurn.add(false); // False => BotTurn
    }
  }

  Future<void> botInput() async {
    if (!isOTurn.value) {
      await Future.delayed(const Duration(seconds: 1));
      GameAi ai = GameAi(temp(), 'O', 'X');
      var desicion = ai.getDecision();
      int desicionIndex = (desicion.row * 3) + desicion.column;
      displayElement[desicionIndex] = 'X';
      filledBoxes++;
      board.add(displayElement);
      var winner = checkWinner();
      if (winner != null) {
        await Future.delayed(const Duration(seconds: 1));
        if (winner == 'DRAW') {
          _showDrawDialog();
        } else {
          _showWinDialog(winner);
        }
      }
      isOTurn.add(true); // True => UserTurn

    }
  }

  List<List<String>> temp() {
    var l1 = [displayElement[0], displayElement[1], displayElement[2]];
    var l2 = [displayElement[3], displayElement[4], displayElement[5]];
    var l3 = [displayElement[6], displayElement[7], displayElement[8]];
    return [l1, l2, l3];
  }

  void _showWinDialog(String winner) {
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
            title: Text("$winner wins!"),
            actions: [
              SimpleButton(
                callBack: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                title: 'Play Again',
              )
              // FlatButton(
              //   child: Text("Play Again"),
              //   onPressed: () {
              //     _clearBoard();
              //     Navigator.of(context).pop();
              //   },
              // )
            ],
          );
        });

    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  void _showDrawDialog() {
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
            title: const Text("Draw"),
            actions: [
              SimpleButton(
                callBack: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                title: 'Play Again',
              )
            ],
          );
        });
  }

  void _clearBoard() {
    for (int i = 0; i < 9; i++) {
      displayElement[i] = '';
    }

    filledBoxes = 0;
    board.add(displayElement);
  }

  void clearScoreBoard() {
    xScore = 0;
    oScore = 0;
    for (int i = 0; i < 9; i++) {
      displayElement[i] = '';
    }

    filledBoxes = 0;
    board.add(displayElement);
  }

  String? checkWinner() {
    // Checking rows
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      return displayElement[0];
    } else if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      return displayElement[3];
    } else if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      return displayElement[6];
    }

    // Checking Column
    else if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      return displayElement[0];
    } else if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      return displayElement[1];
    } else if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      return displayElement[2];
    }

    // Checking Diagonal
    else if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      return displayElement[0];
    } else if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      return displayElement[2];
    } else if (filledBoxes == 9) {
      return 'DRAW';
    } else {
      return null;
    }
  }
}

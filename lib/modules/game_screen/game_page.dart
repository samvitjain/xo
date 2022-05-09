import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xo/modules/game_screen/game_bloc.dart';

import '../../main.dart';
import '../common/constants/app_colors.dart';
import 'widgets/author_button.dart';
import 'widgets/simple_button.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _bloc = GameBloc();
  @override
  void initState() {
    super.initState();

    _bloc.isOTurn.listen((isOTurn) {
      if (!isOTurn) {
        _bloc.botInput();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XOXOXO'),
        actions: const [
          AuthorDialogButton(),
        ],
      ),
      backgroundColor: AppColors.darkGreen,
      body: StreamBuilder<List<String>>(
          stream: _bloc.board,
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.length == 9) {
              return Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Bot Score X',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.lightGreen,
                                  ),
                                ),
                                Text(
                                  _bloc.xScore.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.lightGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Your Score',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.lightGreen,
                                  ),
                                ),
                                Text(
                                  _bloc.oScore.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.lightGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: GridView.builder(
                        itemCount: 9,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              _bloc.userInput(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.lightGreen,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data![index],
                                  style: TextStyle(
                                    color: AppColors.lightGreen,
                                    fontSize: 35,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  !_bloc.isOTurn.value
                      ? LinearProgressIndicator(
                          color: AppColors.lightGreen,
                          backgroundColor: AppColors.darkGreen,
                        )
                      : Container(
                          height: 20,
                        ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SimpleButton(
                            callBack: _bloc.clearScoreBoard,
                            title: 'Clear',
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return const CircularProgressIndicator();
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

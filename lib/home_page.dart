import 'dart:math';
import 'dart:ui';

import 'package:chaki_suna_app/custom_dialog.dart';
import 'package:chaki_suna_app/game_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GameButton> buttonsList;
  var player1;
  var player2;
  var activePlayer;
  @override
  void initState() {
    super.initState();
    buttonsList = doInit();
  }

  List<GameButton> doInit() {
    player1 = List();
    player2 = List();
    activePlayer = 1;
    var buttonsList = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return buttonsList;
  }

  void playGame(GameButton gameButton) {
    setState(
      () {
        if (activePlayer == 1) {
          gameButton.Text = "X";
          gameButton.bg = Colors.red;
          activePlayer = 2;
          player1.add(gameButton.id);
        } else {
          gameButton.Text = "0";
          gameButton.bg = Colors.black;
          activePlayer = 1;
          player2.add(gameButton.id);
        }
        gameButton.enabled = false;
        int winner = checkWinner();
        if(winner == -1) {
          if(buttonsList.every((element) => element.Text != "")) {
            showDialog(context: context, builder: (_) => CustomDialog(title: 'Tied !!!', callback: resetGame, content: "Press reset to start again", actionText: "Reset",));
          } else {
            activePlayer == 2 ? autoPlay() : null;
          }
        }
      },
    );
  }

  void autoPlay() {
    var emptyCells = List();
    var list = List.generate(9, (index) => index + 1);
    for(var cellId in list) {
      if(player1.contains(cellId) || player2.contains(cellId)) {
        emptyCells.add(cellId);
      }
    }
    var r = Random();
    var randomIndex = r.nextInt(emptyCells.length - 1);
    var cellId = emptyCells[randomIndex];
    int index = buttonsList.indexWhere((element) => element.id == cellId);
    playGame(buttonsList[index]);
  }

  int checkWinner() {
    var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }
    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }


    void resetGame() {
      if (Navigator.canPop(context)) Navigator.pop(context);
      setState(
        () {
          buttonsList = doInit();
        },
      );
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
          context: context,
          builder: (_) => CustomDialog(
            title: "Player 1 won",
            callback: resetGame,
            content: "Press the Reset button to start again",
            actionText: 'Reset',
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => CustomDialog(
            title: "Player 2 won",
            callback: resetGame,
            content: "Press the Reset button to start again",
            actionText: 'Reset',
          ),
        );
      }
    }
    return winner;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chakki Suno'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: buttonsList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                mainAxisSpacing: 9.0,
                crossAxisSpacing: 9.0,
              ),
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: RaisedButton(
                    color: buttonsList[index].bg,
                    disabledColor: buttonsList[index].bg,
                    padding: EdgeInsets.all(8.0),
                    onPressed: buttonsList[index].enabled
                        ? () {
                            playGame(buttonsList[index]);
                          }
                        : null,
                    child: Text(
                      buttonsList[index].Text,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                );
              },
            ),
          ),
          RaisedButton(
            child: Text(
              'Reset',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            onPressed: resetGame,
            color: Colors.red,
            padding: EdgeInsets.all(20.0),
          )
        ],
      ),
    );
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonsList = doInit();
    });
  }
}

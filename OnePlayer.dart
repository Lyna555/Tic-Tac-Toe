import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'gamebutton.dart';
import 'home.dart';
import 'dart:ui';

class OnePlayer extends StatefulWidget {
  @override
  _OnePlayerState createState() => _OnePlayerState();
}

class _OnePlayerState extends State<OnePlayer> {
  final title = 'Grid List';

  var player1 = [];
  var player2 = [];

  var screenSize = window.physicalSize;

  createAlertDialog(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            content: Icon(Icons.emoji_emotions_outlined, size: 80),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      'Go Home',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        runApp(Home());
                      });
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      'Replay',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        reset();
                        Navigator.of(context, rootNavigator: true).pop();
                      });
                    },
                  ),
                ],
              )
            ],
          );
        });
  }

  List listButton = <GameButton>[
    new GameButton(0),
    new GameButton(1),
    new GameButton(2),
    new GameButton(3),
    new GameButton(4),
    new GameButton(5),
    new GameButton(6),
    new GameButton(7),
    new GameButton(8)
  ];

  void reset() {
    for (int i = 0; i < 9; i++) {
      listButton[i].str = '';
      listButton[i].enabled = true;
      listButton[i].clr = Colors.black;
    }
    player1 = [];
    player2 = [];
  }

  bool checkWinner(var player) {
    if (player.contains(0) && player.contains(1) && player.contains(2))
      return true;
    if (player.contains(3) && player.contains(4) && player.contains(5))
      return true;
    if (player.contains(6) && player.contains(7) && player.contains(8))
      return true;
    if (player.contains(0) && player.contains(3) && player.contains(6))
      return true;
    if (player.contains(1) && player.contains(4) && player.contains(7))
      return true;
    if (player.contains(2) && player.contains(5) && player.contains(8))
      return true;
    if (player.contains(0) && player.contains(4) && player.contains(8))
      return true;
    if (player.contains(2) && player.contains(4) && player.contains(6))
      return true;

    return false;
  }

  List check(var player) {
    if (player.contains(0) && player.contains(1) && player.contains(2))
      return [0, 1, 2];
    if (player.contains(3) && player.contains(4) && player.contains(5))
      return [3, 4, 5];
    if (player.contains(6) && player.contains(7) && player.contains(8))
      return [6, 7, 8];
    if (player.contains(0) && player.contains(3) && player.contains(6))
      return [0, 3, 6];
    if (player.contains(1) && player.contains(4) && player.contains(7))
      return [1, 4, 7];
    if (player.contains(2) && player.contains(5) && player.contains(8))
      return [2, 5, 8];
    if (player.contains(0) && player.contains(4) && player.contains(8))
      return [0, 4, 8];
    if (player.contains(2) && player.contains(4) && player.contains(6))
      return [2, 4, 6];

    return [];
  }

  int co = 0;
  int cx = 0;

  int j=0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.brown[200],
        body: SafeArea(
          child: Column(children: <Widget>[
            Container(
                height: 60,
                width: screenSize.width,
                color: Colors.black,
                child: Row(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                            color: Colors.white,
                            iconSize: 30,
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              setState(() {
                                runApp(Home());
                              });
                            }),
                      ],
                    ),

                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'TIC TAC TOE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
            Divider(
              height: 18,
              color: Colors.transparent,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 70,
              child: Text(
                'X : $cx - $co : O',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
                flex: 9,
                child: GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return new RaisedButton(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          listButton[index].str,
                          style: new TextStyle(
                              color: Colors.white, fontSize: 60.0),
                        ),
                        color: listButton[index].clr,
                        disabledColor: Colors.black,
                        onPressed: () {
                          setState(() {
                            if (listButton[index].enabled) {
                              if (listButton[index].enabled &&
                                  listButton[index].str != 'O' && j%2==0) {
                                listButton[index].str = 'X';
                                listButton[index].enabled = false;
                                player1.add(index);
                                j++;
                              }
                            }

                            if (checkWinner(player1)) {
                              cx++;
                              createAlertDialog(context, 'You Won!');
                              for (int i = 0; i < 9; i++) {
                                listButton[i].enabled = false;
                              }
                              for (int i = 0; i < 3; i++) {
                                listButton[check(player1)[i]].clr =
                                    Colors.brown[400];
                              }
                              return;
                            }

                            // player 2
                            var allPlayedButtons = new List.from(player1)
                              ..addAll(player2);
                            for (int i = 0; i < 9; i++) {
                              if (!allPlayedButtons.contains(i) && j%2!=0) {
                                if (player2.contains(0) &&
                                    player2.contains(1) &&
                                    listButton[i].enabled &&
                                    !player1.contains(2)) {
                                  listButton[2].str = 'O';
                                  listButton[2].enabled = false;
                                  player2.add(2);
                                  j++;
                                  break;
                                } else {
                                  if (player2.contains(1) &&
                                      player2.contains(2) &&
                                      listButton[i].enabled &&
                                      !player1.contains(0)) {
                                    listButton[0].str = 'O';
                                    listButton[0].enabled = false;
                                    player2.add(0);
                                    j++;
                                    break;
                                  } else {
                                    if (player2.contains(0) &&
                                        player2.contains(2) &&
                                        listButton[i].enabled &&
                                        !player1.contains(1)) {
                                      listButton[1].str = 'O';
                                      listButton[1].enabled = false;
                                      player2.add(1);
                                      j++;
                                      break;
                                    } else {
                                      if (player2.contains(3) &&
                                          player2.contains(4) &&
                                          listButton[i].enabled &&
                                          !player1.contains(5)) {
                                        listButton[5].str = 'O';
                                        listButton[5].enabled = false;
                                        player2.add(5);
                                        j++;
                                        break;
                                      } else {
                                        if (player2.contains(4) &&
                                            player2.contains(5) &&
                                            listButton[i].enabled &&
                                            !player1.contains(3)) {
                                          listButton[3].str = 'O';
                                          listButton[3].enabled = false;
                                          player2.add(3);
                                          j++;
                                          break;
                                        } else {
                                          if (player2.contains(3) &&
                                              player2.contains(5) &&
                                              listButton[i].enabled &&
                                              !player1.contains(4)) {
                                            listButton[4].str = 'O';
                                            listButton[4].enabled = false;
                                            player2.add(4);
                                            j++;
                                            break;
                                          } else {
                                            if (player2.contains(6) &&
                                                player2.contains(7) &&
                                                listButton[i].enabled &&
                                                !player1.contains(8)) {
                                              listButton[8].str = 'O';
                                              listButton[8].enabled = false;
                                              player2.add(8);
                                              j++;
                                              break;
                                            } else {
                                              if (player2.contains(7) &&
                                                  player2.contains(8) &&
                                                  listButton[i].enabled &&
                                                  !player1.contains(6)) {
                                                listButton[6].str = 'O';
                                                player2.add(6);
                                                j++;
                                                break;
                                              } else {
                                                if (player2.contains(6) &&
                                                    player2.contains(8) &&
                                                    listButton[i].enabled &&
                                                    !player1.contains(7)) {
                                                  listButton[7].str = 'O';
                                                  listButton[7].enabled = false;
                                                  player2.add(7);
                                                  j++;
                                                  break;
                                                } else {
                                                  if (player2.contains(0) &&
                                                      player2.contains(4) &&
                                                      listButton[i].enabled &&
                                                      !player1.contains(8)) {
                                                    listButton[8].str = 'O';
                                                    listButton[8].enabled = false;
                                                    player2.add(8);
                                                    j++;
                                                    break;
                                                  } else {
                                                    if (player2.contains(4) &&
                                                        player2.contains(8) &&
                                                        listButton[i].enabled &&
                                                        !player1.contains(0)) {
                                                      listButton[0].str = 'O';
                                                      listButton[0].enabled = false;
                                                      player2.add(0);
                                                      j++;
                                                      break;
                                                    } else {
                                                      if (player2.contains(0) &&
                                                          player2.contains(8) &&
                                                          listButton[i].enabled &&
                                                          !player1.contains(4)) {
                                                        listButton[4].str = 'O';
                                                        listButton[4].enabled = false;
                                                        player2.add(4);
                                                        j++;
                                                        break;
                                                      } else {
                                                        if (player2.contains(2) &&
                                                            player2.contains(4) &&
                                                            listButton[i].enabled &&
                                                            !player1.contains(6)) {
                                                          listButton[6].str = 'O';
                                                          listButton[6].enabled = false;
                                                          player2.add(6);
                                                          j++;
                                                          break;
                                                        } else {
                                                          if (player2.contains(4) &&
                                                              player2.contains(6) &&
                                                              listButton[i].enabled &&
                                                              !player1.contains(2)) {
                                                            listButton[2].str = 'O';
                                                            listButton[2].enabled = false;
                                                            player2.add(2);
                                                            j++;
                                                            break;
                                                          } else {
                                                            if (player2.contains(6) &&
                                                                player2.contains(2) &&
                                                                listButton[i].enabled &&
                                                                !player1.contains(4)) {
                                                              listButton[4].str = 'O';
                                                              listButton[4].enabled = false;
                                                              player2.add(4);
                                                              j++;
                                                              break;
                                                            } else {
                                                              if (player2.contains(0) &&
                                                                  player2.contains(3) &&
                                                                  listButton[i].enabled &&
                                                                  !player1.contains(6)) {
                                                                listButton[6].str = 'O';
                                                                listButton[6].enabled = false;
                                                                player2.add(6);
                                                                j++;
                                                                break;
                                                              } else {
                                                                if (player2.contains(3) &&
                                                                    player2.contains(6) &&
                                                                    listButton[i].enabled &&
                                                                    !player1.contains(0)) {
                                                                  listButton[0].str = 'O';
                                                                  listButton[0].enabled = false;
                                                                  player2.add(0);
                                                                  j++;
                                                                  break;
                                                                } else {
                                                                  if (player2.contains(6) &&
                                                                      player2.contains(0) &&
                                                                      listButton[i].enabled &&
                                                                      !player1.contains(3)) {
                                                                    listButton[3].str = 'O';
                                                                    listButton[3].enabled = false;
                                                                    player2.add(3);
                                                                    j++;
                                                                    break;
                                                                  } else {
                                                                    if (player2.contains(1) &&
                                                                        player2.contains(4) &&
                                                                        listButton[i].enabled &&
                                                                        !player1.contains(7)) {
                                                                      listButton[7].str = 'O';
                                                                      listButton[7].enabled = false;
                                                                      player2.add(7);
                                                                      j++;
                                                                      break;
                                                                    } else {
                                                                      if (player2.contains(4) &&
                                                                          player2.contains(7) &&
                                                                          listButton[i].enabled &&
                                                                          !player1.contains(1)) {
                                                                        listButton[1].str = 'O';
                                                                        listButton[1].enabled = false;
                                                                        player2.add(1);
                                                                        j++;
                                                                        break;
                                                                      } else {
                                                                        if (player2.contains(1) &&
                                                                            player2.contains(7) &&
                                                                            listButton[i].enabled &&
                                                                            !player1.contains(4)) {
                                                                          listButton[4].str = 'O';
                                                                          listButton[4].enabled = false;
                                                                          player2.add(4);
                                                                          j++;
                                                                          break;
                                                                        } else {
                                                                          if (player2.contains(2) &&
                                                                              player2.contains(5) &&
                                                                              listButton[i].enabled &&
                                                                              !player1.contains(8)) {
                                                                            listButton[8].str = 'O';
                                                                            listButton[8].enabled = false;
                                                                            player2.add(8);
                                                                            j++;
                                                                            break;
                                                                          } else {
                                                                            if (player2.contains(5) &&
                                                                                player2.contains(8) &&
                                                                                listButton[i].enabled &&
                                                                                !player1.contains(2)) {
                                                                              listButton[2].str = 'O';
                                                                              listButton[2].enabled = false;
                                                                              player2.add(2);
                                                                              j++;
                                                                              break;
                                                                            } else {
                                                                              if (player2.contains(8) &&
                                                                                  player2.contains(2) &&
                                                                                  listButton[i].enabled &&
                                                                                  !player1.contains(5)) {
                                                                                listButton[5].str = 'O';
                                                                                listButton[5].enabled = false;
                                                                                player2.add(5);
                                                                                j++;
                                                                                break;
                                                                              }
                                                                            }
                                                                          }
                                                                        }
                                                                      }
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                }

                                if (player1.contains(0) &&
                                    player1.contains(1) &&
                                    listButton[i].enabled &&
                                    !player2.contains(2)) {
                                  listButton[2].str = 'O';
                                  listButton[2].enabled = false;
                                  player2.add(2);
                                  j++;
                                  break;
                                } else {
                                  if (player1.contains(1) &&
                                      player1.contains(2) &&
                                      listButton[i].enabled &&
                                      !player2.contains(0)) {
                                    listButton[0].str = 'O';
                                    listButton[0].enabled = false;
                                    player2.add(0);
                                    j++;
                                    break;
                                  } else {
                                    if (player1.contains(0) &&
                                        player1.contains(2) &&
                                        listButton[i].enabled &&
                                        !player2.contains(1)) {
                                      listButton[1].str = 'O';
                                      listButton[1].enabled = false;
                                      player2.add(1);
                                      j++;
                                      break;
                                    } else {
                                      if (player1.contains(3) &&
                                          player1.contains(4) &&
                                          listButton[i].enabled &&
                                          !player2.contains(5)) {
                                        listButton[5].str = 'O';
                                        listButton[5].enabled = false;
                                        player2.add(5);
                                        j++;
                                        break;
                                      } else {
                                        if (player1.contains(4) &&
                                            player1.contains(5) &&
                                            listButton[i].enabled &&
                                            !player2.contains(3)) {
                                          listButton[3].str = 'O';
                                          listButton[3].enabled = false;
                                          player2.add(3);
                                          j++;
                                          break;
                                        } else {
                                          if (player1.contains(3) &&
                                              player1.contains(5) &&
                                              listButton[i].enabled &&
                                              !player2.contains(4)) {
                                            listButton[4].str = 'O';
                                            listButton[4].enabled = false;
                                            player2.add(4);
                                            j++;
                                            break;
                                          } else {
                                            if (player1.contains(6) &&
                                                player1.contains(7) &&
                                                listButton[i].enabled &&
                                                !player2.contains(8)) {
                                              listButton[8].str = 'O';
                                              listButton[8].enabled = false;
                                              player2.add(8);
                                              j++;
                                              break;
                                            } else {
                                              if (player1.contains(7) &&
                                                  player1.contains(8) &&
                                                  listButton[i].enabled &&
                                                  !player2.contains(6)) {
                                                listButton[6].str = 'O';
                                                listButton[6].enabled = false;
                                                player2.add(6);
                                                j++;
                                                break;
                                              } else {
                                                if (player1.contains(6) &&
                                                    player1.contains(8) &&
                                                    listButton[i].enabled &&
                                                    !player2.contains(7)) {
                                                  listButton[7].str = 'O';
                                                  listButton[7].enabled = false;
                                                  player2.add(7);
                                                  j++;
                                                  break;
                                                } else {
                                                  if (player1.contains(0) &&
                                                      player1.contains(4) &&
                                                      listButton[i].enabled &&
                                                      !player2.contains(8)) {
                                                    listButton[8].str = 'O';
                                                    listButton[8].enabled = false;
                                                    player2.add(8);
                                                    j++;
                                                    break;
                                                  } else {
                                                    if (player1.contains(4) &&
                                                        player1.contains(8) &&
                                                        listButton[i].enabled &&
                                                        !player2.contains(0)) {
                                                      listButton[0].str = 'O';
                                                      listButton[0].enabled = false;
                                                      player2.add(0);
                                                      j++;
                                                      break;
                                                    } else {
                                                      if (player1.contains(0) &&
                                                          player1.contains(8) &&
                                                          listButton[i].enabled &&
                                                          !player2.contains(4)) {
                                                        listButton[4].str = 'O';
                                                        listButton[4].enabled = false;
                                                        player2.add(4);
                                                        j++;
                                                        break;
                                                      } else {
                                                        if (player1.contains(2) &&
                                                            player1.contains(4) &&
                                                            listButton[i].enabled &&
                                                            !player2.contains(6)) {
                                                          listButton[6].str = 'O';
                                                          listButton[6].enabled = false;
                                                          player2.add(6);
                                                          j++;
                                                          break;
                                                        } else {
                                                          if (player1.contains(4) &&
                                                              player1.contains(6) &&
                                                              listButton[i].enabled &&
                                                              !player2.contains(2)) {
                                                            listButton[2].str = 'O';
                                                            listButton[2].enabled = false;
                                                            player2.add(2);
                                                            j++;
                                                            break;
                                                          } else {
                                                            if (player1.contains(6) &&
                                                                player1.contains(2) &&
                                                                listButton[i].enabled &&
                                                                !player2.contains(4)) {
                                                              listButton[4].str = 'O';
                                                              listButton[4].enabled = false;
                                                              player2.add(4);
                                                              j++;
                                                              break;
                                                            } else {
                                                              if (player1.contains(0) &&
                                                                  player1.contains(3) &&
                                                                  listButton[i].enabled &&
                                                                  !player2.contains(6)) {
                                                                listButton[6].str = 'O';
                                                                listButton[6].enabled = false;
                                                                player2.add(6);
                                                                j++;
                                                                break;
                                                              } else {
                                                                if (player1.contains(3) &&
                                                                    player1.contains(6) &&
                                                                    listButton[i].enabled &&
                                                                    !player2.contains(0)) {
                                                                  listButton[0].str = 'O';
                                                                  listButton[0].enabled = false;
                                                                  player2.add(0);
                                                                  j++;
                                                                  break;
                                                                } else {
                                                                  if (player1.contains(6) &&
                                                                      player1.contains(0) &&
                                                                      listButton[i].enabled &&
                                                                      !player2.contains(3)) {
                                                                    listButton[3].str = 'O';
                                                                    listButton[3].enabled = false;
                                                                    player2.add(3);
                                                                    j++;
                                                                    break;
                                                                  } else {
                                                                    if (player1.contains(1) &&
                                                                        player1.contains(4) &&
                                                                        listButton[i].enabled &&
                                                                        !player2.contains(7)) {
                                                                      listButton[7].str = 'O';
                                                                      listButton[7].enabled = false;
                                                                      player2.add(7);
                                                                      j++;
                                                                      break;
                                                                    } else {
                                                                      if (player1.contains(4) &&
                                                                          player1.contains(7) &&
                                                                          listButton[i].enabled &&
                                                                          !player2.contains(1)) {
                                                                        listButton[1].str = 'O';
                                                                        listButton[1].enabled = false;
                                                                        player2.add(1);
                                                                        j++;
                                                                        break;
                                                                      } else {
                                                                        if (player1.contains(1) &&
                                                                            player1.contains(7) &&
                                                                            listButton[i].enabled &&
                                                                            !player2.contains(4)) {
                                                                          listButton[4].str = 'O';
                                                                          listButton[4].enabled = false;
                                                                          player2.add(4);
                                                                          j++;
                                                                          break;
                                                                        } else {
                                                                          if (player1.contains(2) &&
                                                                              player1.contains(5) &&
                                                                              listButton[i].enabled &&
                                                                              !player2.contains(8)) {
                                                                            listButton[8].str = 'O';
                                                                            listButton[8].enabled = false;
                                                                            player2.add(8);
                                                                            j++;
                                                                            break;
                                                                          } else {
                                                                            if (player1.contains(5) &&
                                                                                player1.contains(8) &&
                                                                                listButton[i].enabled &&
                                                                                !player2.contains(2)) {
                                                                              listButton[2].str = 'O';
                                                                              listButton[2].enabled = false;
                                                                              player2.add(2);
                                                                              j++;
                                                                              break;
                                                                            } else {
                                                                              if (player1.contains(8) &&
                                                                                  player1.contains(2) &&
                                                                                  listButton[i].enabled &&
                                                                                  !player2.contains(5)) {
                                                                                listButton[5].str = 'O';
                                                                                listButton[5].enabled = false;
                                                                                player2.add(5);
                                                                                j++;
                                                                                break;
                                                                              }
                                                                            }
                                                                          }
                                                                        }
                                                                      }
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                                listButton[i].str = 'O';
                                listButton[i].enabled = false;
                                player2.add(i);
                                j++;
                                break;
                              }
                            }

                            if (checkWinner(player2)) {
                              co++;
                              createAlertDialog(context, 'System Wins!');
                              for (int i = 0; i < 9; i++) {
                                listButton[i].enabled = false;
                              }
                              for (int i = 0; i < 3; i++) {
                                listButton[check(player2)[i]].clr =
                                    Colors.brown[400];
                              }
                              return;
                            }
                            if (!checkWinner(player1) &&
                                !checkWinner(player2) &&
                                allPlayedButtons.length == 9) {
                              createAlertDialog(context, 'Tie!');
                              for (int i = 0; i < 9; i++) {
                                listButton[i].enabled = false;
                                listButton[i].clr=Colors.brown[400];
                              }
                              return;
                            }
                          });
                        },
                      );
                    })),
            Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                        child: Icon(Icons.restart_alt),
                        backgroundColor: Colors.black,
                        onPressed: () {
                          setState(() {
                            reset();
                          });
                        }),
                  ],
                )),
          ]),
        ),
      ),
    );
  }
}

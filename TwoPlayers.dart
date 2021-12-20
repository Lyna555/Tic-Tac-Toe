import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'gamebutton.dart';
import 'home.dart';


class TwoPlayers extends StatefulWidget {
  @override
  _TwoPlayersState createState() => _TwoPlayersState();
}




class _TwoPlayersState extends State<TwoPlayers> {
  int i=1;

  List listButton= <GameButton> [
    new GameButton(1),
    new GameButton(2),
    new GameButton(3),
    new GameButton(4),
    new GameButton(5),
    new GameButton(6),
    new GameButton(7),
    new GameButton(8),
    new GameButton(9)];

  final orangeThickPaint = Paint()
    ..style=PaintingStyle.stroke
    ..strokeWidth = 10
    ..color=Colors.grey;

  createAlertDialog(BuildContext context,String text ){
    return showDialog(context: context, builder:(context){
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        content: Icon(Icons.emoji_emotions_outlined, size: 70,),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Text('Go Home',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.black,
                onPressed: (){
                  setState(() {
                    runApp(Home());
                  });
                },
              ),
              SizedBox(
                width: 20,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Text('Replay',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.black,
                onPressed: (){
                  setState(() {
                    reset();
                    Navigator.of(context,rootNavigator: true).pop();
                  });
                },
              ),
            ],
          )
        ],
      );
    } );
  }

  void reset() {
    for (var i = 0; i < 9; i++) {
      listButton[i].str = "";
      listButton[i].enabled = true;
      listButton[i].clr = Colors.black;
    }
    player1=[];
    player2=[];
  }
  List player1=[];
  List player2=[];


  bool checkWinner(var player){

    if(player.contains(0) && player.contains(1) && player.contains(2)) return true;
    if(player.contains(3) && player.contains(4) && player.contains(5)) return true;
    if(player.contains(6) && player.contains(7) && player.contains(8)) return true;
    if(player.contains(0) && player.contains(3) && player.contains(6)) return true;
    if(player.contains(1) && player.contains(4) && player.contains(7)) return true;
    if(player.contains(2) && player.contains(5) && player.contains(8)) return true;
    if(player.contains(0) && player.contains(4) && player.contains(8)) return true;
    if(player.contains(2) && player.contains(4) && player.contains(6)) return true;


    return false;
  }



  int co=0;
  int cx=0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                  height: 60,
                  width: 400,
                  color: Colors.black,
                  child: Row(

                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.arrow_back),
                              onPressed: (){
                                setState(() {
                                  runApp(Home());
                                });
                              }),

                        ],
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'TIC TAC TOE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,

                            ),
                          )
                        ],
                      )
                    ],
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:10),
              height: 40,
              child: Text(
                'X : $cx   $co : O',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child:  GridView.builder(
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
                        style: new TextStyle(color: Colors.white, fontSize: 60.0),
                      ),
                      color: listButton[index].clr,
                      disabledColor: Colors.grey,
                      onPressed: (){
                        setState(() {

                          if (listButton[index].enabled && listButton[index].str!='O' && i%2==0){
                            listButton[index].str="X";
                            listButton[index].enabled=false;
                            player1.add(index);
                            i++;
                          }else{
                            if ( listButton[index].enabled && listButton[index].str!='X' && i%2!=0 ){
                              listButton[index].str="O";
                              listButton[index].enabled=false;
                              player2.add(index);
                              i++;
                            }
                          }

                          if(checkWinner(player1))
                          {
                            cx++;
                            createAlertDialog(context,'X Wins!');
                            for (int i=0; i<9; i++){
                              listButton[i].enabled = false;
                              listButton[i].clr = Colors.blueGrey;
                            }
                            return;
                          }



                          if(checkWinner(player2))
                          {
                            co++;
                            createAlertDialog(context,'O Wins!');
                            for (int i=0; i<9; i++){
                              listButton[i].enabled = false;
                              listButton[i].clr = Colors.blueGrey;
                            }
                            return;
                          }

                          if(!checkWinner(player1) && !checkWinner(player2) && ((player1.length==4 && player2.length==5)||(player1.length==5 && player2.length==4))){
                            createAlertDialog(context,'Tie!');
                            for (int i=0; i<9; i++){
                              listButton[i].enabled = false;
                              listButton[i].clr = Colors.blueGrey;
                            }
                            return;
                          }

                        });
                      },
                    );

                  }),
            ),
            Expanded(
                flex: 3,
                child:Column(
                  children: <Widget>[
                    FloatingActionButton(
                        child: Icon(Icons.restart_alt),
                        backgroundColor: Colors.black,
                        onPressed: (){
                          setState(() {
                            reset();
                          });
                        }),
                  ],
                )
            ),

          ],
        ),

      ),
    );
  }
}
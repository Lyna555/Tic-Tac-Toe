import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'OnePlayer.dart';
import 'TwoPlayers.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 50),
                    color: Colors.white,
                    child: Text('ONE PLAYER',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed:(){
                      setState(() {
                        runApp(OnePlayer());
                      }
                      );
                    }),
                Divider(
                  thickness: 5,
                  color: Colors.transparent,
                ),
                RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 44),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    color: Colors.white,
                    child: Text('TWO PLAYERS',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed:(){
                      setState(() {
                        runApp(TwoPlayers());
                      }
                      );
                    }),

              ],
            ),
          )
      ),
    );
  }
}


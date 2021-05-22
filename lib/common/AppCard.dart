import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final String name;
  final String body;

  //requiring the list of todos
  AppCard({Key key, @required this.name, @required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Container(
      height: 65,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        elevation: 20,
        color: Colors.grey[850],
        child: IntrinsicHeight(
          child: Row(children: <Widget>[
            Container(
              height: 65.0,
              width: 100.0,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 1),
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            VerticalDivider(
              thickness: 2,
              width: 0,
              color: Colors.grey[900],
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: Text(
                  body,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ))
          ]),
        ),
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
bool colorF = true;
Color c;

class SkillTemp extends StatelessWidget {
  final String name;
  final int percent;

  //requiring the list of todos
  SkillTemp({Key key, @required this.name, @required this.percent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(colorF){
      c = Colors.amber[200];
      colorF = false;
    }
    else{
      colorF = true;
      c = Colors.amber[700];
    }
    if(percent < 40){
       c = Colors.red;
    }
    return Container(
        height: 65,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            elevation: 20,
            color: Colors.grey[850],
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0,0,0),
                ),
                Container(
                  width: 70,
                    child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),
                  ),
                ),  
                SizedBox(width: 20,),
                LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 130,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 1000,
                  percent: percent/100,
                  center: Text(percent.toString() + '%'),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: c,
                ),
              ],
            )));
  }
}

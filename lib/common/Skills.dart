import 'package:flutter/material.dart';
import 'package:my_info/common/SkillsTemp.dart';

class Skills extends StatefulWidget {
  @override
  _SkillsState createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 25),
          Container(
              child: Text(
                'Skills Acquired Yet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[800],
                boxShadow: [
                  BoxShadow(color: Colors.grey[850], spreadRadius: 3),
                ],
              ),
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            ),
          // Divider(
          //   color: Colors.white,
          //   thickness: 2,
          // ),
          SizedBox(height: 15,),
          // Text(
          //   'Acquired Yet',
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 20,
          //   ) ,
          // ),
          SizedBox(height: 10,),
          SkillTemp(name: 'Flutter', percent: 60),
          SizedBox(height: 10,),
          SkillTemp(name: 'HTML- CSS', percent: 75),
          SizedBox(height: 10,),
          SkillTemp(name: 'Java -Script', percent: 70),
          SizedBox(height: 10,),
          SkillTemp(name: 'Node.js', percent: 70),
          SizedBox(height: 10,),
          SkillTemp(name: 'React', percent: 65),
          SizedBox(height: 10,),
          SkillTemp(name: 'Data-Science', percent: 80),
          SizedBox(height: 10,),
          SkillTemp(name: 'Java', percent: 70),
          SizedBox(height: 10,),
          SkillTemp(name: 'C / C++', percent: 75),
          Divider(
            color: Colors.white,
            thickness: 2,
          ),
          SizedBox(height: 15,),
          Container(
              child: Text(
                'Learning',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25 ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[800],
                boxShadow: [
                  BoxShadow(color: Colors.grey[850], spreadRadius: 3),
                ],
              ),
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            ),
          SizedBox(height: 10,),
          SkillTemp(name: 'Deep-Learning', percent: 35),
          SizedBox(height: 10,),
          SkillTemp(name: 'Angular.js', percent: 20),
        ],),
      ),
      backgroundColor: Colors.grey[900],
    );
  }
}
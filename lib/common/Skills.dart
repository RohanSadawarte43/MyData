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
          SizedBox(height: 15,),
          Text(
            'Skill-Set',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ) ,
          ),
          Divider(
            color: Colors.white,
            thickness: 2,
          ),
          SizedBox(height: 15,),
          Text(
            'Acquired Yet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ) ,
          ),
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
          Text(
            'Learning...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
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
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:my_info/common/Documents.dart';
import 'package:my_info/common/Home.dart';
import 'package:my_info/common/Skills.dart';
import 'package:my_info/common/ToDo.dart';

Future<void> main() async {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget()
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  List _widgetOptions = <Widget>[
    Container(
      child: Home(),
    ),
    Container(
      child: Skills(),
    ),
    Container(
      child: UploadMultipleImageDemo(),
    ),
    Container(
      child: ToDo(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[800],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(MaterialCommunityIcons.trophy),
            label: 'Skills',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(MaterialCommunityIcons.file_document),
            label: 'Documents',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(MaterialCommunityIcons.check),
            label: 'To-Do',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/material.dart';
import 'package:my_info/common/AppCard.dart';
import 'package:url_launcher/url_launcher.dart';

var _url = 'https://flutter.dev';
var urlIndex = 0;
void _launchURL() async {
  if (urlIndex == 0) {
    _url = 'https://github.com/RohanSadawarte43';
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
  if (urlIndex == 1) {
    _url = 'https://www.youtube.com/channel/UCQvUWmiT1SOcprgltaEDZFA';
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
  if (urlIndex == 2) {
    _url = 'https://rohansadawarte43.github.io/Portfolio/';
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
  if (urlIndex == 3) {
    _url = 'https://www.linkedin.com/in/rohan-sadawarte-2a787a179/';
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
}

class Home extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
                child: CircleAvatar(
                    radius: 54,
                    backgroundColor: Colors.grey[800],
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/RohanF.jpg'),
                      radius: 50,
                    ))),
            SizedBox(
              height: 30,
            ),
            Text(
              'Computer Engineer ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            AppCard(name: 'Name', body: 'Rohan Sadawarte'),
            SizedBox(
              height: 5,
            ),
            AppCard(name: 'Birth Date', body: '4\u1d57\u02b0 March, 2001'),
            SizedBox(
              height: 10,
            ),
            AppCard(name: 'College', body: 'VIIT, Pune'),
            SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                color: Colors.grey[700],
                child: IconButton(
                  icon: Icon(MaterialCommunityIcons.github),
                  onPressed: () {
                    urlIndex = 0;
                    _launchURL();
                  },
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                color: Colors.grey[700],
                child: IconButton(
                  icon: Icon(MaterialCommunityIcons.youtube),
                  onPressed: () {
                    urlIndex = 1;
                    _launchURL();
                  },
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                color: Colors.grey[700],
                child: IconButton(
                  icon: Icon(MaterialCommunityIcons.web),
                  onPressed: () {
                    urlIndex = 2;
                    _launchURL();
                  },
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                color: Colors.grey[700],
                child: IconButton(
                  icon: Icon(MaterialCommunityIcons.linkedin),
                  onPressed: () {
                    urlIndex = 3;
                    _launchURL();
                  },
                ),
              ),
            ]),
          ],
        ),
      ),
      backgroundColor: Colors.grey[900],
    );
  }
}

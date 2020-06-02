import 'dart:io';
import 'package:flutter/material.dart';
import 'contry.dart';
import 'main.dart';
import 'eco.dart';
import 'geninfo.dart';
import 'about.dart';
import 'safety.dart';
import 'insp.dart';
import 'stat.dart';
int ref=0;
class App extends StatelessWidget {
  _nav(int count){
  switch (count){
    case 0:
      return Stats();
    case 1:
      return Info();
    case 2:
      return Safety();
    case 3:
      return Contry();
    case 4:
      return Eco();
    case 5:
      return Insp();
    case 6:
      return About();
  }
}
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop:(){return Future<bool>.value(false);},
        child: MaterialApp(
          home: Scaffold(
            drawer: Menu(),
            appBar: AppBar(
              title: Text("COVID Watch"),
            ),
            body: _nav(ref),
          ),
        ));
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'COVID\nWatch',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/cover.jpg',
                    ))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Statistics'),
            onTap: () => {
              ref=0,
              Navigator.pop(context),
              main()
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('COVID Info'),
            onTap: () => {ref=1,
            Navigator.pop(context),
              main()}
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Safety'),
            onTap: () => {ref=2,
            Navigator.pop(context),
              main()}
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Country wise Actions'),
            onTap: () => {ref=3,
            Navigator.pop(context),
              main()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Economic Status'),
            onTap: () => {ref=4,
            Navigator.pop(context),
              main()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Get Inspired'),
            onTap: () => {ref=5,
            Navigator.pop(context),
              main()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('About Us'),
            onTap: () => {ref=6,
            Navigator.pop(context),
              main()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit App'),
            onTap: () => {exit(0)},
          ),
        ],
      ),
    );
  }
}

 
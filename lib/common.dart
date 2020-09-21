import 'package:flutter/material.dart';
import 'main.dart';
import 'stat.dart';
import 'package:google_fonts/google_fonts.dart';
int ref=0;
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop:(){return Future<bool>.value(false);},
        child: MaterialApp(
          theme: ThemeData(
    textTheme: GoogleFonts.sanchezTextTheme(
      
      Theme.of(context).textTheme,
    ),),
          home:Container(
                    decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back.jpg'), fit: BoxFit.cover)),
 
            child: Scaffold(
              backgroundColor: Colors.transparent,
            drawer: Menu(),
            appBar: AppBar(
              title: Text("COVID Watch"),
            ),
            body: Stats(),
          ),),
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
            leading: Icon(Icons.insert_chart),
            title: Text('Statistics'),
            onTap: () => {
              ref=0,
              Navigator.pop(context),
              main()
            },
          ),
          /*ListTile(
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
          ),*/
        ],
      ),
    );
  }
}

 
import 'package:flutter/material.dart';
import 'resource.dart';
import 'main.dart';

String data = "fggfg";
String text = "loading..";
Country x;
int numb = 0;

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      //alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            height: 80,
            width: 500,
          child:TextField(
            expands: true,
            maxLines: null,
            minLines: null,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.red, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.red),
                ),
                contentPadding: EdgeInsets.all(10),
                labelText: 'Email',
                hintText: 'you@email.com',
                icon: Icon(Icons.contact_mail)),
            onChanged: (String val) => {
                      data=val,
                      /*x.data(val),
                      numb = x.ncases,*/
                      main(),
                    }
          )),
          Positioned(bottom: 0, right: 0, child: Text("ok")),
          Positioned(
            top: 100,
            left: 0,
            child: Text("$numb"),
          ),
          Positioned(
            top: 300,
            left: 50,
            child: Text("$data"),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'resource.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:admob_flutter/admob_flutter.dart';

const String appId = 'ca-app-pub-2534963479045141~4543442830';
const String addunitId = 'ca-app-pub-2534963479045141/7593112159';
//bool _loadChart=l;
String url = 'https://api.covid19api.com/summary';
//Country x;
//int numb = 0;

var country = new Country();

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      //alignment: Alignment.center,
      child: Stack(
        children: [
          Search(),
        ],
      ),
    );
  }
}

class Country {
  String name;
  int tcases, trecover, tdeath, ncases, nrecover, ndeath;
  bool loaded = false;
  dataloader(String country) async {
    final directory = await getApplicationDocumentsDirectory();

    final path = directory.path;
    final filepath = "$path/data.json";
    Map<String, dynamic> filejason;
    File file = File(filepath);

    String content = file.readAsStringSync();

    filejason = json.decode(content);

    this.name = country;
    if (country == "Global") {
      this.tcases = filejason["Global"]['TotalConfirmed'];
      this.trecover = filejason["Global"]['TotalRecovered'];
      this.tdeath = filejason["Global"]['TotalDeaths'];
      this.ncases = filejason["Global"]['NewConfirmed'];
      this.nrecover = filejason["Global"]['NewRecovered'];
      this.ndeath = filejason["Global"]['NewDeaths'];
      this.loaded = true;
    } else {
      for (var i in filejason['Countries']) {
        if (i['Country'] == country) {
          this.tcases = i['TotalConfirmed'];
          this.trecover = i['TotalRecovered'];
          this.tdeath = i['TotalDeaths'];
          this.ncases = i['NewConfirmed'];
          this.nrecover = i['NewRecovered'];
          this.ndeath = i['NewDeaths'];
          this.loaded = true;
        }
      }
    }
    if (this.loaded == false) {
      this.name = "internet disconnected";
    }
  }
}

class Box extends StatelessWidget {
  final String info;
  final int data;
  Box(this.info, this.data);
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.blue,
      child: Stack(children: [
        Text(
          '$info \n',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        Center(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              '$data',
              textAlign: TextAlign.center,
              style: GoogleFonts.breeSerif(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Map<String, double> data = new Map();
  bool loaded = false;
  String countryId;
  List<String> countryList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => appLoader(context));
    Admob.initialize(appId);  
  }

  appLoader(context) async {
    Map<String, dynamic> filejason;
    final directory = await getApplicationDocumentsDirectory();

    final path = directory.path;
    final filepath = "$path/data.json";

    await getJson(url, filepath);
    File file = File(filepath);

    String content = await file.readAsString();
    filejason = json.decode(content);

    countryList = [];
    for (var i in filejason['Countries']) {
      countryList.add(i['Country']);
    }
    countryList.add('Global');
    setState(() {
      countryId = "Global";
      press();
    });
  }

  press() async {
    setState(() {
      loaded = false;
    });

    await country.dataloader(countryId);
    setState(() {
      data['Deaths'] = country.tdeath.toDouble();
      data['Recovered'] = country.trecover.toDouble();
      loaded = true;
    });
  }

  List<Color> _colors = [
    Colors.redAccent,
    Colors.teal,
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 80,
            left: 20,
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
                '${country.name}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            )),
        Positioned(
            top: 120,
            child: loaded
                ? Stack(children: [
                    Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(5.0),
                        width: MediaQuery.of(context).size.width,
                        child: PieChart(
                          dataMap: data,
                          colorList:
                              _colors, // if not declared, random colors will be chosen
                          animationDuration: Duration(milliseconds: 1500),
                          chartLegendSpacing: 32.0,
                          chartRadius: MediaQuery.of(context).size.width /
                              2.7, //determines the size of the chart
                          showChartValuesInPercentage: true,
                          showChartValues: true,
                          showChartValuesOutside: false,
                          chartValueBackgroundColor: Colors.grey[200],
                          showLegends: true,
                          legendPosition: LegendPosition
                              .right, //can be changed to top, left, bottom
                          decimalPlaces: 1,
                          showChartValueLabel: true,
                          initialAngle: 30,
                          chartValueStyle: defaultChartValueStyle.copyWith(
                            color: Colors.blueGrey[900].withOpacity(0.9),
                          ),
                          chartType:
                              ChartType.ring, //can be changed to ChartType.ring
                        ))
                  ])
                : Container(
                    height: 0,
                    width: 0,
                    //child: LinearProgressIndicator(),
                  )),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            //color: dropdncolor,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(5.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    color: Colors.white.withOpacity(0.6),
                    child: DropDownField(
                      onValueChanged: (dynamic value) {
                        setState(() {
                          countryId = value;
                          //dropdncolor=Colors.transparent;
                          press();
                          FocusScope.of(context).requestFocus(FocusNode());
                        });
                      },
                      value: countryId,
                      required: false,
                      strict: true,
                      icon: Icon(Icons.flag),
                      hintText: 'Choose a country',
                      labelText: 'Country',
                      items: countryList,
                    ),
                  ),
                ]),
          ),
        ),
        Positioned(
          top: 290,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  Box("Total Cases", country.tcases),
                  Box("New Cases", country.ncases),
                  Box("Total Recovered", country.trecover),
                  Box("New Recovered", country.nrecover),
                  Box("Total Deaths :", country.tdeath),
                  Box("New Deaths :", country.ndeath),
                ],
              )),
        ),
        Positioned(
          bottom: 0,
          child:Container(
          width: MediaQuery.of(context).size.width,
          child: AdmobBanner(
            adUnitId: addunitId,
            adSize: AdmobBannerSize.BANNER,
          ),),
        )
      ],
    );
  }
}

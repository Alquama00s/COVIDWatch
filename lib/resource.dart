import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'common.dart';
import 'dart:io';

Future getJson(String s) async {
  Map<String, dynamic> file;
  http.Response response = await http.get(s);
  file = json.decode(response.body);
  return file;
}

/*prototype getJson("https://api.covid19india.org/data.json").then((fgha){
    print(fgha["cases_time_series"][0]);
  });*/
class Country {
  String name;
  int tcases, trecover, tdeath, ncases, nrecover, ndeath,loaded=0; 
  dataloder(String country) {
    Map<String, dynamic> filejason;
    File file = File('test/data.json');
    Future<String> content = file.readAsString();
    content.then((value) {filejason = json.decode(value);
    this.name = country;
    for (var i in filejason['Countries']) {
      if (i['Country'] == country) {
        this.tcases = i['TotalConfirmed'];
        this.trecover = i['TotalRecovered'];
        this.tdeath = i['TotalDeaths'];
        this.ncases = i['NewConfirmed'];
        this.nrecover = i['NewRecovered'];
        this.ndeath = i['NewDeaths'];
        this.loaded=1;
      }
      if(this.loaded==1){
      _next();
      this.loaded=0;}
    }});
  }

}/*the following is compulsory to be declared globaly final x=Country();
  _next(){
    function to run after the loader function
  }*/

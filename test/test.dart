import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:path_provider/path_provider.dart';
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
   
   
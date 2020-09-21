import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
/*prototype getJson("https://api.covid19india.org/data.json").then((fgha){
    print(fgha["cases_time_series"][0]);
  });*/
/*the following is compulsory to be declared globaly final x=Country();
  _next(){
    function to run after the loader function
  }*/
  bool internet=true;
getJson(String url, String relPath) async {
  Map<String, dynamic> file;
  try{
  http.Response response = await http.get(url);
  if(response.statusCode==200){
  file = json.decode(response.body);
  final filename = relPath;
  new File(filename).writeAsString(json.encode(file));}
  }
  on SocketException catch (_) {
  internet=false;
}
} //downlaod and save it to location
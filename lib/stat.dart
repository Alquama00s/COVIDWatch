import 'package:flutter/material.dart';
// 1
import 'package:http/http.dart';

class Network {
  final String url;
  //2
  Network(this.url);

  // 3
  Future getData() async {
    print('Calling uri: $url');
    // 4
    Response response = await get(url);
    // 5
    if (response.statusCode == 200) {
      // 6
      return response.body;
    } else {
      print(response.statusCode);
    }
  }
}//newly added


class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 500,
                    right: 25,
                    child: Text("item1"),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Text("item2"),
                  )
                ],
              ),
            );
  }
}

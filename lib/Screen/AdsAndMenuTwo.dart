import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdsAndMenuTwo extends StatefulWidget {
  const AdsAndMenuTwo({Key? key}) : super(key: key);

  @override
  State<AdsAndMenuTwo> createState() => _AdsAndMenuTwoState();
}

class _AdsAndMenuTwoState extends State<AdsAndMenuTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ads"),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))
            ),
          ),
          Positioned(top: 170,
              child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))
            ),
          ))
        ],
      ) //Center,
    );
  }
}

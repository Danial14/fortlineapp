import 'package:flutter/material.dart';

import 'customclipper.dart';

class UserComplain extends StatefulWidget {
  const UserComplain({Key? key}) : super(key: key);

  @override
  State<UserComplain> createState() => _UserComplainState();
}

class _UserComplainState extends State<UserComplain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipPath(child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .5,
            color: Colors.red,
          ),
            clipper: MyClipper(),
          )
        ],
      ),
    );
  }
}

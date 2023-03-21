import 'package:flutter/material.dart';
import 'package:fortline_app/Screen/AdsAndMenuTwo.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'homescreen.dart';

class PdfScreen extends StatelessWidget {
  late String _email;
  PdfScreen(String email){
    this._email = email;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
          return HomeScreen(_email);
        }));
        return true;
      },
      child: Scaffold(
        body: SfPdfViewer.asset("assets/Fortline_Company profile.pdf"),
      ),
    );
  }
}
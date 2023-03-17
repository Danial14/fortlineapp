import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customclipper.dart';
import 'package:http/http.dart' as http;

class UserComplain extends StatefulWidget {
  late String _email;
  UserComplain(String email){
    this._email = email;
  }

  @override
  State<UserComplain> createState() => _UserComplainState();
}

class _UserComplainState extends State<UserComplain> {
  final _formKey = GlobalKey<FormState>();
  String _coMplain = "";
  var _referenceNo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipPath(child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .5 * .2,
            left: 10
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.red,
                  Colors.black12
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                tileMode: TileMode.repeated
              )
            ),
            child: const Text('Complaints',style: TextStyle(
              fontFamily: "SpaceGrotesk",
            ),
            ),
          ),
            clipper: MyClipper(),
          ),
          SingleChildScrollView(
              child: Form(
                key: _formKey,
              child: Padding(padding: EdgeInsets.all(15),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              onSaved: (val){
                                _referenceNo = val!;
                              },
                              validator: (val){
                                if(val == null || val == ""){
                                  return "Please enter valid reference no";
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: "Reference no",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(color: Colors.black12)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(color: const Color(0xffce0505))
                                  )
                              ),
                            ),
                            TextFormField(
                              maxLines: 7,
                              onSaved: (val){
                                _coMplain = val!;
                              },
                              validator: (val){
                                if(val == null || val == ""){
                                  return "Please enter some sort of complaint message";
                            }
                              },
                              decoration: InputDecoration(
                                  hintText: "Complaints",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(color: Colors.black12)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(color: const Color(0xffce0505))
                                  )
                              ),
                            ),
                            SizedBox(height: 10,),
                            ElevatedButton(onPressed: (){
                              _submitComplaint();
                            }, child: Text("Submit"),
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xffce0505)),
                            )
                          ],
                        ),),
            ),
          )
        ],
      ),
    );
  }
  void _submitComplaint() async{
    bool isValid = _formKey.currentState!.validate();
    if(isValid){
      _formKey.currentState!.save();
      var response = await http.post(Uri.http("142.132.194.26:1251","/ords/fortline/reg/complain"), headers: <String, String>{
        "Content" : "application/json"
      },
      body: jsonEncode({
        "INSBY" : widget._email,
        "TKTREMARKS" : _coMplain,
        "PRNCPLREFNO" : _referenceNo
      })
      );
    }
  }
}

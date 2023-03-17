import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomerComplain extends StatefulWidget {
  late String _email;
  CustomerComplain(String email){
    this._email = email;
  }
  @override
  State<CustomerComplain> createState() => _CustomerComplainState();
}

class _CustomerComplainState extends State<CustomerComplain> {
  List<dynamic> _complaints = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaints',style: TextStyle(
          fontFamily: "SpaceGrotesk",
        ),
        ),
        backgroundColor: const Color(0xffce0505),
      ),
      body: FutureBuilder<bool>(
        future: _fetchComplaints(),
        builder: (ctx, snapshot){
          if(snapshot.hasData){
            if(snapshot.data!){
              return ListView.builder(itemBuilder: (ctx, position){
                return Card(
                  child: Padding(padding: EdgeInsets.only(top: 10, left: 10),
                    child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          const Text("Ticket no : "),
                          Text(_complaints[position]["tktno_c"])
                        ],
                        ),
                        SizedBox(height: 10,),
                        Row(children: <Widget>[
                          const Text("Reference no : "),
                          Text(_complaints[position]["prncplrefno"])
                        ],
                        ),
                        SizedBox(height: 10,),
                        Row(children: <Widget>[
                          const Text("Complaint : "),
                          Text(_complaints[position]["tktremarks"])
                        ],
                        ),
                        SizedBox(height: 10,),
                        Row(children: <Widget>[
                          const Text("Customer : "),
                          Text(_complaints[position]["tktremarks"])
                        ],
                        ),
                      ],
                    ),
                  ),
                );
              });
            }
          }
          return Center(
            child: const Text("Something went wrong"),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: (){
        },
        child: const Text(
          "Complaint"
        ),
      ),
    );
  }
  Future<bool> _fetchComplaints() async{
    try{
      var response = await http.get(Uri.http("142.132.194.26:1251", "/ords/fortline/reg/getcmpln", {
        "insby" : widget._email
      }));
      _complaints = (jsonDecode(response.body.toString()))["items"];
      if(_complaints.length > 0) {
        return true;
      }
    }
    catch(e){
      print("fetchComplaintsError : ${e.toString()}");
    }
    return false;
  }
}

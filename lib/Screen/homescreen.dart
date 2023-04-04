import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fortline_app/Screen/Dashboard_Screen.dart';
import 'package:fortline_app/Screen/customer_complain.dart';
import 'package:fortline_app/Screen/pdf_viewer.dart';
import 'package:fortline_app/Screen/products.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'Login_Screen.dart';

class HomeScreen extends StatefulWidget {
  late String _email;
  HomeScreen(String email){
    this._email = email;
  }
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Uri _url = Uri.parse('tel://021111992999');
  final List<Uint8List> imgList = [];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  String assetsPdfPath = '';
  bool _gotIMages = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffb00202),
                Color(0xfff54e4e),
                Color(0xfff77e7e),

              ],
          ),
      ) ,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(

          actions: [
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: DropdownButton(underline: Container() ,icon:const Icon(
                Icons.more_vert,
                color: Colors.white,

              ),
                items: [
                  DropdownMenuItem(value: 'MyAccount',child: Container(child: Row(
                    children: const <Widget>[
                      Icon(Icons.manage_accounts,color: Color(0xffce0505),),

                      SizedBox(width: 8,),

                      Text('My Account',style: TextStyle(
                        fontFamily: "SpaceGrotesk",
                      ),
                      ),
                    ],
                  ),),
                  ),
                  DropdownMenuItem(value: 'Call',child: Container(child: Row(
                    children: const <Widget>[
                      Icon(Icons.call,color: Color(0xffce0505),),

                      SizedBox(width: 8,),

                      Text('Call',style: TextStyle(
                        fontFamily: "SpaceGrotesk",
                      ),
                      ),
                    ],
                  ),),
                  ),
                  DropdownMenuItem(value: 'logout',child: Container(
                    child: Row(
                      children: const <Widget>[
                        Icon(Icons.exit_to_app,color: Color(0xffce0505),),

                        SizedBox(width: 8,),

                        Text('LogOut',style: TextStyle(
                          fontFamily: "SpaceGrotesk",
                        ),
                        ),
                      ],
                    ),
                  ),
                  ),
                ],
                onChanged: (itemIdentifier) {
                  if(itemIdentifier == 'logout'){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginView(),
                    ),
                    );
                  }
                  else if(itemIdentifier == 'MyAccount') {
                    print('My Account');

                  }
                  else if(itemIdentifier == 'Call') {
                    UrlLauncher.launchUrl(_url);

                  }
                },
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          title: const Text('Fortline',style: TextStyle(
            fontFamily: "SpaceGrotesk",
            fontSize: 25,
          ),
          ),

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox( height: 20,),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: const Text('Welcome',style: TextStyle(
                    fontFamily: "SpaceGrotesk",
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 30,

                  ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6.0),

                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FutureBuilder<bool>(builder: (ctx, snapshot){
                      if(snapshot.hasData){
                        if(snapshot.data!){
                          return Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  print(currentIndex);
                                },
                                child: CarouselSlider(
                                  items: imgList
                                      .map(
                                        (item) => Image.memory(
                                      item,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  )
                                      .toList(),
                                  carouselController: carouselController,
                                  options: CarouselOptions(
                                    scrollPhysics: const BouncingScrollPhysics(),
                                    autoPlay: true,
                                    aspectRatio: 2,
                                    viewportFraction: 1,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: imgList.asMap().entries.map((entry) {
                                    return GestureDetector(
                                      onTap: () => carouselController.animateToPage(entry.key),
                                      child: Container(
                                        width: currentIndex == entry.key ? 17 : 7,
                                        height: 7.0,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 3.0,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: currentIndex == entry.key
                                                ? Colors.white
                                                : Color(0xffce0505)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          );
                        }
                      }
                      return Center(
                        child: Text("Something went wrong"),
                      );
                    },
                    future: _getImages(),
                    )
                  ),
                ),

              ),
              const SizedBox(height: 5,),
              Padding(
                padding: EdgeInsets.all(6.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => DashboardScreen(widget._email),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                            height: screenHeight * 18 / 100,
                            width: screenWidth * 43 / 100,
                            child: Column(

                              children: [
                                SizedBox(height: 30,),
                                Image.asset("assets/images/mail.png"),
                                Text('Invoice',style: TextStyle(
                                  fontFamily: "SpaceGrotesk",
                                  fontSize: 15,

                                ),)
                              ],
                            )
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    InkWell(child: Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                          height: screenHeight * 18 / 100,
                          width: screenWidth * 43 / 100,
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              Image.asset("assets/images/product.png",color: Colors.blue),
                              Text('Product',style: TextStyle(
                                fontFamily: "SpaceGrotesk",
                                fontSize: 15,

                              ),)
                            ],
                          )
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                        return Products(widget._email);
                      }));
                    },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.all(6.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (ctx) => PdfScreen(widget._email)));
                      },
                      child: Card(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                            height: screenHeight * 18 / 100,
                            width: screenWidth * 43 / 100,
                            child: Column(
                              children: [
                                SizedBox(height: 30,),
                                Image.asset("assets/images/profile.png",color: Colors.blue,),
                                Text('Fortline Profile',style: TextStyle(
                                  fontFamily: "SpaceGrotesk",
                                  fontSize: 15,

                                ),)],
                            )
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    InkWell(child: Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                          height: screenHeight * 18 / 100,
                          width: screenWidth * 43 / 100,
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              Image.asset("assets/images/complain.png"),
                              Text('Complaints',style: TextStyle(
                                fontFamily: "SpaceGrotesk",
                                fontSize: 15,

                              ),
                              ),
                            ],
                          )
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                        return CustomerComplain(widget._email);
                      }));
                    },
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.transparent,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: screenWidth * 30 / 100,
                          child: Center(
                            child: Text('Dell',style: TextStyle(
                                fontSize: 25,
                                fontFamily: "SpaceGrotesk",
                                color: Colors.grey,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: screenWidth * 30 / 100,
                          child: Center(
                            child: Text('HP',style: TextStyle(
                                fontSize: 25,
                                fontFamily: "SpaceGrotesk",
                                color: Colors.grey,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: screenWidth * 30 / 100,
                          child: Center(
                            child: Text('Lenovo',style: TextStyle(
                                fontSize: 25,
                                fontFamily: "SpaceGrotesk",
                                color: Colors.grey,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              )

            ],
          ),
        ),

      ),
    );
  }
  Future<bool> _getImages() async{
    try{
      if(!_gotIMages){
      var response = await http.get(Uri.http("194.163.154.21:1251","/ords/fortline/reg/notification"));
      var data = jsonDecode(response.body.toString());
      var blobs = data["items"];
      if(blobs.length > 0) {
        for (int i = 0; i < blobs.length; i++) {
          imgList.add(base64Decode(blobs[i]["contents_blob"]));
        }
        _gotIMages = true;
      }
      }
    }
    catch(e){
      print(e.toString());
    }
    return _gotIMages;
  }
}

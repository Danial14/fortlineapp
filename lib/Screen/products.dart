
import 'package:flutter/material.dart';
import 'package:fortline_app/Screen/AdsAndMenuTwo.dart';
import 'package:fortline_app/Screen/product_item.dart';

class Products extends StatefulWidget {
  late String _email;
  Products(String email){
    this._email = email;
  }
  @override
  State<Products> createState() {
    // TODO: implement createState
    return _ProductsState();
  }
}
class _ProductsState extends State<Products>{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: FutureBuilder<bool>(
        future: _getProducts(),
        builder: (ctx, snapshot){
          if(snapshot.hasData){
            if(snapshot.data!){
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  //crossAxisSpacing: 15,
                ),
                itemBuilder: (ctx, position){
                  return ProductItem();
                },
                itemCount: 4,
              );
            }
          }
          return Center(
            child: Text("Something went wrong"),
          );
        },
      ),
    ), onWillPop: () async{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
        return AdsAndMenuTwo(widget._email);
      }));
      return true;
    });
  }
  Future<bool> _getProducts() async{
    try{
      return true;
    }
    catch(e){
      print("Error fetching : ${e.toString()}");
    }
    return false;
  }
}

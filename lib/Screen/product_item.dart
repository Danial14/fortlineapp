import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget{
  @override
  State<ProductItem> createState() {
    // TODO: implement createState
    return _ProductItemState();
  }
}
class _ProductItemState extends State<ProductItem>{
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(10),
    child: LayoutBuilder(
      builder: (ctx, constraints){
        return InkWell(
          onTap: (){
            print("IMage tap");
            /*Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
              return PdfScreen();
            }));*/
          },
          child: ClipRRect(
            child: GridTile(
              child: Image.asset("assets/images/ups.jpg",
                fit: BoxFit.cover,),
              footer: Container(
                height: constraints.maxHeight * .2,
                child: GridTileBar(backgroundColor: Colors.black,
                  title: Text("Laptop"),
                ),
              ),
            ),
            borderRadius: BorderRadius.circular(15),

          ),
        );
      },
    ),);
  }
}
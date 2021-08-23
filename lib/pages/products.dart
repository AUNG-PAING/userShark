import 'package:flutter/material.dart';
import 'package:home_shop/global.dart';
import 'package:home_shop/utils.dart';

class Product extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products"),leading:
      InkWell(
        onTap: (){
          Navigator.pushNamed(context, "/home");
        },
        child: Container(
          child: Icon(

              Icons.home,size: 45,),
        ),
      ),
        backgroundColor: fourthColor,actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
//          color: Colors.black,
          child:Stack(children: [
          GestureDetector(
            onTap: (){
              print("i am here");
              if(Global.userData==null){
                Navigator.pushNamed(context,"/login");
              }
              else {
                Navigator.pushNamed(context,"/postOrder");
              }
            },
              child: Center(child: Icon(Icons.shopping_cart,size: 40,))),
            Positioned(
              right:1,

              child: Container(
                height: 20,
                width: 20,
                child: Stack(children: [
                Container(

                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                  Center(child: Text(Global.orderList.length.toString()))
              ],),),
            )
        ],),
        )
      ],
      ),
      body: ListView.builder(
        itemCount: Global.productList.length,
        itemBuilder: (context,ind){
          return Card(
//            color: Colors.blue,
            child: Container(
            height: 150,
            child:Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: NetworkImage(Global.productList[ind].image))
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(child: Container(
                  height: 130,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0,7,0,0),
                        padding: EdgeInsets.fromLTRB(5,0,5,0),
                        decoration: BoxDecoration(
                          color:fourthColor,
                          borderRadius: BorderRadius.circular(3)
                        ),
                        child:Text(
                            Global.productList[ind].name,style: TextStyle(color: Colors.white,fontSize: 20),) ,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0,7,0,0),
                        padding: EdgeInsets.fromLTRB(5,0,5,0),
                        decoration: BoxDecoration(
                            color:fourthColor,
                            borderRadius: BorderRadius.circular(3)
                        ),
                        child:Text(
                          Global.productList[ind].desc,style: TextStyle(color: Colors.white,fontSize: 20),) ,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: fourthColor,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomRight: Radius.circular(20))
                        ),
                        margin: EdgeInsets.fromLTRB(0,8,0,0),
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),

                        height: 50,
                        child: Row(children: [
                          Container(
                              child: Text('${Global.productList[ind].price} Ks',style: TextStyle(color: firstColor,fontSize: 20),)),
                          Spacer(),
                          Container(
                            child: Text("Add To Cart =>",style: TextStyle(fontSize: 10),),
                          ),
                          GestureDetector(
                            onTap: ()async{
//                              Global.orderList.add(Global.productList[ind]);
//                              print(Global.orderList);
//                              setState(() {
//
//                              });
                            await check(Global.productList[ind].id,Global.productList[ind]);
                            setState(() {

                            });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 7),
                                child: Icon(Icons.add,color:Colors.yellowAccent,size: 40,)),
                          )
                        ],),
                      )
                    ],
                  ),
                ),)
              ],
            ),
          ),);
        },
      ),
    );
  }
  check(id,index){
    print(Global.orderList.length);
    var existingItem=Global.orderList.firstWhere((element) => element.id == id,
      orElse: ()=>null
    );
    if(existingItem==null){
      Global.orderList.add(index);
    }
  }
}


//static addToCart(ProductModel product) {
//  var existingItem = orderList
//      .firstWhere((element) => element.id == product.id, orElse: () => null);
//
//  if (existingItem == null) {
//    orderList.add(product);
//  }
//  return orderList.length;
//}
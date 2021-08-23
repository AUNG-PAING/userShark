import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:home_shop/api.dart';
import 'package:home_shop/global.dart';
import 'package:home_shop/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(child:
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Container(
                color:fourthColor,
                  height:60, child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Container(
                  height: 40,
                  width: 40 ,
                  color: fourthColor,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context,"/history");
                    },
                    child: Container(

                    padding: EdgeInsets.all(10),
//                    height: 20,
//                    width: 20,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(image:checkImage()),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                    ),
                  ),
                ),
                  SizedBox(width: 10,),
                Container(child: Text(checkName(),style: TextStyle(color: Colors.white),),width: 150,),
                SizedBox(width: 70,),
                checkLoginLogo(),
                  SizedBox(width: 20,),
                  chart()

              ],)),
              Expanded(
                child: Container(
                  color:Colors.blue[50],
                  child: GridView.builder(itemCount: Global.cateList.length
                      ,gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0.05,
                          crossAxisSpacing: 0.05,
                      ), itemBuilder:(context,ind){
                        print(Global.cateList[ind].image);
                        return Card(
                          elevation: 5,
                          child: InkResponse(
                            highlightColor: Colors.deepPurple.withOpacity(1),
                            splashColor: Colors.lightGreenAccent,
                            onTap:()async{
                              await Api.getProducts(Global.cateList[ind].id);
                              Navigator.pushNamed(context,"/product");
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                              color: firstColor,
                              borderRadius: BorderRadius.circular(5),),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: fourthColor,
                                            borderRadius:BorderRadius.circular(5)),

                                        margin: EdgeInsets.fromLTRB(17,5,0,0),
                                        padding: EdgeInsets.fromLTRB(3,1,3,0),
//                        color: fourthColor,
                                        height: 20,
                                        child: Text(Global.cateList[ind].name,style: TextStyle(color: firstColor),)),
                                  ],
                                ),
                                SizedBox(height: 5,),

                                Container(
                                  decoration: BoxDecoration(
                                    image:DecorationImage(image:NetworkImage(Global.cateList[ind].image)),
                                    color: thirdColor,
                                    borderRadius: BorderRadius.circular(10),
//                  shape: BoxShape.circle
                                  ),

                                  height: 160,
                                  width: 160,

                                )
                              ],),
                        ),
                          ),);
                      }),
                ),
              )
            ],),
          )
      ),
//      bottomNavigationBar:ButtonBar(children: [Container(width: 200,height: 30,color: Colors.blue,)],),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        Navigator.pushNamed(context,"/reload");
      },
      backgroundColor: Colors.white,
      child: Icon(Icons.refresh,size: 40,color: Colors.blue,),),
    );
  }

  String checkName() {
    if(Global.userData == null){
      return "You need to login ";
    }
    else{
      return "${Global.userData.name}";
    }
  }

  checkImage() {
    return
    Global.userData == null ? AssetImage('assets/images/images.jpeg') : NetworkImage(Global.userData.profile);
  }

  chart(){
    return Container(
      padding: EdgeInsets.only(top: 5),
//      margin: EdgeInsets.only(right: 10),
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
            child: Center(child: Icon(Icons.shopping_cart,size: 40,color: Colors.white,))),
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
              Center(child: Text(orderCount(),style: TextStyle(color: Colors.white),))
            ],),),
        )
      ],),
    );
  }
  orderCount(){
    return Global.orderList.length.toString();
  }
  checkLoginLogo(){
    return Global.userData==null ? GestureDetector(
      onTap: (){
        Navigator.pushReplacementNamed(context,"/login");
      },
        child: Icon(Icons.person_add,size: 40,color: Colors.white)):Icon(Icons.tag_faces,size: 40,color: Colors.white);
  }
}

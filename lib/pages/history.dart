import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:home_shop/api.dart';
import 'package:home_shop/models/orderModel.dart';
import 'package:home_shop/utils.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List <OrderModel> Data=[];
  loadData()async{
    List<OrderModel> Datas=await Api.getOrder();
    this.Data=Datas.reversed.toList();
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      Column(
        children: [
          Container(
            child: Center(child: Text("Your Orders History Page",style: TextStyle(fontSize: 20,color: Colors.white),)),
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: fourthColor,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20))),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              child: ListView.builder(
//          reverse: true,
//        dragStartBehavior: DragStartBehavior.start,
                  itemCount: Data.length,
                  itemBuilder: (context,index){

                    return ExpansionTile(title: Text("${Data[index].created.substring(0,10)}"),
                      backgroundColor: Colors.white30,
                      subtitle: Text("${Data[index].subtotal} Ks"),
                      children: [
                        ...List.generate(Data[index].items.length, (ind){ return
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Row(children: [
                              Container(
                                child:Text("${Data[index].items[ind].Product.name}"),
                                width: 150,),
                              Container(child: Text("${Data[index].items[ind].price}"),
                                width: 80,),
                              Container(child: Text("${Data[index].items[ind].count}"),
                                width: 80,),
                              Container(child: Text("${int.parse(Data[index].items[ind].price)*int.parse(Data[index].items[ind].count)}")),
                            ],),);
//                Card(
//                  color: Colors.yellowAccent,
//                    child:Text("${Data[index].items[ind].Product.name}${Data[index].items[ind].price}"));

                        })
                      ],
                    );
                  }),
            ),
          ),
          Container(
            child: Column(children: [
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacementNamed(context,"/home");
                },
                child: Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  height: 40,
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Go To Home Page",style: TextStyle(fontSize: 20,color: Colors.black),),Icon(Icons.touch_app,color: Colors.pinkAccent,)],)
                ),
              ),],),
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: fourthColor,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20))),
          ),
        ],
      )
      ),

    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:home_shop/global.dart';
import 'package:home_shop/models/Catemodels.dart';
import 'package:home_shop/models/Profile.dart';
import 'package:home_shop/models/UserModel.dart';
import 'package:home_shop/models/orderModel.dart';
import 'package:home_shop/models/productModel.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Api {
  static Future<bool> getCategoty() async {
    print("I am bobo");
    var url = "${Global.BASE_URL}/cate/";
    var response = await http.get(url);
//    print(response.runtimeType);
    List lisy = jsonDecode(response.body)['result'] as List;
    print(lisy);
    List <CategoryModel>categories = lisy.map((e) => CategoryModel.fromJson(e))
        .toList();
//    print(categories.runtimeType);
    Global.cateList = categories;
  }

  static Future<bool> getProducts(_id) async {
    print(_id);
    var url = "${Global.BASE_URL}/product/getProduct/$_id";
    var response = await http.get(url);
    List lisy = jsonDecode(response.body)["result"] as List;
    List<ProductModels>products = lisy.map((e) => ProductModels.fromJson(e))
        .toList();
    Global.productList = products;
    print(products);
  }

  static Future<bool> login(String userData) async {
    var url = "${Global.BASE_URL}/user/login";
    var respond = await http.post(url, body: userData, headers: Global.headers);

    var data = jsonDecode(respond.body);
    if (data["con"]) {
      Global.userData = UserModel.fromJson(data["result"]);
      print(Global.userData);
      return true;
    } else {
      return false;
    }
  }

  static Future<dynamic> uploadImage(file) async {
    var postUri = Uri.parse("${Global.BASE_URL}/gallery/photoSave");
    http.MultipartRequest request = new http.MultipartRequest("POST", postUri);
    http.MultipartFile responceMulti = await http.MultipartFile.fromPath(
        'photo', file);
    request.files.add(responceMulti);

    await request.send().then((respond) =>
    {
      respond.stream.transform(utf8.decoder).listen((value) async{
        var resdata = jsonDecode(value);

        Global.profileList = await ProfileModel.fromJson(resdata["result"]);
      })
    });
    return Global.profileList;
  }

  static Future<bool> Register(userData) async {
    var url = "${Global.BASE_URL}/user/reg";
    var respond = await http.post(url, body: jsonEncode(userData), headers: Global.headers);

    var data = jsonDecode(respond.body);
    if (data["con"]) {
      return true;
    } else {
      return false;
    }
  }
  static Future<bool>sendOrder()async{
    print("I am order");
    var url = "${Global.BASE_URL}/order/save";
    var body=jsonEncode(Global.loadtoOrderMap());
    var response=await http.post(url,body: body,headers: Global.TokenHeader);
    var res=jsonDecode(response.body);
    return res["con"];
  }
  static Future<List<OrderModel>>getOrder()async{
    var url="${Global.BASE_URL}/order/getOrder/${Global.userData.id}";
    var response=await http.get(url);
    var res=jsonDecode(response.body);
    List lisy=res["result"] as List;
    List <OrderModel>Orders=lisy.map((e) => OrderModel.fromJson(e)).toList();
    return Orders;

  }
}

//
//static Future<bool> loginUser(String userData) async {
//var url = "${Global.BASE_URL}/api/login";
//var response =
//    await http.post(url, body: userData, headers: Global.headers);
//dynamic data = jsonDecode(response.body);
//if (data["con"]) {
//Global.user = UserModel.fromJson(data["user"]);
//print(Global.user.name);
//return true;
//} else {
//return false;
//}
//}

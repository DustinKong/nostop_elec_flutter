import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../main.dart';
import '../api/SpUtil.dart';

int errorRequestTimes = 0;
// ignore: non_constant_identifier_names
Future FutureDio(String methods, String api, Map<String, dynamic> obj) async {
    print(api);
    print(obj);
///注意：请求参数的数据类型是Map，数据结构类型是key为String，value可以是任意类型dynamic
///    example
//    FutureDio('post', Api.ListActivity,{"sid":"076003"} ).then((res){
//       print(res.data);
//     });

  ///接口错误类型
/*  每个接口都有可能返回下面错误：
  -1, "未知错误"
  对404的处理*/

  /// 自定义Header
  Map<String, dynamic> httpHeaders = {
    'content-type': 'application/json',
    'X-Access-Token': '${SpUtil.preferences.getString('user_token')}'
    //'Token':'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MTcyNTcxNDQsInVzZXJuYW1lIjoid3gtc2Vzc2lvbi11c2VyOm90SG5rNU16aDYzamJScmZMcXk3aE9uYlBDbTQifQ.qA1HM8By7XBvgz75cE52B1bHrX4heNZcRXQ4W8McbXI'
  };

  var options = BaseOptions(
      sendTimeout:1500,
      connectTimeout: 6000,
      receiveTimeout: 6000,
      responseType: ResponseType.json,
      validateStatus: (status) {
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
      headers: httpHeaders);

  Dio dio = new Dio(options);

  try {
    Response response;
    /// 判断请求的方式调用dio不同的请求api
    if (methods == "post") {
      response = await dio.post(api, data: obj);
    } else if (methods == 'get') {
      response = await dio.get(api, queryParameters: obj);
    }
    else if (methods == 'put') {
      response = await dio.put(api,data: obj);
    }
    //注意get请求使用queryParameters接收参数，post请求使用data接收参数
    ///返回正常
    print(response.data);
    // print(response.data['code']);
    if (response.data['code'] == 200||response.data['code'] == 0) {
      return response; //返回请求结果
    }
    else {
    // else if (response.data['code'] == 401) {
      print("code401");
      Fluttertoast.showToast(
          msg: response.data['message']??"请重新登录!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          fontSize: 16.0);
      print(response.data['message']);
      print(response.data);
      // Future.delayed(Duration(milliseconds: 800)).then((e) {
      //   Router.navigatorKey.currentState.pushNamedAndRemoveUntil('/login', (route) => false);
      // });
      Router.navigatorKey.currentState.pushNamedAndRemoveUntil('/login', (route) => false);
    }
    ///接口错误
    // else if (response.data['code'] == -1) {
    //   Fluttertoast.showToast(
    //       msg: response.data['msg']??"未知错误",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.black38,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    //   print(response.data['msg']);
    //   print(response.data);
    //   Future.delayed(Duration(milliseconds: 800)).then((e) {
    //     Router.navigatorKey.currentState.pushNamedAndRemoveUntil('/', (route) => false);
    //   });
    // }
    // else {
    //   if(response.data['message']!=null&&response.data['message']!=""){
    //     Fluttertoast.showToast(
    //         msg: response.data['message'] ?? "未知错误",
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.CENTER,
    //         timeInSecForIosWeb: 1,
    //         backgroundColor: Colors.black38,
    //         textColor: Colors.white,
    //         fontSize: 16.0);
    //   }
    // }
  } catch (e) {
    print("catch401");
    print("code401");
    Fluttertoast.showToast(
        msg: "请重新登录!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black38,
        textColor: Colors.white,
        fontSize: 16.0);
    // Future.delayed(Duration(milliseconds: 800)).then((e) {
    //   Router.navigatorKey.currentState.pushNamedAndRemoveUntil('/login', (route) => false);
    // });
    Router.navigatorKey.currentState.pushNamedAndRemoveUntil('/login', (route) => false);
  }
}

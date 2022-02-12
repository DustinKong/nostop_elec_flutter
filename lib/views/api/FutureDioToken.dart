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
    if (response.data['code'] == 200) {
      return response; //返回请求结果
    }
    else if (response.data['code'] == 400) {
      return response; //返回请求结果
    }
    else if (response.data['code'] == 401) {
      Fluttertoast.showToast(
          msg: response.data['message']??"未知错误",
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
    else if (response.data['code'] == -1) {
      Fluttertoast.showToast(
          msg: response.data['msg']??"未知错误",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          fontSize: 16.0);
      print(response.data['msg']);
      print(response.data);
      Future.delayed(Duration(milliseconds: 800)).then((e) {
        Router.navigatorKey.currentState.pushNamedAndRemoveUntil('/', (route) => false);
      });
    }
    ///无权访问
    // else if (response.data['code'] == 51) {
    //   Fluttertoast.showToast(
    //       msg: '请重新登录！',
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.black38,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    //   print('无权访问');
    //   Future.delayed(Duration(milliseconds: 800)).then((e) {
    //     Router.navigatorKey.currentState.pushNamedAndRemoveUntil('/', (route) => false);
    //   });
    // }
    ///token失效 请重新登录
    // else if (response.data['code'] == 109) {
    //   Fluttertoast.showToast(
    //       msg: response.data['msg'] ?? "请重新登录",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.black38,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    //   print('request error');
    //   Future.delayed(Duration(milliseconds: 800)).then((e) {
    //     Router.navigatorKey.currentState.pushNamedAndRemoveUntil('/login', (route) => false);
    //   });
    // }
    else {
      if(response.data['message']!=null&&response.data['message']!=""){
        Fluttertoast.showToast(
            msg: response.data['message'] ?? "未知错误",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black38,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  } catch (e) {
    errorRequestTimes++;
    if(errorRequestTimes%7 == 0) {//每7次错误请求提示一次，避免提示过于频繁
      Fluttertoast.showToast(
          msg: "连接超时",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 0,
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}

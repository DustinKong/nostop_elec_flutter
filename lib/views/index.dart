import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import './Tabs.dart';
import 'api/api.dart';
import 'api/api2.dart';
import 'api/SpUtil.dart';
import 'api/FutureDioToken.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  //轮播图
  List _swiperList = [];
  List courseList = [];
  ScrollController _scrollController;
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //判断是否登录
    String token = SpUtil.preferences.getString('user_token');
    print(token);
    if (token == null) {
      Future.delayed(Duration(milliseconds: 100)).then((e) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      });
    } else
      FutureDio('get', Api.getUserPermissionByToken, {"pageNo":1,"pageSize":33}).then((res) {
        print(res.data['data']);
      });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            children: <Widget>[
              Container(
                child: Text("不停电作业"),
                padding: EdgeInsets.only(left: 15),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/searchPage');
                })
          ],
          backgroundColor: Color(0xff3954A3),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                      // height: 300,
                      child: Image.asset('assets/images/imgLogin.jpg', fit: BoxFit.cover))
                ],
              ),
//              height: 280.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff3954A3),
                    Color(0xff3954A3),
                    Color(0xff3954A3),
                    Colors.white,
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text(
                  "作业规范",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              onTap: () {Navigator.pushNamed(context, "/homeStandardPage");},
            ),
            InkWell(
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text(
                  "任务列表",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              onTap: () {Navigator.pushNamed(context, "/homePlanPage");},
            ),
          ],
        ));
  }
}

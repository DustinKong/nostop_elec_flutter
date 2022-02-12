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
    }

    FutureDio('get', Api.Rotation, {}).then((res) {
      print(res.data['data']);
      setState(() {
        _swiperList = res.data['data'];
      });
    });
    FutureDio('get', Api2.TopCourses, {
      // "category":0,
      // "status":0
    }).then((res) {
      print(res.data['data']);
      setState(() {
        courseList = res.data['data'];
      });
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
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                      // height: 300,
                      child: AspectRatio(
                        aspectRatio: 20 / 8,
                        child: Swiper(
                          autoplay: true,
                          key: UniqueKey(),
                          itemBuilder: (BuildContext context, int index) {
                            // return CachedNetworkImage(
                            //   imageUrl: _swiperList[index]["picture"],
                            //   fit: BoxFit.cover,
                            // );
                            return Image.asset('assets/images/imgLogin.jpg', fit: BoxFit.cover);
                          },
                          itemCount: _swiperList.length,
                          viewportFraction: 0.8,
                          scale: 0.9,
                          pagination: SwiperPagination(
                              builder: DotSwiperPaginationBuilder(
                                  size: 5, color: Colors.black12, activeColor: Colors.pinkAccent, activeSize: 5)),
                        ),
                      ))
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
            SizedBox(height: 15,),

          ],
        ));
  }
}

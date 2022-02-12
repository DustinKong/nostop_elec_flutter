import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../api/api.dart';
import '../api/SpUtil.dart';
import '../api/FutureDioToken.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Map userInfo = {};
  @override
  void initState() {
    super.initState();
    FutureDio('get', Api.UserInfo, {"user_id": SpUtil.preferences.getString("user_id")}).then((res) {
      print(res.data['data']);
      setState(() {
        userInfo = res.data['data'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading:false,
          elevation: 0, // 隐藏阴影
          centerTitle: true,
          title: new Text("个人中心"),
          backgroundColor: Color(0xff3954A3),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/mySettingPage');
              },
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(8, 15, 8, 10),
              height: 90,
              color: Color(0xff3954A3),
              child: ListTile(
                leading: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: userInfo['head'] ??
                        "https://qtt-cmall.oss-accelerate.aliyuncs.com/rotation/202104/1617546202220logo.png",
                    fit: BoxFit.cover,
                    height: 65,
                    width: 65,
                  ),
                ),
                title: Text(
                  userInfo['nickname'] ?? "新用户",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/myProfilePage');
                    }),
              ),
            ),
            Container(
              constraints: BoxConstraints(
                minHeight: 400,
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      child: Container(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 10),
                    height: 130,
                    color: Color(0xff3954A3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // InkWell(
                        //   child: Column(
                        //     children: <Widget>[
                        //       Container(
                        //         child: Image.asset("assets/images/centre/download.png"),
                        //         height: 40,
                        //         width: 40,
                        //       ),
                        //       SizedBox(
                        //         height: 10,
                        //       ),
                        //       Text(
                        //         "离线缓存",
                        //         style: TextStyle(fontSize: 16, color: Colors.white),
                        //       ),
                        //     ],
                        //   ),
                        //   onTap: () {
                        //     Navigator.pushNamed(context, '/myAttentionPage');
                        //   },
                        // ),
                        // Container(
                        //   color: Color(0xff7f93ce),
                        //   height: 45,
                        //   width: 3,
                        // ),
                        InkWell(child:  Column(
                          children: <Widget>[
                            Container(
                              child: Image.asset("assets/images/centre/collect.png"),
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "我的收藏",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),onTap: (){
                          Navigator.pushNamed(context, '/myCollectPage');
                        },)
                       ,
                        Container(
                          color: Color(0xff7f93ce),
                          height: 45,
                          width: 3,
                        ),
                        InkWell(child: Column(
                          children: <Widget>[
                            Container(
                              child: Image.asset("assets/images/centre/follow.png"),
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "我的关注",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),onTap: (){
                          Navigator.pushNamed(context, '/myAttentionPage');
                        },)
                        ,
                        Container(
                          color: Color(0xff7f93ce),
                          height: 45,
                          width: 3,
                        ),
                        InkWell(child: Column(
                          children: <Widget>[
                            Container(
                              child: Image.asset("assets/images/centre/watchhistory.png"),
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "观看历史",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),onTap: (){
                          Navigator.pushNamed(context, '/myRecordVideoPage');
                        },)
                        ,
                        Container(
                          color: Color(0xff7f93ce),
                          height: 45,
                          width: 3,
                        ),
                        InkWell(child: Column(
                          children: <Widget>[
                            Container(
                              child: Image.asset("assets/images/centre/history.png"),
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "浏览记录",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),onTap: (){
                          Navigator.pushNamed(context, '/myRecordCoursePage');
                        },)
                        ,
                      ],
                    ),
                  )),
                  Positioned(
                    child: Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Container(
                          width: ScreenUtil.screenWidth * 0.88,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Image.asset("assets/images/book.png"),
                                          height: 40,
                                          width: 40,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "已报名",
                                          style: TextStyle(fontSize: 16, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(context, '/myCourseSignedPage');
                                    },
                                  ),
                                  InkWell(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Image.asset("assets/images/centre/comment.png"),
                                          height: 45,
                                          width: 45,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "待评价",
                                          style: TextStyle(fontSize: 16, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(context, '/myCourseCommentPage');
                                    },
                                  ),
                                  InkWell(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Image.asset("assets/images/centre/aftersale.png"),
                                          height: 45,
                                          width: 45,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "售后",
                                          style: TextStyle(fontSize: 16, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(context, '/myCourseAllPage');
                                    },
                                  ),
                                  InkWell(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Image.asset("assets/images/centre/order.png"),
                                          height: 45,
                                          width: 45,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "全部订单",
                                          style: TextStyle(fontSize: 16, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(context, '/myCourseAllPage');
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                leading: Container(
                                  height: 30,
                                  width: 30,
                                  // child: Image.asset('assets/images/centre/discount.png'),
                                  child: Icon(Icons.settings,color: Color(0xff3954A3),size: 28,)
                                ),
                                title: Text("系统设置"),
                                onTap: (){
                                  Navigator.pushNamed(context, '/mySettingPage');
                                },
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                leading: Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset('assets/images/centre/help.png'),
                                ),
                                title: Text("问题反馈"),
                                onTap: (){
                                  Navigator.pushNamed(context, '/myQuestionPage');
                                },
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ],
                          ),
                        )),
                    top: 85,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '暂无数据';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活')),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast(); // 轮播列表
            List<Map> navigatorList =
                (data['data']['category'] as List).cast(); // 导航列表
            String advertesPicture =
                data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片
            String leaderImage = data['data']['shopInfo']['leaderImage']; //店长图片
            String leaderPhone = data['data']['shopInfo']['leaderPhone']; //店长电话

            return SingleChildScrollView(
              child: Column(children: <Widget>[
                SwiperDiy(
                  swiperDataList: swiper,
                ), // 首页轮播模块
                TopNavigator(navigatorList: navigatorList), // 首页导航模块
                AdBanner(advertesPicture: advertesPicture), // 广告模块
                LeaderPhone(
                    leaderImage: leaderImage,
                    leaderPhone: leaderPhone), // 店长电话模块
              ]),
            );
          } else {
            return Center(child: Text('加载中...'));
          }
        },
      ),
    );
  }
}

// 首页轮播模块
class SwiperDiy extends StatelessWidget {
  final List swiperDataList; // 轮播列表
  const SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('设备宽度:${ScreenUtil.screenWidth}');
    // print('设备高度:${ScreenUtil.screenHeight}');
    // print('设备像素密度:${ScreenUtil.pixelRatio}');
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${swiperDataList[index]['image']}",
              fit: BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

// 首页导航模块
class TopNavigator extends StatelessWidget {
  final List navigatorList; // 导航列表
  const TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext content, item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
          crossAxisCount: 5,
          padding: EdgeInsets.all(4.0),
          children: navigatorList.map((item) {
            return _gridViewItemUI(context, item);
          }).toList()),
    );
  }
}

// 广告模块
class AdBanner extends StatelessWidget {
  final String advertesPicture; // 广告图片
  const AdBanner({Key key, this.advertesPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(advertesPicture),
    );
  }
}

// 店长电话模块
class LeaderPhone extends StatelessWidget {
  final String leaderImage; // 店长图片
  final String leaderPhone; // 店长电话
  const LeaderPhone({Key key, this.leaderImage, this.leaderPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(onTap: _launchUrl, child: Image.network(leaderImage)),
    );
  }

  void _launchUrl() async {
    String url = 'tel:' + leaderPhone;
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

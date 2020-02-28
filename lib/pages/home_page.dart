import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();
  String showText = '欢迎您来到美丽人间';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('美丽人间'),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            TextField(
              controller: typeController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                labelText: '类型',
                helperText: '请输入你喜欢的类型',
              ),
              autofocus: false,
            ),
            RaisedButton(
              onPressed: _choiceAction,
              child: Text('选择完毕'),
            ),
            Text(
              showText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          ],
        )),
      ),
    );
  }

  void _choiceAction() {
    print('开始选择你喜欢的类型...');
    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('类型不能为空'),
              ));
    } else {
      setState(() {
        showText = 'mockData';
      });
      // getHttp(typeController.text.toString()).then((res) {
      //   setState(() {
      //     showText = res['data'];
      //   });
      // });
    }
  }

  Future getHttp(String TypeText) async {
    try {
      Response response;
      var data = {'name': TypeText};

      response = await Dio().get('mockUrl', queryParameters: data);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     getHttp();

//     return Scaffold(body: Center(child: Text('HomePage')));
//   }

//   void getHttp() async {
//     try {
//       Response response;
//       response = await Dio().get(
//           'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=大胸美女');
//       print(response);
//     } catch (e) {
//       print(e);
//     }
//   }
// }

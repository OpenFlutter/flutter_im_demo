import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_im_demo/mqtt/MQTTAppState.dart';
import 'package:flutter_im_demo/mqtt/MQTTManager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String community;
  final MQTTManager mqttManager;


  ChatPage({Key key, this.community, this.mqttManager}) : super(key: key);

  @override
  _ChatPageState createState() {
    return _ChatPageState();
  }
}

class _ChatPageState extends State<ChatPage> {

  TextEditingController _messageController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(widget.community),
      ),
      body: Consumer<MQTTAppState>(
          builder: (context, appState, widget){
            debugPrint("此时appStatr:${appState.getAppConnectionState}");
            return ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
                children: <Widget>[
                  _buildScrollableTextWith(appState.getHistoryText),
                  _bottomBar(),
                ],
            );
          },
        ),
    );
  }

  Widget _bottomBar()
  {
    return Container(
          margin: EdgeInsets.only(left: 25.w),
          width: 700.w,
          child: Stack(
            children: <Widget>[
              TextField(
                style: TextStyle(fontSize: 35.sp),
                controller: _messageController,
                decoration: InputDecoration(
                    focusColor: Colors.cyan
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 600.w),
                child: IconButton(
                  onPressed: (){
                    FocusScope.of(context).requestFocus(FocusScopeNode());
                    _publishMessage(_messageController.text);
                    debugPrint("发送消息");
                  },
                  icon: Icon(Icons.send,
                    color: Colors.cyan,),
                ),
              )
            ],
          )
      );

  }

  Widget _buildScrollableTextWith(String text) {
    debugPrint("收到的消息是：${text.toString()}");
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
          color: Colors.cyan,
          width: 700.w,
          height: 950.h,
          child: ListView(
            children: <Widget>[
              Text(text)
            ],
          ),
        ),
    );
  }

  void _publishMessage(String text) {
    String osPrefix = 'Flutter_iOS';
    if(Platform.isAndroid){
      osPrefix = 'Flutter_Android';
    }
    final String message = osPrefix + ' says: ' + text;
    widget.mqttManager.publish(message);
    _messageController.clear();
  }
}
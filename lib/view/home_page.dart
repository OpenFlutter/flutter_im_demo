import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_im_demo/mqtt/MQTTAppState.dart';
import 'package:flutter_im_demo/mqtt/MQTTManager.dart';
import 'package:flutter_im_demo/view/chat_page.dart';
import 'package:flutter_im_demo/widget/argonButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {


  MQTTAppState currentAppState;
  MQTTManager manager;

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
    final MQTTAppState appState = Provider.of<MQTTAppState>(context);
    // Keep a reference to the app state.
    currentAppState = appState;
    ScreenUtil.init(context, width: 751, height: 1334);

    _prepareStateMessageFrom(currentAppState.getAppConnectionState);
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset("assets/image/background_image.png",fit: BoxFit.cover,),
          ),
          BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: new Container(
              color: Colors.white.withOpacity(0.1),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              margin: EdgeInsets.only(top: 250.h),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 120.w,
                    child: Image.asset("assets/image/flutter-logo.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 200.h),
                    width: 600.w,
                    child: TextField(
                      keyboardAppearance: Brightness.light,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 0),
                        labelText: "请输入你的昵称",
                        labelStyle: TextStyle(
                          color: Colors.white
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:400.h),
                    child: ArgonButton(
                      height: 50,
                      roundLoadingShape: true,
                      width: MediaQuery.of(context).size.width * 0.45,
                      onTap: (startLoading, stopLoading, btnState) {
                        if (btnState == ButtonState.Idle) {
                          startLoading();

                          _connectMQTT();

                        } else {
                          stopLoading();
                        }
                      },
                      child: Text(
                        "登录",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      loader: Container(
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator(
                        ),
                      ),
                      borderRadius: 5.0,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _prepareStateMessageFrom(MQTTAppConnectionState state) {
    switch (state) {
      case MQTTAppConnectionState.connected:
        debugPrint("已连接");
        Future.delayed(Duration(milliseconds: 200)).then((e) {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => ChatPage()
          ));
        });
        break;
      case MQTTAppConnectionState.connecting:
        debugPrint("正在连接");
        break;
      case MQTTAppConnectionState.disconnected:
        debugPrint("未连接");
        break;
    }
  }

  _connectMQTT()
  {
    String osPrefix = 'Flutter_iOS';
    if(Platform.isAndroid){
      osPrefix = 'Flutter_Android';
    }

    manager = MQTTManager(
        host: "test.mosquitto.org",
        topic: "flutter/amp/cool",
        identifier: osPrefix,
        state: currentAppState);
    manager.initializeMQTTClient();
    manager.connect();
  }


}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatPage extends StatefulWidget {
  final String community;
  ChatPage({Key key, this.community}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 1000.h,left: 25.w),
              width: 700.w,
              child: Stack(
                children: <Widget>[
                  TextField(
                    style: TextStyle(fontSize: 35.sp),
                    controller: _messageController,
                    decoration: InputDecoration(
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 600.w),
                    child: IconButton(
                      onPressed: (){
                        debugPrint("发送消息");
                      },
                      icon: Icon(Icons.send,
                      color: Colors.cyan,),
                    ),
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
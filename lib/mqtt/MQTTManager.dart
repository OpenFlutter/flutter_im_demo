import 'package:flutter/cupertino.dart';
import 'package:flutter_im_demo/mqtt/MQTTAppState.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTManager{

  // Private instance of client
  final MQTTAppState _currentState;
  MqttServerClient _client;
  final String _identifier;
  final String _host;
  final String _topic;

  // 构造函数
  MQTTManager({
    @required String host,
    @required String topic,
    @required String identifier,
    @required MQTTAppState state
  }
      ): _identifier = identifier, _host = host, _topic = topic, _currentState = state ;

  void initializeMQTTClient(){
    _client = MqttServerClient(_host,_identifier);
    _client.port = 1883;
    _client.keepAlivePeriod = 20;
    _client.onDisconnected = onDisconnected;
    _client.secure = false;
    _client.logging(on: true);

    /// 连接成功回调
    _client.onConnected = onConnected;
    _client.onSubscribed = onSubscribed;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(_identifier)
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    print('MQTT 服务器连接中...');
    _client.connectionMessage = connMess;
  }
  // Connect to the host
  void connect() async{
    assert(_client != null);
    try {
      print('MQTT 服务器连接中...');
      _currentState.setAppConnectionState(MQTTAppConnectionState.connecting);
      await _client.connect();
    } on Exception catch (e) {
      print('MQTT 服务器报错 - $e');
      disconnect();
    }
  }

  void disconnect() {
    print('Disconnected');
    _client.disconnect();
  }

  void publish(String message){
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client.publishMessage(_topic, MqttQos.exactlyOnce, builder.payload);
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('正在订阅主题： $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('MQTT 服务器断开');
    if (_client.connectionStatus.returnCode == MqttConnectReturnCode.noneSpecified) {
      print("MQTT服务器断开回调");
    }
    _currentState.setAppConnectionState(MQTTAppConnectionState.disconnected);
  }

  /// 连接成功回调
  void onConnected() {
    _currentState.setAppConnectionState(MQTTAppConnectionState.connected);
    print('MQTT 服务器连接成功！');
    _client.subscribe(_topic, MqttQos.atLeastOnce);
    _client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload;
      final String pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      _currentState.setReceivedText(pt);
      print(
          '订阅主题是：<${c[0].topic}>,消息是： <-- $pt -->');
      print('');
    });
  }
}
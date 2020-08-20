<p align="center">
<img src=https://github.com/OpenFlutter/flutter_im_demo/blob/master/showImage/main_showImage2.png alt="drawing" width="900">
</p>

## 文章相关博客
[Flutter IM方案探索——MQTT](https://juejin.im/post/5f2114cc6fb9a07ea55f2d07)

## GIF展示图
<p align="center">
<img src=https://github.com/tongyangsheng/flutter_im_demo/blob/master/showImage/gifshow.gif alt="drawing" width="300">
</p>

## 说明
&emsp;&emsp;💡为了给大家实现IM功能提供一些思路，🚦区别于市面上的接入第三方IM平台方案，本项目使用MQTT实现了一个简单的即时通信功能🤖，希望能给大家提供一些思路。目前许多flutter大型项目中的IM模块错综复杂或只是简单的通过三方SDK收发，并不方便各位的学习和参考，所以本人结合自己的经验专门写了一个Demo，仅包含简单的IM通信功能。各位可以以此为基础实现自己所需的相关业务功能。🤠
## 使用
* 首先，要明确的是测试IM相关功能你需要两个模拟器📱。<br/>
* 如GIF所示，确定要建立通信的目标和自己的昵称后即可点击登录进入一个简单的仿微信界面。<br/>
* 两个模拟器可以尝试发动消息，实现一个简单的IM收发功能(订阅相同主题)。
## 彩🥚
&emsp;&emsp;为了让项目看起来不那么空洞🔧，我在项目内加入了一个动态的登录按钮，也通过UI手段实现了区分本人消息和他人消息，配置了一个类似微信的界面，这都算是一些小的功能点，有些看起来简单，实现上还是花费了一些功夫的🤯，各位有需要也可以直接拿去用就可以了。
## 尾声
&emsp;&emsp;如果你觉得这个Demo对你的学习，或者后续开发有一些启发作用可以给项目点一颗🌟，感谢。

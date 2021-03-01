# 项目说明

**Android平台下目录结构说明**

> ShareSDKPlus包含一个整体的工程，名称为ApiCloud。此工程是一个在AndroidStudio环境下开发ApiCloud的工程。其中app文件夹是Android Studio环境下的效果展示demo
>

| 模块名                 | 备注                                                       |
| :--------------------- | ---------------------------------------------------------- |
| shareSDKPlus           | ShareSDK核心库，**必须引入**。                             |
| ShareSDKPlusQZone      | qq空间模块                                                 |
| ShareSDKPlusInstagram  | Instagram模块                                              |
| ShareSDKPlusWhatsApp   | WhatsApp模块                                               |
| ShareSDKPlusGooglePlus | GooglePlus模块（因APICloud方不支持AndroidX，该平台不可用） |
| ShareSDKPlusFacebook   | Facebook模块                                               |
| ShareSDKPlusTwitter    | Twitter模块                                                |
| ShareSDKPlusQQ         | QQ模块，使用qq空间也必须引入此模块。（注意事项见附录）     |
| ShareSDKPlusSinaWeibo  | 新浪微博模块                                               |
| ShareSDKPlusWechat     | 微信模块                                                   |
| ShareSDKPlusAlipay     | 支付宝模块                                                 |
| ShareSDKPlusKakao      | Kakao模块(暂不可用)                                        |
| ShareSDKPlusLine       | Line模块                                                   |
| ShareSDKPlusDingding   | 钉钉模块                                                   |

shareSDKPlus已经发布到APICloud商店中，使用最新版即可。各个分享平台的模块需要下载zip后在APICloud上传自定义模块方可使用。

**例**：如您项目中需使用支付宝和微信，则在APICloud勾选**mobcommonlib**模块和**shareSDKPlus**模块，上传**ShareSDKPlusWechat**以及**ShareSDKPlusAlipay**模块，打自定义Loader即可。

# API接口

| 接口               | 参数                                                         | 释义                                      |
| ------------------ | ------------------------------------------------------------ | ----------------------------------------- |
| init               | 无                                                           | 初始各平台信息化接口，需在使用SDK之前调用 |
| authorize          | **platform**：对应平台的数值，平台数值对应表详见script/ShareSDK.js | 授权                                      |
| cancelAuthorize    | **platform**：对应平台的数值，平台数值对应表详见script/ShareSDK.js | 取消授权                                  |
| getUserInfo        | **platform**：对应平台的数值，平台数值对应表详见script/ShareSDK.js | 获取用户信息                              |
| shareContent       | **shareParams**：分享参数<br/>**platform**：对应平台的数值，平台数值对应表详见script/ShareSDK.js<br/>**shareType**:分享类型 | 分享                                      |
| oneKeyShareContent | **shareParams**：分享参数<br/>**hiddenPlatformList**：要隐藏的分享平台<br/> | 一键分享                                  |

# shareParams分享参数详解

> shareParams支持的所有参数

| 参数名     | 类型   |
| ---------- | ------ |
| text       | String |
| ImageArray | Array  |
| imageUrl   | String |
| title      | String |
| Hashtag    | String |
| titleUrl   | String |
| musicUrl   | String |
| url        | String |
| site       | String |
| siteUrl    | String |



# 附录

1. 使用QQ空间时，QQ模块也必须引入，即ShareSDKPlusQZone和ShareSDKPlusQQ模块都需要引入。

2. 使用QQ模块时，需要修改ShareSDKPlusQQ.zip内容。

   步骤为：

   	1. 解压ShareSDKPlusQQ.zip
    	2. 修改解压出的ShareSDKPlusQQ/res文件夹下的AndroidManifest.xml文件中${QQ-AppKey}内容，把${QQ-AppKey}替换为自己应用的QQAPPkey

   修改后的内容为：其中1234567则为自己QQ的appkey

   ```
   <?xml version="1.0" encoding="utf-8"?>
   <manifest xmlns:android="http://schemas.android.com/apk/res/android"
       package="com.mob.sharesdkplusqq">
       <application>
   
           <activity
               android:name="cn.sharesdk.tencent.qq.ReceiveActivity"
               android:launchMode="singleTask"
               android:noHistory="true">
               <intent-filter>
                   <action android:name="android.intent.action.VIEW" />
   
                   <category android:name="android.intent.category.DEFAULT" />
                   <category android:name="android.intent.category.BROWSABLE" />
   
                   <data android:scheme="tencent1234567" />
               </intent-filter>
           </activity>
       </application>
   </manifest>
   ```

   	3. 修改完成，压缩ShareSDKPlusQQ文件夹，压缩方式选择标准。



# 安卓端设置应用账号信息

在apicloud官网添加模块并打自定义loader后，config.xml文件中会有feature 标签，name为shareSDKPlus，在该标签中添加如下内容：

```
<param name="Mob-AppKey" value="moba0b0c0d0" />
<param name="Mob-AppSecret" value="5713f0d88511f9f4cf100cade0610a34" />

<param name="WeChat-AppId" value="wx4868b35061f87885" />
<param name="WeChat-AppSecret" value="64020361b8ec4c99936c0e3999a9f249" />
<param name="WeChat-WithShareTicket" value="true" />
<param name="WeChat-BypassApproval" value="false" />

<param name="SinaWeibo-AppKey" value="568898243" />
<param name="SinaWeibo-AppSecret" value="38a4f8204cc784f81f9f0daaf31e02e3" />
<param name="SinaWeibo-ShareByAppClient" value="true" />
<param name="SinaWeibo-RedirectUrl" value="http://www.sharesdk.cn" />

<param name="QQ-AppId" value="100371282" />
<param name="QQ-AppKey" value="aed9b0303e3ed1e27bae87c33761161d" />
<param name="QQ-ShareByAppClient" value="true" />
<param name="QQ-BypassApproval" value="false" />

<param name="Google-ClientID" value="232554794995.apps.googleusercontent.com" />
<param name="Google-RedirectUri" value="http://localhost" />
<param name="Google-ShareByAppClient" value="true" />

<param name="Facebook-ConsumerKey" value="1412473428822331" />
<param name="Facebook-ConsumerSecret" value="a42f4f3f867dc947b9ed6020c2e93558" />
<param name="Facebook-RedirectUrl" value="https://mob.com" />
<param name="Facebook-ShareByAppClient" value="true" />

<param name="Twitter-ConsumerKey" value="viOnkeLpHBKs6KXV7MPpeGyzE" />
<param name="Twitter-ConsumerSecret" value="NJEglQUy2rqZ9Io9FcAU9p17omFqbORknUpRrCDOK46aAbIiey" />
<param name="Twitter-CallbackUrl" value="http://mob.com" />
<param name="Twitter-ShareByAppClient" value="true" />
<param name="Twitter-BypassApproval" value="true" />

<param name="Instagram-ClientId" value="ff68e3216b4f4f989121aa1c2962d058" />
<param name="Instagram-ClientSecret" value="1b2e82f110264869b3505c3fe34e31a1" />
<param name="Instagram-RedirectUri" value="http://sharesdk.cn" />
<param name="Instagram-ShareByAppClient" value="true" />

<param name="Alipay-AppId" value="2015072400185895" />

<param name="Kakao-AppKey" value="48d3f524e4a636b08d81b3ceb50f1003" />

<param name="Telegram-AppKey" value="782826033" />
<param name="Telegram-RedirectUrl" value="http://www.mob.com" />

<param name="Line-ChannelID" value="1639219273" />
<param name="Line-ChannelSecret" value="58faad55ffce8bf8f63b59fe6fb702ae" />
<param name="Line-RedirectUri" value="https://www.mob.com/" />

<param name="Dingding-AppId" value="dingoanxyrpiscaovl4qlw" />
<param name="Dingding-BypassApproval" value="false" />
<param name="Dingding-RedirectUrl" value="http://localhost" />
```

添加完成后图示：

![image-20210225110206187](http://download.sdk.mob.com/2021/02/25/11/1614222132297645.54.png)
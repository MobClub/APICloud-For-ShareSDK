/*
Title: shareSDKPlus
Description: ShareSDK在APICloud平台的插件
*/

<p style="color: #ccc; margin-bottom: 30px;">来自于：Mob官方<a style="background-color: #95ba20; color:#fff; padding:4px 8px;border-radius:5px;margin-left:30px; margin-bottom:0px; font-size:12px;text-decoration:none;" target="_blank" href="//www.apicloud.com/mod_detail/shareSDKPlus">立即使用</a></p>


<div class="outline">
[iOS配置](#p1)

[android配置](#p2)

[常量须知](#a0)

[authorize](#a1)

[cancelAuthorize](#a2)

[getUserInfo](#a3)

[shareContent](#a4)

[oneKeyShareContent](#a5)

</div>

## 概述

当前ShareSDK版本，iOS：v4.3.3、android：v3.8.5

### ShareSDK简介

ShareSDK是为iOS、Android的App提供社交分享功能的一个组件，开发者仅需10分钟即可集成到自己的App中，它不仅支持包括QQ、微信、新浪微博、腾讯微博、豆瓣、Facebook、Twitter、Google+等国内外40多家的主流社会平台，未来继续不断扩展。帮助开发者轻松实现社会分享、第三方登录、关注、获得用户资料、获取好友列表等主流的功能，还有强大的社会化统计分享分析管理后台，可以实时了解用户、分享量、回流率等数据，有效地指导移动App的日常运营与推广，同时为App引入更多的社会平台流量。


### ShareSDK功能

- 第三方登录，即用微信、QQ、微博等社交网络账号登录，用户不必经过填写注册信息、上传头像等繁琐步骤就可使用App。
- 一键分享，支持分享图文、音乐、视频、链接等各种富媒体内容，在App界面点击分享至该社交平台，不用弹出分享菜单栏，实现一键分享。
- 短链转换，在分享出去的链接中，用户看到的是您官方地址，而非ShareSDK；开启短链转换后，实时统计回流率，帮助开发者精细化运营。
- 好友关系运用，轻松实现获取微博好友关系、微博内容、用户资料、LBS信息，建立好友链，活跃社区氛围，增加用户粘度。
- 数据统计分析，ShareSDK后台实时统计分享数、分享回流率、用户分布、社交平台选择等数据，全面诊断App各维度，助力产品优化改进。
- 评论和点赞，用户在登录后可对你设置的主题进行评论或点赞，同时您也能在后台审核评论内容，建立良好的社区氛围。


### shareSDKPlus 模块概述

shareSDKPlus封装了ShareSDK,是对APICloud平台的支持，为APICloud开发的App提供社交分享功能的一个组件，支持包括QQ、微信、新浪微博等多家主流社会平台，帮助开发者轻松实现社会分享、第三方登录、关注、获得用户资料、获取好友列表等主流的功能。

如有问题请联系技术支持:  

```
服务电话:   400-685-2216  
节假日值班电话:
    iOS: 185-1664-1951
Android: 185-1664-1950
电子邮箱:  support@mob.com
市场合作:  021-54623189
```

## 模块使用攻略

开发者使用本模块之前需要先到[Mob官网](https://www.mob.com)申请开发者账号，并在账号内填写相应信息创建自己的 APP，从而获取AppKey和AppSecret,然后添加ShareSDK功能。  
详情参考:[快速集成获取apppkey和appSecret](http://wiki.mob.com/%E4%BA%A7%E5%93%81%E7%AE%80%E4%BB%8B-5/)


**使用此模块之前建议先配置  [config.xml](https://docs.apicloud.com/Dev-Guide/app-config-manual) 文件，配置完毕，需通过云端编译生效，配置方法如下：**

<div id="p1"></div>

### iOS：
**1.配置config.xml文件** 下面是配置各个平台urlScheme列子，开发者自行删减。下面的值都是sharesdk demo测试使用，开发者自行调整

```xml
  <feature name="shareSDKPlus">
    
        <param name="urlScheme" value="wx617c77c82218ea2c" />

        <param name="urlScheme" value="wb568898243" />

        <param name="urlScheme" value="tencent100371282" />
        <param name="urlScheme" value="QQ05FB8B52" />

        <param name="urlScheme" value="ap2017062107540437" />

        <param name="urlScheme" value="fb1412473428822331" />

        <param name="urlScheme" value="line3rdp.com.mob.product.ShareSDK" />

        <param name="urlScheme" value="yx0d9a9f9088ea44d78680f3274da1765f" />

        <param name="urlScheme" value="pdk4987008320438021391" />

        <param name="urlScheme" value="kakao9c17eb03317e0e627ec95a400f5785fb" />

        <param name="urlScheme" value="dingoabcwtuab76wy0kyzo" />

        <param name="urlScheme" value="pocketapp1234" />

        <param name="urlScheme" value="vk5312801" />

        <param name="urlScheme" value="twitterkit-viOnkeLpHBKs6KXV7MPpeGyzE" />

        <param name="urlScheme" value="rm226427com.mob.product.ShareSDK" />

        <param name="urlScheme" value="ak1412473428822331" />

        <param name="urlScheme" value="aw9ivykfjvi4hpwo" />
 
  </feature>
```

>字段描述:  
> **urlScheme**：用于实现应用间跳转及数据交换，跳转到第三方应用客户端进行分享或授权后，从第三方应用客户端平台跳回到当前应用。urlScheme的value值根据第三方平台规则设置。可以配置多个urlScheme。  
> 
> 各个平台配置规范：    
> **微信**:微信开放平台获取的appid，URL scheme为wx+appid 如：wx617c77c82218ea2c  
> 
> **QQ**:填两个URL scheme: 一个是tencent + appId ; 一个是 QQ + appId 转换成的十六进制（如果appId转换的16进制数不够8位则在前面补0，如转换的是：5FB8B52，则最终填入为：QQ05FB8B52 注意：转换后的字母要大写），这里的 QQ 一定要是大写   
> 
> **新浪微博**:新浪微博开放平台获取到的appkey,URL scheme为wb+appkey 如：wb568898243  
> 
> **Facebook**:URL scheme为fb+appid 如：fb1412473428822331  
> 
> 

**2.配置 key.xml 文件**  
需要将第三方平台（微博、QQ、微信、twitter、facebook等）申请的appkey、appsecret、redirecturi等参数配置到 key.xml 文件中。  
**key.xml 配置详解：**  
key.xml 文件需要放在 widget://res 文件目录下，格式如下：

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<security>
    <item name="shareSDKPlus_SinaWei_AppKey" value="568898243" />
    <item name="shareSDKPlus_SinaWei_AppSecret" value="38a4f8204cc784f81f9f0daaf31e02e3" />
    <item name="shareSDKPlus_SinaWei_RedirectUri" value="http://www.sharesdk.cn" />

    <item name="shareSDKPlus_QQ_AppKey" value="100371282" />
    <item name="shareSDKPlus_QQ_AppSecret" value="aed9b0303e3ed1e27bae87c33761161d" />

    <item name="shareSDKPlus_Wechat_AppKey" value="wx617c77c82218ea2c" />
    <item name="shareSDKPlus_Wechat_AppSecret" value="c7253e5289986cf4c4c74d1ccc185fb1" />
    <item name="shareSDKPlus_Wechat_AppUniversalLink" value="https://www.sandslee.com/" />

    <item name="shareSDKPlus_Douyin_AppKey" value="aw9ivykfjvi4hpwo" />
    <item name="shareSDKPlus_Douyin_AppSecret" value="42b4caa6bda60bd49f05f06d0a4956e1" />

    <item name="shareSDKPlus_Facebook_AppKey" value="1412473428822331" />
    <item name="shareSDKPlus_Facebook_AppSecret" value="a42f4f3f867dc947b9ed6020c2e93558" />
    <item name="shareSDKPlus_Facebook_DisplayName" value="shareSDK" />

    <item name="shareSDKPlus_Twitter_AppKey" value="viOnkeLpHBKs6KXV7MPpeGyzE" />
    <item name="shareSDKPlus_Twitter_AppSecret" value="NJEglQUy2rqZ9Io9FcAU9p17omFqbORknUpRrCDOK46aAbIiey" />
    <item name="shareSDKPlus_Twitter_RedirectUri" value="http://mob.com" />

    <item name="shareSDKPlus_Instagram_AppKey" value="ff68e3216b4f4f989121aa1c2962d058" />
    <item name="shareSDKPlus_Instagram_AppSecret" value="1b2e82f110264869b3505c3fe34e31a1" />
    <item name="shareSDKPlus_Instagram_RedirectUri" value="http://sharesdk.cn" />

    <item name="shareSDKPlus_Google_AppKey" value="232554794995.apps.googleusercontent.com" />
    <item name="shareSDKPlus_Google_AppSecret" value="PEdFgtrMw97aCvf0joQj7EMk" />
    <item name="shareSDKPlus_Google_RedirectUri" value="http://localhost" />

    <item name="shareSDKPlus_Line_AuthType" value="2" />

    <item name="shareSDKPlus_AliPaySocial_AppKey" value="2017062107540437" />

    <item name="shareSDKPlus_MeiPai_AppKey" value="1089867639" />

    <item name="shareSDKPlus_DingTalk_AppKey" value="dingoabcwtuab76wy0kyzo" />

    <item name="shareSDKPlus_DouBan_AppKey" value="02e2cbe5ca06de5908a863b15e149b0b" />
    <item name="shareSDKPlus_DouBan_AppSecret" value="9f1e7b4f71304f2f" />
    <item name="shareSDKPlus_DouBan_RedirectUri" value="http://www.sharesdk.cn" />

    <item name="shareSDKPlus_TencentWeibo_AppKey" value="801307650" />
    <item name="shareSDKPlus_TencentWeibo_AppSecret" value="ae36f4ee3946e1cbb98d6965b0b2ff5c" />
    <item name="shareSDKPlus_TencentWeibo_RedirectUri" value="http://www.sharesdk.cn" />

    <item name="shareSDKPlus_YinXiang_AppKey" value="46131514-6903" />
    <item name="shareSDKPlus_YinXiang_AppSecret" value="08d7a6f3afcc888a" />
    <item name="shareSDKPlus_YinXiang_Sandbox" value="1" />

    <item name="shareSDKPlus_YouDaoNote_AppKey" value="dcde25dca105bcc36884ed4534dab940" />
    <item name="shareSDKPlus_YouDaoNote_AppSecret" value="d98217b4020e7f1874263795f44838fe" />
    <item name="shareSDKPlus_YouDaoNote_RedirectUri" value="http://www.sharesdk.cn/" />

    <item name="shareSDKPlus_Mingdao_AppKey" value="97230F25CA5C" />
    <item name="shareSDKPlus_Mingdao_AppSecret" value="A5DC29AF7C5A5851F28E903AE9EAC0" />
    <item name="shareSDKPlus_Mingdao_RedirectUri" value="http://mob.com" />

    <item name="shareSDKPlus_Kaixin_AppKey" value="358443394194887cee81ff5890870c7c" />
    <item name="shareSDKPlus_Kaixin_AppSecret" value="da32179d859c016169f66d90b6db2a23" />
    <item name="shareSDKPlus_Kaixin_RedirectUri" value="http://www.sharesdk.cn/" />

    <item name="shareSDKPlus_Renren_AppId" value="226427" />
    <item name="shareSDKPlus_Renren_AppKey" value="fc5b8aed373c4c27a05b712acba0f8c3" />
    <item name="shareSDKPlus_Renren_AppSecret" value="f29df781abdd4f49beca5a2194676ca4" />
    <item name="shareSDKPlus_Renren_AuthType" value="2" />

    <item name="shareSDKPlus_YiXin_AppKey" value="yx0d9a9f9088ea44d78680f3274da1765f" />
    <item name="shareSDKPlus_YiXin_AppSecret" value="1a5bd421ae089c3" />
    <item name="shareSDKPlus_YiXin_RedirectUri" value="https://open.yixin.im/resource/oauth2_callback.html" />

    <item name="shareSDKPlus_Kakao_AppKey" value="9c17eb03317e0e627ec95a400f5785fb" />
    <item name="shareSDKPlus_Kakao_ApiKey" value="802e551a5048c3172fc1dedaaf40fcf1" />
    <item name="shareSDKPlus_Kakao_RedirectUri" value="http://www.mob.com/oauth" />

    <item name="shareSDKPlus_YouTube_AppKey" value="906418427202-jinnbqal1niq4s8isbg2ofsqc5ddkcgr.apps.googleusercontent.com" />
    <item name="shareSDKPlus_YouTube_AppSecret" value="" />
    <item name="shareSDKPlus_YouTube_RedirectUri" value="http://localhost" />

    <item name="shareSDKPlus_Flickr_AppKey" value="cbed81d4a1bc7417693ab7865e354717" />
    <item name="shareSDKPlus_Flickr_AppSecret" value="4c490343869091f2" />

    <item name="shareSDKPlus_Dropbox_AppKey" value="us514wslpfojbxc" />
    <item name="shareSDKPlus_Dropbox_AppSecret" value="w0nmp4os3ngo1ja" />
    <item name="shareSDKPlus_Dropbox_RedirectUri" value="http://localhost" />

    <item name="shareSDKPlus_Evernote_AppKey" value="46131514-6903" />
    <item name="shareSDKPlus_Evernote_AppSecret" value="08d7a6f3afcc888a" />
    <item name="shareSDKPlus_Evernote_Sandbox" value="1" />

    <item name="shareSDKPlus_Pinterest_AppKey" value="4987008320438021391" />

    <item name="shareSDKPlus_Pocket_AppKey" value="11496-de7c8c5eb25b2c9fcdc2b627" />
    <item name="shareSDKPlus_Pocket_RedirectUri" value="pocketapp1234" />

    <item name="shareSDKPlus_LinkedIn_AppKey" value="46kic3zr7s4n" />
    <item name="shareSDKPlus_LinkedIn_AppSecret" value="RWw6WRl9YJOcdWsj" />
    <item name="shareSDKPlus_LinkedIn_RedirectUri" value="http://baidu.com" />

    <item name="shareSDKPlus_VKontakte_AppKey" value="5312801" />
    <item name="shareSDKPlus_VKontakte_AppSecret" value="ZHG2wGymmNUCRLG2r6CY" />
    <item name="shareSDKPlus_VKontakte_AuthType" value="2" />

    <item name="shareSDKPlus_Instapaper_AppKey" value="4rDJORmcOcSAZL1YpqGHRI605xUvrLbOhkJ07yO0wWrYrc61FA" />
    <item name="shareSDKPlus_Instapaper_AppSecret" value="GNr1GespOQbrm8nvd7rlUsyRQsIo3boIbMguAl9gfpdL0aKZWe" />

    <item name="shareSDKPlus_Tumblr_AppKey" value="2QUXqO9fcgGdtGG1FcvML6ZunIQzAEL8xY6hIaxdJnDti2DYwM" />
    <item name="shareSDKPlus_Tumblr_AppSecret" value="3Rt0sPFj7u2g39mEVB3IBpOzKnM3JnTtxX2bao2JKk4VV1gtNo" />
    <item name="shareSDKPlus_Tumblr_RedirectUri" value="http://sharesdk.cn" />

    <item name="shareSDKPlus_SMS_CountryList" value="0" />

    <item name="shareSDKPlus_CMCC_AppId" value="300011862498" />
    <item name="shareSDKPlus_CMCC_AppKey" value="38D9CA1CC280C5F207E2C343745D4A4B" />
    <item name="shareSDKPlus_CMCC_DisplayUI" value="1" />

    <item name="shareSDKPlus_Telegram_BotToken" value="646009290:AAGSonNPZqyjl0MUER8MdM8pwSPritFVNgI" />
    <item name="shareSDKPlus_Telegram_BotDomain" value="http://www.mob.com" />

    <item name="shareSDKPlus_Reddit_AppKey" value="ObzXn50T7Cg0Xw" />
    <item name="shareSDKPlus_Reddit_RedirectUri" value="https://www.mob.com/reddit_callback" />

    <item name="shareSDKPlus_ESurfing_AppKey" value="8148612606" />
    <item name="shareSDKPlus_ESurfing_AppSecret" value="mCltrhUqwshFa86egDTs0491ibaAulKA" />
    <item name="shareSDKPlus_ESurfing_AppName" value="shareSDK" />
</security>

```

以上可能出现的全部各个平台的配置，根据开发者需要删减，另外部分特殊平台需要在info.plist文件中配置

>字段描述:  
> shareSDKPlus_SinaWei_AppKey: 从新浪微博开放平台获取的App Key.  
> shareSDKPlus_SinaWei_AppSecret: 从新浪微博开放平台获取的App Secret.  
> shareSDKPlus_SinaWei_RedirectUri:  从新浪微博开放平台创建应用时 自定义填写的回调url  
> 其他也是都是各自开放平台获取  
> 
> 


**配置info.plist文件**
该文件含MOB平台MOBAppKey和MOBAppSecret、特殊平台appkey配置、白名单配置,将info.plist放在widget://res文件目录下，文件内容：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>

    <key>MOBAppKey</key>
    <string>moba6b6c6d6</string>
    <key>MOBAppSecret</key>
    <string>b89d2427a3bc7ad1aea1e1e8c1d36bf3</string>

    <key>AccountKitClientToken</key>
    <string>c30c08723aa8c48fbd5e01d1c3103891</string>
    <key>FacebookAppID</key>
    <string>1412473428822331</string>
    <key>KAKAO_APP_KEY</key>
    <string>9c17eb03317e0e627ec95a400f5785fb</string>
    <key>LineSDKConfig</key>
    <dict>
        <key>ChannelID</key>
        <string>1521201864</string>
    </dict>
    
    <key>LSApplicationQueriesSchemes</key>
    <array>
        <string>weixinULAPI</string>
        <string>kakaotalk-5.9.7</string>
        <string>pinterestsdk.v1</string>
        <string>vkauthorize</string>
        <string>storylink</string>
        <string>kakaolink</string>
        <string>storykompassauth</string>
        <string>kakaokompassauth</string>
        <string>yixinfav</string>
        <string>yixinoauth</string>
        <string>yixinopenapi</string>
        <string>yixin</string>
        <string>pocket-oauth-v1</string>
        <string>dingtalk-open</string>
        <string>dingtalk</string>
        <string>alipayshare</string>
        <string>alipay</string>
        <string>whatsapp</string>
        <string>tim</string>
        <string>timapi</string>
        <string>timopensdkfriend</string>
        <string>timwpa</string>
        <string>timgamebindinggroup</string>
        <string>timapiwallet</string>
        <string>timOpensdkSSoLogin</string>
        <string>wtlogintim</string>
        <string>timopensdkgrouptribeshare</string>
        <string>timopensdkapiV4</string>
        <string>timgamebindinggroup</string>
        <string>timopensdkdataline</string>
        <string>wtlogintimV1</string>
        <string>timapiV1</string>
        <string>yixinoauth</string>
        <string>yixin</string>
        <string>sinaweibohd</string>
        <string>sinaweibo</string>
        <string>weibosdk2.5</string>
        <string>weibosdk</string>
        <string>weibo</string>
        <string>sinaweibosso</string>
        <string>weixin</string>
        <string>youtube</string>
        <string>mpsharesdk11</string>
        <string>mpsharesdk10</string>
        <string>mtmv</string>
        <string>mqqopensdkapiV4</string>
        <string>mqzone</string>
        <string>mqqwpa</string>
        <string>wtloginmqq2</string>
        <string>mqzoneopensdkapiV2</string>
        <string>mqzoneopensdkapi19</string>
        <string>mqzoneopensdkapi</string>
        <string>mqzoneopensdk</string>
        <string>mqqopensdkapiV3</string>
        <string>mqqopensdkapiV2</string>
        <string>mqq</string>
        <string>mqqOpensdkSSoLogin</string>
        <string>mqqapi</string>
        <string>lineauth</string>
        <string>line</string>
        <string>instagram</string>
        <string>fbauth</string>
        <string>fb-messenger-platform-20150714</string>
        <string>fb-messenger</string>
        <string>fbauth2</string>
        <string>fbapi</string>
        <string>fbapi20130214</string>
        <string>twitterauth</string>
        <string>tg</string>
        <string>telegram</string>
        <string>renrenapi</string>
        <string>renrenios</string>
        <string>renreniphone</string>
        <string>douyinsharesdk</string>
        <string>douyinopensdk</string>
    </array>
    
    <key>NSPhotoLibraryAddUsageDescription</key>
    <string>写入相册视频</string>
    <key>NSPhotoLibraryUsageDescription</key>
    <string>从手机相册中选择</string>
    
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
    
</dict>
```

> **MOBAppKey、MOBAppSecret**:（必须配置）从mob平台创建应用后，申请的app Key和app Secret.  
> **KAKAO_APP_KEY**:从kaKao平台申请的 app Key，若iOS平台需要使用kaKaoTalk、kaKaoStory平台进行分享，必须添加此字段  
> **LineSDKConfig**:line平台配置  
> **LSApplicationQueriesSchemes**:白名单配置，用于判断是否安装第三方客户端及跳转到第三方客户端， 注意用到哪个就配置哪个，无用的可以不配置  
> 
> 
> 注意：   
> 配置白名单，也可以在配置config.xml文件中，配置方法参考[配置可被检测的URL Scheme](https://docs.apicloud.com/Dev-Guide/app-config-manual#14-4)。配置内容参考[mob官网](http://wiki.mob.com/ios9-%E5%AF%B9sharesdk%E7%9A%84%E5%BD%B1%E5%93%8D%EF%BC%88%E9%80%82%E9%85%8Dios-9%E5%BF%85%E8%AF%BB%EF%BC%89/)    
> 配置ATS（App Transport Security），在info.plist文件中，APP可以使用http协议访问。配置方法参考[iOS修改Info.plist之配置ATS](https://community.apicloud.com/bbs/forum.php?mod=viewthread&tid=20). 


​    
<div id="p2"></div>

### Android 
> Android配置第三方平台的AppKey等信息遵循APICloud的惯例是在config.xml中配置。
> 在name为"ShareSDKPlus"的<feature>标签内，配置<param>标签来填充AppKey等属性的值。
> 下面是配置各个平台AppKey、AppSecret、RedirectUrl的例子，实际的使用中需要开发者填写自己在第三方网站申请的值（只需要改变值，不要改变AppKey、AppSecret、RedirectUrl等名称，否则将会读取不到）

#### 应用账号信息设置

	<feature name="shareSDKPlus">
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
	
	  </feature>

#### Android端支持平台

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

#### API接口

| 接口               | 参数                                                         | 释义                                                      |
| ------------------ | ------------------------------------------------------------ | --------------------------------------------------------- |
| init               | 无                                                           | 初始各平台信息化接口，需在使用SDK之前调用（Android Only） |
| authorize          | **platform**：对应平台的数值，平台数值对应表详见script/ShareSDK.js | 授权                                                      |
| cancelAuthorize    | **platform**：对应平台的数值，平台数值对应表详见script/ShareSDK.js | 取消授权                                                  |
| getUserInfo        | **platform**：对应平台的数值，平台数值对应表详见script/ShareSDK.js | 获取用户信息                                              |
| shareContent       | **shareParams**：分享参数<br/>**platform**：对应平台的数值，平台数值对应表详见script/ShareSDK.js<br/>**shareType**:分享类型 | 分享                                                      |
| oneKeyShareContent | **shareParams**：分享参数<br/>**hiddenPlatformList**：要隐藏的分享平台<br/> | 一键分享                                                  |

#### 附录

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



## **模块接口**

<div id="a0"></div>

首先添加一个ShareSDK.js内容如下：

```js
/**
 * 常量：分享类型，分享/授权平台，分享/授权结果状态
 */
function ShareSDK()
{
    /**
     * JSON字符串转换为对象
     * @param string        JSON字符串
     * @returns {Object}    转换后对象
     */
    
    JsonStringToObject = function (string)
    {
        try
        {
            return eval("(" + string + ")");
        }
        catch (err)
        {
            return null;
        }
    };

    this.JsonStringToObject = function (string)
    {
        return JsonStringToObject(string);
    }
    
    /**
     * 对象转JSON字符串
     * @param obj           对象
     * @returns {string}    JSON字符串
     */
    ObjectToJsonString = function (obj)
    {
        var S = [];
        var J = null;

        var type = Object.prototype.toString.apply(obj);

        if (type === '[object Array]')
        {
            for (var i = 0; i < obj.length; i++)
            {
                S.push(ObjectToJsonString(obj[i]));
            }
            J = '[' + S.join(',') + ']';
        }
        else if (type === '[object Date]')
        {
            J = "new Date(" + obj.getTime() + ")";
        }
        else if (type === '[object RegExp]'
            || type === '[object Function]')
        {
            J = obj.toString();
        }
        else if (type === '[object Object]')
        {
            for (var key in obj)
            {
                var value = ObjectToJsonString(obj[key]);
                if (value != null)
                {
                    S.push('"' + key + '":' + value);
                }
            }
            J = '{' + S.join(',') + '}';
        }
        else if (type === '[object String]')
        {
            J = '"' + obj.replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\n/g, '') + '"';
        }
        else if (type === '[object Number]')
        {
            J = obj;
        }
        else if (type === '[object Boolean]')
        {
            J = obj;
        }

        return J;
    };

    this.ObjectToJsonString = function (obj)
    {
        return ObjectToJsonString(obj);
    }
                                                         
    /**
     * 平台类型
     * @type {object}
     */
    this.PlatformID = {
        Unknown : 0,
        SinaWeibo : 1,			//Sina Weibo         
        TencentWeibo : 2,		//Tencent Weibo          
        DouBan : 5,				//Dou Ban           
        QZone : 6, 				//QZone           
        Renren : 7,				//Ren Ren           
        Kaixin : 8,				//Kai Xin          
        Pengyou : 9,			//Friends          
        Facebook : 10,			//Facebook         
        Twitter : 11,			//Twitter         
        Evernote : 12,			//Evernote        
        Foursquare : 13,		//Foursquare      
        GooglePlus : 14,		//Google+       
        Instagram : 15,			//Instagram      
        LinkedIn : 16,			//LinkedIn       
        Tumblr : 17,			//Tumblr         
        Mail : 18, 				//Mail          
        SMS : 19,				//SMS           
        Print : 20, 			//Print       
        Copy : 21,				//Copy             
        WeChat : 22,		    //WeChat Friends    
        WeChatMoments : 23,	    //WeChat Timeline   
        QQ : 24,				//QQ              
        Instapaper : 25,		//Instapaper       
        Pocket : 26,			//Pocket           
        YouDaoNote : 27, 		//You Dao Note
        Pinterest : 30, 		//Pinterest    
        Flickr : 34,			//Flickr          
        Dropbox : 35,			//Dropbox          
        VKontakte : 36,			//VKontakte       
        WeChatFavorites : 37,	//WeChat Favorited        
        YiXinSession : 38, 		//YiXin Session   
        YiXinTimeline : 39,		//YiXin Timeline   
        YiXinFav : 40,			//YiXin Favorited  
        MingDao : 41,          	//明道
        Line : 42,             	//Line
        WhatsApp : 43,         	//Whats App
        KakaoTalk : 44,         //KakaoTalk
        KakaoStory : 45,        //KakaoStory 
        FacebookMessenger : 46, //FacebookMessenger
        Bluetooth : 48,         //Bluetooth
        Alipay : 50,            //Alipay
        AliPaySocialTimeline:51,//AliPaySocial Timeline
        DingTalk:52,            //DingTalk
        YouTube:53,             //youtube
        MeiPai:54,              //美拍
        Cmcc : 55,              //中国移动
        Reddit : 56,			//Reddit
        ESurfing : 57,          //天翼
        Douyin : 58,            //抖音
        FacebookAccount : 58,   //FacebookAccount
        KakaoPlatform : 995,    //Kakao Series
        EvernotePlatform : 996, //Evernote Series
        WechatPlatform : 997,   //Wechat Series
        QQPlatform : 998,		//QQ Series
        Any : 999 				//Any Platform  
    };

    /**
     * 回复状态
     * @type {object}
     */
    this.ResponseState = {
        Begin : 0,              //开始
        Success: 1,             //成功
        Fail : 2,               //失败
        Cancel : 3             //取消
    };

    /**
     * 内容分享类型
     * @type {object}
     */
    this.ContentType = {
    	Auto : 0,
        Text : 1,
        Image : 2,
        WebPage : 4,
        Music : 5,
        Video : 6,
        App : 7,
        File : 8,
        Emoji : 9
    };

};
                                                         
var $sharesdk = new ShareSDK();
```

添加ShareSDK.js目的主要是提供平台号，回调状态等一些常量

<div id="b0"></div>

### **引入模块**

```js
var shareApi = api.require('ShareSDKPlus');
```


<div id="a1"></div>

### **authorize**

授权  
authorize({params}, callback(ret, err))

#### params
platform：

- 类型：数字
- 描述：授权平台号，是新浪微博授权还是微信授权或者其他平台授权，由此参数决定

#### callback(ret, err)

ret：

- 类型：JSON 对象
- 内部字段：

```js
{
    state: 1      //数字类型，1:成功 2:失败 3:取消
    data:{}		//json对象 授权后获取的用户信息
    error:{      // state = 2时
    	error_code:, 	//错误码
    	error_msg:   //错误信息
    }
}
```

#### 示例代码

```js
var shareApi = api.require('ShareSDKPlus');
shareApi.authorize({
	"platform": $sharesdk.PlatformID.SinaWeibo
},function(ret, err){
	var state = ret.state;
	switch(state)
	{
		case $sharesdk.ResponseState.Success://1
			api.toast({
				msg: "授权成功",
				location: 'middle'
			});
		break;
		case $sharesdk.ResponseState.Fail://2
			api.toast({
				msg: "授权失败",
				location: 'middle'
			});
		break;
		case $sharesdk.ResponseState.Cancel://3
			api.toast({
				msg: "取消授权",
				location: 'middle'
		});
		break;
       default:
	}     
});
```

#### 可用性

iOS系统，Android系统

可提供的1.0.0及更高版本


<div id="a2"></div>

### **cancelAuthorize**

取消授权  
cancelAuthorize({params}, callback(ret, err))

#### params
platform：

- 类型：数字
- 描述：授权平台号

#### callback(ret, err)

ret：

- 类型：JSON 对象
- 内部字段：

```js
{
    state: 1      //数字类型，1:成功 2:失败 3:取消
    error:{      // state = 2时
    	error_code:, 	//错误码
    	error_msg:   //错误信息
    }
}
```

#### 示例代码

```js
var shareApi = api.require('ShareSDKPlus');
shareApi.cancelAuthorize({
	"platform": $sharesdk.PlatformID.SinaWeibo
},function(ret, err){
	var state = ret.state;
	switch(state)
	{
		case $sharesdk.ResponseState.Success://1
			api.toast({
				msg: "成功",
				location: 'middle'
			});
		break;
		case $sharesdk.ResponseState.Fail://2
			api.toast({
				msg: "失败",
				location: 'middle'
			});
		break;
		case $sharesdk.ResponseState.Cancel://3
			api.toast({
				msg: "授权",
				location: 'middle'
		});
		break;
       default:
	}     
});
```

#### 可用性

iOS系统，Android系统

可提供的1.0.0及更高版本


<div id="a3"></div>

### **getUserInfo**

获取用户信息  
getUserInfo({params}, callback(ret, err))

#### params
platform：

- 类型：数字
- 描述：平台号，是获取新浪微博还是微信或者其他平台用户信息，由此参数决定

#### callback(ret, err)

ret：

- 类型：JSON 对象
- 内部字段：

```js
{
    state: 1      //数字类型，1:成功 2:失败 3:取消
    data:{}		//json对象 获取的用户信息
    error:{      // state = 2时
    	error_code:, 	//错误码
    	error_msg:   //错误信息
    }
}
```

#### 示例代码

```js
var shareApi = api.require('ShareSDKPlus');
shareApi.getUserInfo({
	"platform": $sharesdk.PlatformID.SinaWeibo
},function(ret, err){
	var state = ret.state;
	switch(state)
	{
		case $sharesdk.ResponseState.Success://1
			api.toast({
				msg: "成功",
				location: 'middle'
			});
		break;
		case $sharesdk.ResponseState.Fail://2
			api.toast({
				msg: "失败",
				location: 'middle'
			});
		break;
		case $sharesdk.ResponseState.Cancel://3
			api.toast({
				msg: "取消",
				location: 'middle'
		});
		break;
       default:
	}     
});
```

#### 可用性

iOS系统，Android系统

可提供的1.0.0及更高版本

<div id="a4"></div>

### **shareContent**

分享  
shareContent({params}, callback(ret, err))

#### params
platform：

- 类型：数字
- 描述：平台号，分享到指定平台

shareParams：

- 类型：json
- 描述：分享内容
	- text：文本 
	- imageUrl：图片地址
	- title：标题
	- type：分享类型：分享文本、分享图片、分享链接等等

#### callback(ret, err)

ret：

- 类型：JSON 对象
- 内部字段：

```js
{
    state: 1      //数字类型，1:成功 2:失败 3:取消
    data:{}		//
    error:{      // state = 2时
    	error_code:, 	//错误码
    	error_msg:   //错误信息
    }
}
```

#### 示例代码

```js
var shareApi = api.require('ShareSDKPlus');

var shareParams =
	{
		"text" : "测试的文字",
		"imageUrl" : "http://download.sdk.mob.com/206/4f8/dfc9ea27dd8bc4abfec865c38d/800_450_156.2.jpg",
		"title" : "测试的标题",
		"titleUrl" : "http://www.mob.com",
		"description" : "测试的描述",
		"site" : "ShareSDK",
		"siteUrl" : "http://www.mob.com",
		"type" : $sharesdk.ContentType.Auto//ios端
	};

shareApi.shareContent({
	"platform": $sharesdk.PlatformID.SinaWeibo,
    "shareType": $sharesdk.ContentType.Image,//安卓端
	"shareParams": shareParams
},function(ret, err){
	var state = ret.state;
	switch(state)
	{
		case $sharesdk.ResponseState.Success://1
			api.toast({
				msg: "分享成功",
				location: 'middle'
			});
		break;
		case $sharesdk.ResponseState.Fail://2
			api.toast({
				msg: "分享失败",
				location: 'middle'
			});
		break;
		case $sharesdk.ResponseState.Cancel://3
			api.toast({
				msg: "取消分享",
				location: 'middle'
		});
		break;
       default:
	}     
});
```

#### 可用性

iOS系统，Android系统

可提供的1.0.0及更高版本


<div id="a5"></div>
### **oneKeyShareContent**

一键分享/菜单分享
oneKeyShareContent({params}, callback(ret, err))

#### params
platforms：

- 类型：数组
- 描述：可分享的平台列表，为null为全平台

shareParams：

- 类型：json
- 描述：分享内容
	- text：文本 
	- imageUrl：图片地址
	- title：标题
	- type：分享类型：分享文本、分享图片、分享链接等等

#### callback(ret, err)

ret：

- 类型：JSON 对象
- 内部字段：

```js
{
    state: 1      //数字类型，1:成功 2:失败 3:取消
    data:{}		//
    error:{      // state = 2时
    	error_code:, 	//错误码
    	error_msg:   //错误信息
    }
}
```

#### 示例代码

```js
var shareApi = api.require('ShareSDKPlus');

var shareParams =
	{
		"text" : "测试的文字",
		"imageUrl" : "http://download.sdk.mob.com/206/4f8/dfc9ea27dd8bc4abfec865c38d/800_450_156.2.jpg",
		"title" : "测试的标题",
		"titleUrl" : "http://www.mob.com",
		"description" : "测试的描述",
		"site" : "ShareSDK",
		"siteUrl" : "http://www.mob.com",
		"type" : $sharesdk.ContentType.Auto
	};

var platforms =
	[
		$sharesdk.PlatformID.SinaWeibo,
		$sharesdk.PlatformID.WeChat
	];

shareApi.oneKeyShareContent({
	"platforms": platforms, //为null时，显示全部可分享的平台（排除当前环境不可分享平台）
	"shareParams": shareParams
},function(ret, err){
	var state = ret.state;
	switch(state)
	{
		case $sharesdk.ResponseState.Success://1
			api.toast({
				msg: "分享成功",
				location: 'middle'
			});
		break;
		case $sharesdk.ResponseState.Fail://2
			api.toast({
				msg: "分享失败",
				location: 'middle'
			});
		break;
		case $sharesdk.ResponseState.Cancel://3
			api.toast({
				msg: "取消分享",
				location: 'middle'
		});
		break;
       default:
	}     
});
```

#### 可用性

iOS系统，Android系统

可提供的1.0.0及更高版本



## 如何扩充平台

当前ShareSDKPlus只支持微信、QQ、新浪微博、facebook、twitter五个平台，如果想要支持其他平台应如何操作

### iOS方案
[点击此处](https://github.com/MobClub/APICloud-For-ShareSDK/blob/master/info_ios.md#a)

https://github.com/MobClub/APICloud-For-ShareSDK/blob/master/info_android.md)




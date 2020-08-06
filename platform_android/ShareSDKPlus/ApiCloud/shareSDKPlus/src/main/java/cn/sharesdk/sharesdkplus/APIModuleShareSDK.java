package cn.sharesdk.sharesdkplus;

import android.app.Activity;
import android.text.TextUtils;
import android.util.Log;

import com.mob.MobSDK;
import com.uzmap.pkg.uzcore.UZWebView;
import com.uzmap.pkg.uzcore.uzmodule.UZModule;
import com.uzmap.pkg.uzcore.uzmodule.UZModuleContext;

import org.json.JSONException;
import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import cn.sharesdk.framework.Platform;
import cn.sharesdk.framework.PlatformActionListener;
import cn.sharesdk.framework.ShareSDK;
import cn.sharesdk.onekeyshare.BuildConfig;
import cn.sharesdk.onekeyshare.OnekeyShare;
import cn.sharesdk.sina.weibo.SinaWeibo;
import cn.sharesdk.tencent.qq.QQ;
import cn.sharesdk.tencent.qzone.QZone;
import cn.sharesdk.wechat.favorite.WechatFavorite;
import cn.sharesdk.wechat.friends.Wechat;
import cn.sharesdk.wechat.moments.WechatMoments;

/**
 * Created by xiangli on 2019/4/15.
 */

public class APIModuleShareSDK extends UZModule {

    public APIModuleShareSDK(UZWebView webView) {
        super(webView);
        setMobAppKeyAndSecret();
        initDevice();

    }

    private void checkParam(String mapKey, String featureKey, HashMap<String, Object> platMap) {
        if (getFeature(featureKey) != null && !TextUtils.isEmpty(getFeature(featureKey))) {
            platMap.put(mapKey, getFeature(featureKey));
        }
    }

    private String getFeature(String key) {
        String value = getFeatureValue("shareSDKPlus", key);
        return value;
    }

//    private void initAppKey(String platNumber) {
//
//        setMobAppKeyAndSecret();
//        int casedId = Integer.parseInt(platNumber);
//        switch (casedId) {
//            case 0: {
//                deviceSina();
//                devicesTencentWeibo();
//                devicesDouBan();
//                devicesQQ();
//                devicesRenren();
//                devicesKaixin();
//                devicesFacebook();
//                devicesTwitter();
//                devicesYinXiang();
//                devicesFourSquare();
//                devicesGoogle();
//                devicesInstagram();
//                devicesLinkedIn();
//                devicesTumblr();
//                devicesWeChat();
//                devicesInstapaper();
//                devicesPocket();
//                devicesYouDao();
//                devicesPinterest();
//                devicesFlickr();
//                devicesDropbox();
//                devicesVKontakte();
//                devicesYinXin();
//                devicesMingdao();
//                devicesLine();
//                devicesKakaoTalk();
//                devicesKakaoStory();
//                devicesFacebookMessage();
//                devicesAlipay();
//                devicesDingTalk();
//                devicesYoutube();
//                devicesMeipai();
//                devicesCmcc();
//                devicesReddit();
//                devicesTelecom();
//                devicesDouyin();
//                devicesAccountKit();
//            }
//            break;
//            case 1: {
//                deviceSina();
//            }
//            break;
//            case 2: {
//                devicesTencentWeibo();
//            }
//            break;
//            case 5: {
//                devicesDouBan();
//            }
//            break;
//            case 6: { //Qzone 与qq是一样的
//                devicesQQ();
//            }
//            break;
//            case 7: {
//                devicesRenren();
//            }
//            break;
//            case 8: {
//                devicesKaixin();
//            }
//            break;
//            case 10: {
//                devicesFacebook();
//            }
//            break;
//            case 11: {
//                devicesTwitter();
//            }
//            break;
//            case 12: { //Evernote
//                devicesYinXiang();
//            }
//            break;
//            case 13: {
//                devicesFourSquare();
//            }
//            break;
//            case 14: {
//                devicesGoogle();
//            }
//            break;
//            case 15: {
//                devicesInstagram();
//            }
//            break;
//            case 16: {
//                devicesLinkedIn();
//            }
//            break;
//            case 17: {
//                devicesTumblr();
//            }
//            break;
//            case 22: {
//                devicesWeChat();
//            }
//            break;
//            case 23: {
//                devicesWeChat();
//            }
//            break;
//            case 24: {
//                devicesQQ();
//            }
//            break;
//            case 25: {
//                devicesInstapaper();
//            }
//            break;
//            case 26: {
//                devicesPocket();
//            }
//            break;
//            case 27: {
//                devicesYouDao();
//            }
//            break;
//            case 30: {
//                devicesPinterest();
//            }
//            break;
//            case 34: {
//                devicesFlickr();
//            }
//            break;
//            case 35: {
//                devicesDropbox();
//            }
//            break;
//            case 36: {
//                devicesVKontakte();
//            }
//            break;
//            case 37: {
//                devicesWeChat();
//            }
//            break;
//            case 38: {
//                devicesYinXin();
//            }
//            break;
//            case 39: {
//                devicesYinXin();
//            }
//            break;
//            case 41: {
//                devicesMingdao();
//            }
//            break;
//            case 42: {
//                devicesLine();
//            }
//            break;
//            case 44: {
//                devicesKakaoTalk();
//            }
//            break;
//            case 45: {
//                devicesKakaoStory();
//            }
//            break;
//            case 46: {
//                devicesFacebookMessage();
//            }
//            break;
//            case 50: {
//                devicesAlipay();
//            }
//            break;
//            case 51: {
//                devicesAlipay();
//            }
//            break;
//            case 52: {
//                devicesDingTalk();
//            }
//            break;
//            case 53: {
//                devicesYoutube();
//            }
//            break;
//            case 54: {
//                devicesMeipai();
//            }
//            break;
//            case 55: {
//                devicesCmcc();
//            }
//            break;
//            case 56: {
//                devicesReddit();
//            }
//            break;
//            case 57: {
//                devicesTelecom();
//            }
//            break;
//            case 58: {
//                devicesDouyin();
//            }
//            break;
//            case 59: {
//                devicesAccountKit();
//            }
//            break;
//            default:
//                break;
//        }
//    }

    //set MobAppKey and MobAppSecret
    private void setMobAppKeyAndSecret() {
        String mobAppkey = getFeature("MOBAppKey");
        String mobAppSecret = getFeature("MOBAppSecret");
        if ((!TextUtils.isEmpty(mobAppkey)) && (!TextUtils.isEmpty(mobAppSecret))) {
            MobSDK.init(context(), mobAppkey, mobAppSecret);
            Log.e("WWW", "MobSDK.init is ok ===> mobAppkey " + mobAppkey + " mobAppSecret " + mobAppSecret);
        } else {
            Log.e("WWW", "MobSdk mobAppkey or mobAppSecret is null");
        }


    }

    //新浪
    private void deviceSina() {
        HashMap<String, Object> sinaMap = new HashMap<String, Object>();
        checkParam("AppKey", "SinaWei_AppKey", sinaMap);
        checkParam("AppSecret", "SinaWei_AppSecret", sinaMap);
        checkParam("RedirectUrl", "SinaWei_RedirectUri", sinaMap);

        sinaMap.put("ShareByAppClient", "true");
        sinaMap.put("Enable", "true");
        //ShareSDK.setPlatformDevInfo(SinaWeibo.NAME, sinaMap);
        ShareSDK.setPlatformDevInfo(SinaWeibo.NAME, sinaMap);

    }

    //QQ
    private void devicesQQ() {
        HashMap<String, Object> qqMap = new HashMap<String, Object>();
        checkParam("AppId", "QQ_AppKey", qqMap);
        checkParam("AppKey", "QQ_AppSecret", qqMap);
        qqMap.put("BypassApproval", "false");
        qqMap.put("ShareByAppClient", "true");
        qqMap.put("Enable", "true");
        //ShareSDK.setPlatformDevInfo(QQ.NAME, qqMap);
        ShareSDK.setPlatformDevInfo(QQ.NAME, qqMap);
        ShareSDK.setPlatformDevInfo(QZone.NAME, qqMap);
    }

    //微信
    private void devicesWeChat() {
        HashMap<String, Object> wechatMap = new HashMap<String, Object>();
        checkParam("AppId", "Wechat_AppKey", wechatMap);
        checkParam("AppSecret", "Wechat_AppSecret", wechatMap);
        wechatMap.put("BypassApproval", "false");
        wechatMap.put("Enable", "true");
        //ShareSDK.setPlatformDevInfo(Wechat.NAME, wechatMap);
        ShareSDK.setPlatformDevInfo(Wechat.NAME, wechatMap);
        ShareSDK.setPlatformDevInfo(WechatMoments.NAME, wechatMap);
        ShareSDK.setPlatformDevInfo(WechatFavorite.NAME, wechatMap);
    }


    private void initDevice() {
        deviceSina();
        devicesQQ();
        devicesWeChat();
//        devicesGoogle();
//        devicesDouyin();

    }

    private void resultJsonSuccess(String key, int value, final UZModuleContext moduleContext) {
        JSONObject ret = new JSONObject();
        try {
            ret.put(key, value);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        if (moduleContext != null) {
            moduleContext.success(ret, true);
        }
    }

    private void resultJsonError(String key, int value, final UZModuleContext moduleContext) {
        JSONObject ret = new JSONObject();
        try {
            ret.put(key, value);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        if (moduleContext != null) {
            moduleContext.error(ret, ret, true);
        }
    }

    private Object getParams(JSONObject jsonObject, String key) {
        Object value = null;
        if (jsonObject.optString(key).equals("")) {
            return null;
        } else {
            try {
                value = jsonObject.get(key);
//                value = jsonObject.getString(key);
            } catch (JSONException e) {
                e.printStackTrace();
            }
            return value;
        }
    }

    //    授权
    public void jsmethod_authorize(final UZModuleContext moduleContext) {
        int platformStr = moduleContext.optInt("platform");
        if (BuildConfig.DEBUG) Log.d("APIModuleShareSDK", "platformStr:" + platformStr);
        Platform platform = ShareSDK.getPlatform(ShareSDK.platformIdToName(platformStr));

//        platform.SSOSetting(false);  //设置false表示使用SSO授权方式
//        platform.setPlatformActionListener(platformActionListener);
        platform.setPlatformActionListener(new PlatformActionListener() {
            //            arg1 = 8 有用户信息登录 ； arg1 = 9 分享 ; arg1 = 1 无用户信息登录
            //失败的回调，arg:平台对象，arg1:表示当前的动作，arg2:异常信息
            @Override
            public void onComplete(Platform platform, int action, HashMap<String, Object> res) {
                //TODO TEST

                Log.e("QQQ", " 授权成功 " + action + "   " + res);
                resultJsonSuccess("state", 1, moduleContext);
            }

            @Override
            public void onError(Platform platform, int action, Throwable t) {
                //resultJsonError("state", 2, moduleContext);
                JSONObject ret = new JSONObject();
                try {
                    ret.put("state", 2);
                    ret.put("data", t);
                    Log.e("QQQ", " =========> onError  " + t);
                } catch (JSONException e) {
                    Log.e("QQQ", " =========> onError===> put error  " + e.getMessage());
                }
                moduleContext.success(ret, true);
            }

            @Override
            public void onCancel(Platform platform, int action) {
                Log.e("QQQ", " 授权取消 ");
                resultJsonError("state", 3, moduleContext);
            }
        });
        platform.authorize();
    }

    //    取消授权
    public void jsmethod_cancelAuthorize(final UZModuleContext moduleContext) {
        int platformStr = moduleContext.optInt("platform");
        if (BuildConfig.DEBUG) Log.d("APIModuleShareSDK", "platformStr:" + platformStr);
        Platform platform = ShareSDK.getPlatform(ShareSDK.platformIdToName(platformStr));
        if (platform.isAuthValid()) {
            platform.removeAccount(true);
            resultJsonSuccess("state", 1, moduleContext);
        } else {
            resultJsonSuccess("state", 2, moduleContext);
        }
    }

    //    获取用户信息
    public void jsmethod_getUserInfo(final UZModuleContext moduleContext) {
        int platformStr = moduleContext.optInt("platform");
        if (BuildConfig.DEBUG) Log.d("APIModuleShareSDK", "platformStr:" + platformStr);
        Platform platform = ShareSDK.getPlatform(ShareSDK.platformIdToName(platformStr));
        ShareSDK.setActivity((Activity) moduleContext.getContext());//抖音登录适配安卓9.0

        platform.showUser(null);
        platform.setPlatformActionListener(new PlatformActionListener() {
            @Override
            public void onComplete(Platform platform, int i, HashMap<String, Object> hashMap) {
                JSONObject ret = new JSONObject();
                try {
                    ret.put("state", 1);
                    ret.put("data", platform.getDb().exportData());
                    Log.e("QQQ", " =========> onComplete  " + platform.getDb().exportData());
                } catch (JSONException e) {
                    Log.e("QQQ", " =========> onComplete put error  " + e.getMessage());
                }
                moduleContext.success(ret, true);
            }

            @Override
            public void onError(Platform platform, int i, Throwable throwable) {
                Log.e("QQQ", " =========> onError  " + throwable);
                JSONObject ret = new JSONObject();
                try {
                    ret.put("state", 2);
                    ret.put("data", throwable);
                } catch (JSONException t) {
                    t.printStackTrace();
                }
                moduleContext.success(ret, true);
                //resultJsonError("state", 2, moduleContext);

            }

            @Override
            public void onCancel(Platform platform, int i) {
                Log.e("QQQ", " =========> onCancel  ");
                resultJsonError("state", 3, moduleContext);
            }
        });
    }

    public void jsmethod_shareContent(final UZModuleContext moduleContext) {
        int platformStr = moduleContext.optInt("platform");
        if (BuildConfig.DEBUG) Log.d("APIModuleShareSDK", "platformStr:" + platformStr);
        Platform platform = ShareSDK.getPlatform(ShareSDK.platformIdToName(platformStr));

        JSONObject jsonObject = (JSONObject) moduleContext.opt("shareParams");
        String title = (String) getParams(jsonObject, "title");
        String text = (String) getParams(jsonObject, "text");
        String imageUrl = (String) getParams(jsonObject, "imageUrl");
        String titleUrl = (String) getParams(jsonObject, "titleUrl");
        String musicUrl = (String) getParams(jsonObject, "musicUrl");
        String videoUrl = (String) getParams(jsonObject, "videoUrl");
        String description = (String) getParams(jsonObject, "description");
        String site = (String) getParams(jsonObject, "site");
        String siteUrl = (String) getParams(jsonObject, "siteUrl");
        String Url = (String) getParams(jsonObject, "Url");
        int type = (int) getParams(jsonObject, "type");

        //linkcard
        String sina_linkCard = String.valueOf(getParams(jsonObject, "sina_linkCard"));
        String sina_cardTitle = (String) getParams(jsonObject, "sina_cardTitle");
        String sina_cardSummary = (String) getParams(jsonObject, "sina_cardSummary");

        if (sina_linkCard.equals("1")) {
            JSONObject jsonImage = new JSONObject();
            try {
                jsonImage.put("url", imageUrl);
                jsonImage.put("width", 120);
                jsonImage.put("height", 120);
            } catch (JSONException e) {
                e.printStackTrace();
            }

            /*JSONObject jsonObjectImage = new JSONObject();
            try {
                jsonObjectImage.put("url", "http://wx4.sinaimg.cn/large/006WfoFPly1fq0jo9svnaj30dw0dwdhv.jpg");
                jsonObjectImage.put("width", 120);
                jsonObjectImage.put("height", 120);
            } catch (JSONException e) {
                e.printStackTrace();
            }*/

            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date(System.currentTimeMillis());
            String dateStr = String.valueOf(date);

            //Platform platform = ShareSDK.getPlatform(SinaWeibo.NAME);
            Platform.ShareParams sp = new Platform.ShareParams();
            sp.setText(text);
            sp.setLcCreateAt("2019-01-24");
            sp.setLcDisplayName(sina_cardTitle);
            sp.setLcImage(jsonImage);
            sp.setLcSummary(sina_cardSummary);
            sp.setLcUrl(Url);
            sp.setLcObjectType("webpage");
            //platform.setPlatformActionListener(this);
            platform.share(sp);

        } else {
            //Platform platform = ShareSDK.getPlatform(SinaWeibo.NAME);
            Platform.ShareParams sp = new Platform.ShareParams();
            if (type == Platform.SHARE_WEBPAGE) {//分享链接
                sp.setText(text);
                sp.setTitle(title);
                sp.setImageUrl(imageUrl);
                sp.setUrl(titleUrl);
                sp.setTitleUrl(titleUrl);
            } else if (type == Platform.SHARE_MUSIC) {//分享音乐
                sp.setText(text);
                sp.setTitle(title);
                sp.setImageUrl(imageUrl);
                sp.setUrl(titleUrl);
                sp.setTitleUrl(titleUrl);
                sp.setMusicUrl(musicUrl);
            } else if (type == Platform.SHARE_IMAGE) {//分享图片
                sp.setImageUrl(imageUrl);
                sp.setText(text);//微博可以分享图片的时候加上文字
            } else if (type == Platform.SHARE_TEXT) {//分享文字
                sp.setText(text);
                sp.setTitle(title);
//                sp.setSite(title);//QQ空间可以添加Site
//                sp.setSiteUrl(titleUrl);//QQ空间可以添加SiteUrl
//                sp.setTitleUrl(titleUrl);//QQ空间可以添加SiteUrl
//                sp.setImageUrl(imageUrl);//QQ空间可以添加图片
                sp.setComment(titleUrl);
            } else if (type == Platform.SHARE_VIDEO) {//分享视频
                sp.setText(text);
                sp.setTitle(title);
                sp.setUrl(videoUrl);
                sp.setImageUrl(imageUrl);
            }
//            sp.setSite(site);
//            sp.setSiteUrl(siteUrl);
            sp.setShareType(type);
            platform.setPlatformActionListener(new PlatformActionListener() {
                @Override
                public void onComplete(Platform platform, int i, HashMap<String, Object> hashMap) {
                    resultJsonSuccess("state", 1, moduleContext);
                }

                @Override
                public void onError(Platform platform, int i, Throwable throwable) {
                    resultJsonError("state", 2, moduleContext);
                }

                @Override
                public void onCancel(Platform platform, int i) {
                    resultJsonError("state", 3, moduleContext);
                }
            });
            platform.share(sp);
        }
    }

    public void jsmethod_oneKeyShareContent(final UZModuleContext moduleContext) {
        JSONObject json = (JSONObject) moduleContext.opt("shareParams");
        String text = (String) getParams(json, "text");
        String imageUrl = (String) getParams(json, "imageUrl");
        String title = (String) getParams(json, "title");
        String titleUrl = (String) getParams(json, "titleUrl");
        String description = (String) getParams(json, "description");
        String site = (String) getParams(json, "site");
        String siteUrl = (String) getParams(json, "siteUrl");
        int type = (int) getParams(json, "type");

        OnekeyShare oks = new OnekeyShare();
        oks.setText(text);
        oks.setImageUrl(imageUrl);
        oks.setTitle(title);
        oks.setTitleUrl(titleUrl);
        oks.setSite(site);
        oks.setSiteUrl(siteUrl);
        oks.setCallback(new PlatformActionListener() {
            @Override
            public void onComplete(Platform platform, int i, HashMap<String, Object> hashMap) {
                Log.e("QQQ", " onekeyshare onComplete" + hashMap);
                //resultJsonSuccess("state", 1, moduleContext);
                JSONObject ret = new JSONObject();
                try {
                    ret.put("state", 1);
                    ret.put("data", hashMap.toString());
                    Log.e("QQQ", " =========> onComplete  " + hashMap.toString());
                } catch (JSONException e) {
                    Log.e("QQQ", " =========> onComplete put error  " + e.getMessage());
                }
                moduleContext.success(ret, true);
            }

            @Override
            public void onError(Platform platform, int i, Throwable throwable) {
                Log.e("QQQ", " onekeyshare onError" + throwable);
                //resultJsonError("state", 2, moduleContext);
                JSONObject ret = new JSONObject();
                try {
                    ret.put("state", 2);
                    ret.put("data", throwable);
                    Log.e("QQQ", " =========> onComplete  " + platform.getDb().exportData());
                } catch (JSONException e) {
                    Log.e("QQQ", " =========> onComplete put error  " + e.getMessage());
                }
                moduleContext.success(ret, true);
            }

            @Override
            public void onCancel(Platform platform, int i) {
                Log.e("QQQ", " onekeyshare " + " onCancel ");
                resultJsonError("state", 3, moduleContext);
            }
        });
        oks.show(context());
    }


    //=================== 非必须平台 ===================

//    //抖音
//    private void devicesDouyin() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppKey", "Douyin_AppKey", map);
//        checkParam("AppSecret", "Douyin_AppSecret", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("58"), map);
//    }
//
//    //facebook
//    private void devicesFacebook() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("ConsumerKey", "Facebook_AppKey", map);
//        checkParam("ConsumerSecret", "Facebook_AppSecret", map);
//        checkParam("RedirectUrl", "Facebook_RedirectUrl", map);
//        map.put("ShareByAppClient", "true");
//        map.put("Enable", "true");
////        ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("10"), map);
//    }
//
//    //facebookMessage
//    private void devicesFacebookMessage() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppId", "FacebookMessage_AppKey", map);
//        map.put("Enable", "true");
////        ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("46"), map);
//    }
//
//    //Twitter
//    private void devicesTwitter() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("ConsumerKey", "Twitter_AppKey", map);
//        checkParam("ConsumerSecret", "Twitter_AppSecret", map);
//        checkParam("CallbackUrl", "Twitter_RedirectUri", map);
//        map.put("Enable", "true");
////        ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("11"), map);
//
//    }
//
//    //Instagram
//    private void devicesInstagram() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("ClientId", "Instagram_AppKey", map);
//        checkParam("ClientSecret", "Instagram_AppSecret", map);
//        checkParam("RedirectUri", "Instagram_RedirectUri", map);
//        map.put("Enable", "true");
////        ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("15"), map);
//    }
//
//    //Google
//    private void devicesGoogle() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("ClientID", "Google_AppKey", map);
//        checkParam("RedirectUrl", "Google_RedirectUri", map);
//        map.put("ShareByAppClient", "true");
//        map.put("Enable", "true");
////        ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("14"), map);
//    }
//
//    //Line
//    private void devicesLine() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("ChannelID", "Line_AppKey", map);
//        checkParam("ChannelSecret", "Line_AppSecret", map);
//        checkParam("RedirectUri", "Line_RedirectUri", map);
//        map.put("Enable", "true");
////        ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("42"), map);
//    }
//
//    //Alipay
//    private void devicesAlipay() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("appId", "AliPaySocial_AppKey", map);
//        map.put("enable", true);
////        ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("50"), map);
//    }
//
//    //Alipay
//    private void devicesMeipai() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("ClientID", "MeiPai_AppKey", map);
//        checkParam("AppSecret", "MeiPai_AppSecret", map);
//        map.put("ShareByAppClient", "true");
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("54"), map);
//    }
//
//    //DingTalk
//    private void devicesDingTalk() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppId", "DingTalk_AppKey", map);
//        map.put("ShareByAppClient", "true");
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("52"), map);
//    }
//
//    //DouBan
//    private void devicesDouBan() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("ApiKey", "DouBan_AppKey", map);
//        checkParam("Secret", "DouBan_AppSecret", map);
//        checkParam("RedirectUri", "DouBan_RedirectUri", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("5"), map);
//    }
//
//    //TencentWeibo
//    private void devicesTencentWeibo() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppKey", "TencentWeibo_AppKey", map);
//        checkParam("AppSecret", "TencentWeibo_AppSecret", map);
//        checkParam("RedirectUri", "TencentWeibo_RedirectUri", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("2"), map);
//    }
//
//    //YinXiang Evernote
//    private void devicesYinXiang() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("ConsumerKey", "YinXiang_AppKey", map);
//        checkParam("ConsumerSecret", "YinXiang_AppSecret", map);
//        checkParam("HostType", "YinXiang_HostType", map);
//        map.put("ShareByAppClient", "true");
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("12"), map);
//    }
//
//    //YouDao
//    private void devicesYouDao() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("ConsumerKey", "YouDaoNote_AppKey", map);
//        checkParam("ConsumerSecret", "YouDaoNote_AppSecret", map);
//        checkParam("RedirectUri", "YouDaoNote_RedirectUri", map);
//        checkParam("HostType", "YouDaoNote_HostType", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("27"), map);
//    }
//
//    //MingDao
//    private void devicesMingdao() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppKey", "Mingdao_AppKey", map);
//        checkParam("AppSecret", "Mingdao_AppSecret", map);
//        checkParam("RedirectUri", "Mingdao_RedirectUri", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("41"), map);
//    }
//
//    //Kaixin
//    private void devicesKaixin() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppKey", "Kaixin_AppKey", map);
//        checkParam("AppSecret", "Kaixin_AppSecret", map);
//        checkParam("RedirectUri", "Kaixin_RedirectUri", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("8"), map);
//    }
//
//    //Renren
//    private void devicesRenren() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppId", "Renren_AppId", map);
//        checkParam("ApiKey", "Renren_AppKey", map);
//        checkParam("SecretKey", "Renren_AppSecret", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("7"), map);
//    }
//
//    //Yinxin
//    private void devicesYinXin() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppId", "YiXin_AppKey", map);
//        map.put("BypassApproval", "true");
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("38"), map);
//    }
//
//    //KakaoTalk
//    private void devicesKakaoTalk() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppKey", "Kakao_AppKey", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("44"), map);
//    }
//
//    //KakaoStory
//    private void devicesKakaoStory() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppKey", "Kakao_AppKey", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("45"), map);
//    }
//
//    //Youtube
//    private void devicesYoutube() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("ClientID", "YouTube_AppKey", map);
//        checkParam("AppSecret", "YouTube_AppSecret", map);
//        checkParam("RedirectUrl", "YouTube_RedirectUri", map);
//        map.put("ShareByAppClient", "true");
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("53"), map);
//    }
//
//    //Flickr
//    private void devicesFlickr() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("ApiKey", "Flickr_ApiKey", map);
//        checkParam("ApiSecret", "Flickr_ApiSecrett", map);
//        checkParam("RedirectUri", "Flickr_RedirectUri", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("34"), map);
//    }
//
//    //FourSquare
//    private void devicesFourSquare() {
//        HashMap<String, Object> map = new HashMap<>();
//        checkParam("ClientID", "FourSquare_ApiKey", map);
//        checkParam("ClientSecret", "FourSquare_ApiSecrett", map);
//        checkParam("RedirectUrl", "FourSquare_RedirectUri", map);
//        map.put("Enable", "true");
//        ShareSDK.setPlatformDevInfo(switchPlatform("13"), map);
//    }
//
//    //Dropbox
//    private void devicesDropbox() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppKey", "Dropbox_AppKey", map);
//        checkParam("AppSecret", "Dropbox_AppSecret", map);
//        checkParam("RedirectUri", "Dropbox_RedirectUri", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("35"), map);
//    }
//
//    //Pinterest
//    private void devicesPinterest() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("ClientId", "Pinterest_AppKey", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("30"), map);
//    }
//
//    //Pocket
//    private void devicesPocket() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("ConsumerKey", "Pinterest_AppKey", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("26"), map);
//    }
//
//    //Linked
//    private void devicesLinkedIn() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("ApiKey", "LinkedIn_AppKey", map);
//        checkParam("SecretKey", "LinkedIn_AppSecret", map);
//        checkParam("RedirectUrl", "LinkedIn_RedirectUri", map);
//        map.put("ShareByAppClient", "true");
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("16"), map);
//    }
//
//    //VKontakte
//    private void devicesVKontakte() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("ApplicationId", "VKontakte_AppKey", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("36"), map);
//    }
//
//    //Instapaper
//    private void devicesInstapaper() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("ConsumerKey", "Instapaper_AppKey", map);
//        checkParam("ConsumerSecret", "Instapaper_AppSecret", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("25"), map);
//    }
//
//    //Tumblr
//    private void devicesTumblr() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("OAuthConsumerKey", "Tumblr_AppKey", map);
//        checkParam("SecretKey", "Tumblr_AppSecret", map);
//        checkParam("CallbackUrl", "Tumblr_RedirectUri", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("17"), map);
//    }
//
//    //Cmcc
//    private void devicesCmcc() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppId", "CMCC_AppId", map);
//        checkParam("AppKey", "CMCC_AppKey", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("55"), map);
//    }
//
//    //Reddit
//    private void devicesReddit() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppKey", "Reddit_AppKey", map);
//        checkParam("RedirectUrl", "Reddit_RedirectUri", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("56"), map);
//    }
//
//    //AccountKit
//    private void devicesAccountKit() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppKey", "Accountkit_AppKey", map);
//        checkParam("AppSecret", "Accountkit_AppSecret", map);
//        checkParam("RedirectUrl", "Accountkit_RedirectUri", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("59"), map);
//    }
//
//    //Telegram
//    private void devicesTelegram() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppKey", "Telegram_BotToken", map);
//        checkParam("RedirectUrl", "Telegram_BotDomain", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("55"), map);
//    }
//
//    //Telecom / ESurfing
//    private void devicesTelecom() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppKey", "ESurfing_AppKey", map);
//        checkParam("AppSecret", "ESurfing_AppSecret", map);
//        checkParam("RedirectUrl", "ESurfing_RedirectUrl", map);
//        map.put("Enable", "true");
//        //ShareSDK.setPlatformDevInfo(Wechat.NAME, map);
//        ShareSDK.setPlatformDevInfo(switchPlatform("57"), map);
//    }

//    PlatformActionListener platformActionListener = new PlatformActionListener() {
//        public void onError(final Platform arg0, final int arg1, final Throwable arg2) {
////            arg1 = 8 有用户信息登录 ； arg1 = 9 分享 ; arg1 = 1 无用户信息登录
//            //失败的回调，arg:平台对象，arg1:表示当前的动作，arg2:异常信息
//            Log.d("ShareSdkActivity", arg0.getName() + "  " + arg1 + "失败 " + arg2.getMessage());
//            runOnUiThread(new Runnable() {
//                @Override
//                public void run() {
////                    Toast.makeText(ShareSdkActivity.this, arg0.getName() + "  " + arg1 + "失败 " + arg2.getMessage(), Toast.LENGTH_SHORT).show();
//                }
//            });
//
//        }
//
//        public void onComplete(final Platform arg0, final int arg1, final HashMap arg2) {
//            resultJsonSuccess("state", 1, moduleContext);
//            //分享成功的回调
//            runOnUiThread(new Runnable() {
//                @Override
//                public void run() {
////                    Toast.makeText(ShareSdkActivity.this, arg0.getDb().getUserId() + "  " + arg1 + "成功 " + (arg2 == null ? "" : arg2.toString()), Toast.LENGTH_SHORT).show();
//                    Log.d("mobDemo", arg0.toString() + "  " + arg1 + "成功 " + (arg2 == null ? "" : arg2.toString()));
//                }
//            });
//        }
//
//        public void onCancel(final Platform arg0, final int arg1) {
//            //取消分享的回调
//
//            runOnUiThread(new Runnable() {
//                @Override
//                public void run() {
////                    Toast.makeText(ShareSdkActivity.this, arg0.getName() + "  " + arg1 + "取消", Toast.LENGTH_SHORT).show();
//
//                }
//            });
//
//        }
//    };
}

package cn.sharesdk.sharesdkplus;

import android.app.Activity;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Handler;
import android.text.TextUtils;
import android.util.Log;
import android.widget.Toast;

import com.mob.MobSDK;
import com.mob.tools.utils.BitmapHelper;
import com.uzmap.pkg.uzcore.UZWebView;
import com.uzmap.pkg.uzcore.uzmodule.UZModule;
import com.uzmap.pkg.uzcore.uzmodule.UZModuleContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import cn.sharesdk.BuildConfig;
import cn.sharesdk.alipay.friends.Alipay;
import cn.sharesdk.alipay.moments.AlipayMoments;
import cn.sharesdk.dingding.friends.Dingding;
import cn.sharesdk.facebook.Facebook;
import cn.sharesdk.framework.Platform;
import cn.sharesdk.framework.PlatformActionListener;
import cn.sharesdk.framework.ShareSDK;
import cn.sharesdk.google.GooglePlus;
import cn.sharesdk.instagram.Instagram;
import cn.sharesdk.kakao.story.KakaoStory;
import cn.sharesdk.kakao.talk.KakaoTalk;
import cn.sharesdk.line.Line;
import cn.sharesdk.onekeyshare.OnekeyShare;
import cn.sharesdk.sina.weibo.SinaWeibo;
import cn.sharesdk.telegram.Telegram;
import cn.sharesdk.tencent.qq.QQ;
import cn.sharesdk.tencent.qzone.QZone;
import cn.sharesdk.twitter.Twitter;
import cn.sharesdk.wechat.favorite.WechatFavorite;
import cn.sharesdk.wechat.friends.Wechat;
import cn.sharesdk.wechat.moments.WechatMoments;

public class APIModuleShareSDK extends UZModule {
    private UZModuleContext moduleContext;
    private PlatformActionListener platformActionListener = new PlatformActionListener() {
        //arg1 = 8 有用户信息登录 ； arg1 = 9 分享 ; arg1 = 1 无用户信息登录
        //失败的回调，arg:平台对象，arg1:表示当前的动作，arg2:异常信息
        @Override
        public void onComplete(Platform platform, int action, HashMap<String, Object> res) {
            JSONObject ret = new JSONObject();
            try {
                JSONObject data = new JSONObject();
                data.put("platform", platform);
                data.put("action", action);
                data.put("res", res);
                ret.put("data", data);
            } catch (JSONException e) {
                e.printStackTrace();
            }
            Log.d("QQQ", " 授权成功" + action + "   " + res);
            resultJsonSuccess(ret);
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
            resultJsonError(ret);
        }

        @Override
        public void onCancel(Platform platform, int action) {
            Log.e("QQQ", " 授权取消 ");
            resultJsonCancel();
        }
    };

    public APIModuleShareSDK(UZWebView webView) {
        super(webView);
    }

    public void jsmethod_init(final UZModuleContext moduleContext) {
        this.moduleContext = moduleContext;
        MobSdkInitTask mobSdkInitTask = new MobSdkInitTask();
        mobSdkInitTask.execute();
    }


    //set MobAppKey and MobAppSecret
    private void setMobAppKeyAndSecret() {
        String mobAppkey = getFeature("Mob-AppKey");
        String mobAppSecret = getFeature("Mob-AppSecret");
        if ((!TextUtils.isEmpty(mobAppkey)) && (!TextUtils.isEmpty(mobAppSecret))) {
            MobSDK.init(context(), mobAppkey, mobAppSecret);
            Log.e("WWW", "MobSDK.init is ok ===> mobAppkey " + mobAppkey + " mobAppSecret " + mobAppSecret);
        } else {
            Log.e("WWW", "MobSdk mobAppkey or mobAppSecret is null");
        }
    }

    private class MobSdkInitTask extends AsyncTask<Void, Void, Void> {
        @Override
        protected void onPreExecute() {
            setMobAppKeyAndSecret();
        }

        @Override
        protected Void doInBackground(Void... params) {
            // 自定义的线程任务
            deviceSina();
            deviceAlipay();
            devicesQQ();
            devicesWeChat();
            devicesGoogle();
            deviceDingding();
            devicesLine();
            devicesTwitter();
            devicesFacebook();
            devicesInstagram();
            devicesTelegram();
            devicesKakao();
            return null;
        }

        @Override
        protected void onPostExecute(Void result) {
            // UI操作
            JSONObject ret = new JSONObject();
            try {
                JSONObject data = new JSONObject();
                ret.put("data", data);
            } catch (JSONException e) {
                e.printStackTrace();
            }
            resultJsonSuccess(ret);
        }
    }

    private void resultJsonSuccess(JSONObject ret) {
        try {
            if (ret == null) {
                ret = new JSONObject();
            }
            ret.put("state", 1);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        if (moduleContext != null) {
            moduleContext.success(ret, true);
        }
    }

    private void resultJsonError(JSONObject ret) {
        try {
            ret.put("state", 2);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        if (moduleContext != null) {
            moduleContext.success(ret, true);
        }
    }

    private void resultJsonCancel() {
        JSONObject ret = new JSONObject();
        try {
            ret.put("state", 3);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        if (moduleContext != null) {
            moduleContext.success(ret, true);
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
        this.moduleContext = moduleContext;
        int platformStr = moduleContext.optInt("platform");
//        Log.d("APIModuleShareSDK", "platformStr:" + platformStr);
//        if (BuildConfig.DEBUG) Log.d("APIModuleShareSDK", "platformStr:" + platformStr);
        String name = ShareSDK.platformIdToName(platformStr);
        Platform platform = ShareSDK.getPlatform(name);

//        platform.SSOSetting(false);  //设置false表示使用SSO授权方式
        platform.setPlatformActionListener(platformActionListener);
        platform.authorize();
    }

    //    取消授权
    public void jsmethod_cancelAuthorize(final UZModuleContext moduleContext) {
        this.moduleContext = moduleContext;

        int platformStr = moduleContext.optInt("platform");
//        if (BuildConfig.DEBUG) Log.d("APIModuleShareSDK", "platformStr:" + platformStr);
        Platform platform = ShareSDK.getPlatform(ShareSDK.platformIdToName(platformStr));
//        if (platform.isAuthValid()) {
        platform.removeAccount(true);
        resultJsonSuccess(null);
//        } else {
//            resultJsonSuccess(null);
//        }
    }

    //    获取用户信息
    public void jsmethod_getUserInfo(final UZModuleContext moduleContext) {
        this.moduleContext = moduleContext;

        int platformStr = moduleContext.optInt("platform");
//        if (BuildConfig.DEBUG) Log.d("APIModuleShareSDK", "platformStr:" + platformStr);
        Platform platform = ShareSDK.getPlatform(ShareSDK.platformIdToName(platformStr));
        ShareSDK.setActivity((Activity) moduleContext.getContext());//抖音登录适配安卓9.0

        platform.setPlatformActionListener(platformActionListener);
        platform.showUser(null);
    }

    public void jsmethod_shareContent(final UZModuleContext moduleContext) throws JSONException {
        this.moduleContext = moduleContext;

        JSONObject shareParamsJSONObject = moduleContext.optJSONObject("shareParams");
        int platformStr = moduleContext.optInt("platform");
        int shareType = moduleContext.optInt("shareType");

        String name = ShareSDK.platformIdToName(platformStr);
        Platform platform = ShareSDK.getPlatform(name);
        Platform.ShareParams shareParams = new Platform.ShareParams();


//        String videoUrl = shareParamsJSONObject.optString("videoUrl");
//        String videoPath = shareParamsJSONObject.optString("videoPath");
//        String description = shareParamsJSONObject.optString("description");


//        if (BuildConfig.DEBUG) Log.d("APIModuleShareSDK", "platformStr:" + platformStr);
        if (shareParamsJSONObject != null) {

            if (shareParamsJSONObject.has("text")) {
                String text = shareParamsJSONObject.optString("text");
                shareParams.setText(text);
            }

            if (shareParamsJSONObject.has("ImageArray")) {
                JSONArray jsonArray = shareParamsJSONObject.optJSONArray("ImageArray");
                String[] imageArray = new String[jsonArray.length()];
                for (int i = 0; i < jsonArray.length(); i++) {
                    imageArray[i] = (String) jsonArray.get(i);
                }
                shareParams.setImageArray(imageArray);
            }
            if (shareParamsJSONObject.has("imageUrl")) {
                String imageUrl = shareParamsJSONObject.optString("imageUrl");

                shareParams.setImageUrl(imageUrl);
            }
            if (shareParamsJSONObject.has("title")) {
                String title = shareParamsJSONObject.optString("title");

                shareParams.setTitle(title);
            }
            if (shareParamsJSONObject.has("Hashtag")) {
                String hashTag = shareParamsJSONObject.optString("Hashtag");
                shareParams.setHashtag(hashTag);
            }
            if (shareParamsJSONObject.has("titleUrl")) {
                String titleUrl = shareParamsJSONObject.optString("titleUrl");

                shareParams.setTitleUrl(titleUrl);
            }
            if (shareParamsJSONObject.has("musicUrl")) {
                String musicUrl = shareParamsJSONObject.optString("musicUrl");

                shareParams.setMusicUrl(musicUrl);
            }
            if (shareParamsJSONObject.has("url")) {
                String url = shareParamsJSONObject.optString("url");

                shareParams.setUrl(url);
            }
//        if (shareParamsJSONObject.has("videoUrl")) {
//            shareParams.setVideoUri(videoUrl);
//        }
//        if (shareParamsJSONObject.has("musicUrl")) {
//            shareParams.setMusicUrl(musicUrl);
//        }
//        if (shareParamsJSONObject.has("description")) {
//            shareParams.setd(description);
//        }
            if (shareParamsJSONObject.has("site")) {
                String site = shareParamsJSONObject.optString("site");

                shareParams.setSite(site);
            }
            if (shareParamsJSONObject.has("siteUrl")) {
                String siteUrl = shareParamsJSONObject.optString("siteUrl");

                shareParams.setSiteUrl(siteUrl);
            }
        }

//        if (moduleContext.("type")) {
        shareParams.setShareType(shareType);
//        }

        platform.setPlatformActionListener(platformActionListener);
        platform.share(shareParams);

    }

    public void jsmethod_oneKeyShareContent(final UZModuleContext moduleContext) throws JSONException {
        this.moduleContext = moduleContext;
        JSONObject shareParamsJSONObject = moduleContext.optJSONObject("shareParams");
        JSONArray hiddenPlatformList = moduleContext.optJSONArray("hiddenPlatformList");
        OnekeyShare oks = new OnekeyShare();

        for (int i = 0; i < hiddenPlatformList.length(); i++) {
            oks.addHiddenPlatform(ShareSDK.platformIdToName((int) hiddenPlatformList.get(i)));
        }
        if (shareParamsJSONObject != null) {

            if (shareParamsJSONObject.has("text")) {
                String text = shareParamsJSONObject.optString("text");
                oks.setText(text);
            }
            if (shareParamsJSONObject.has("imageUrl")) {
                String imageUrl = shareParamsJSONObject.optString("imageUrl");
                oks.setImageUrl(imageUrl);
            }
            if (shareParamsJSONObject.has("title")) {
                String title = shareParamsJSONObject.optString("title");
                oks.setTitle(title);
            }
            if (shareParamsJSONObject.has("titleUrl")) {
                String titleUrl = shareParamsJSONObject.optString("titleUrl");
                oks.setTitleUrl(titleUrl);
            }
            if (shareParamsJSONObject.has("site")) {
                String site = shareParamsJSONObject.optString("site");
                oks.setSite(site);
            }
            if (shareParamsJSONObject.has("siteUrl")) {
                String siteUrl = shareParamsJSONObject.optString("siteUrl");
                oks.setSiteUrl(siteUrl);
            }
        }
        oks.setCallback(platformActionListener);
        oks.show(context());
    }


    private String getFeature(String key) {
        String value = getFeatureValue("shareSDKPlus", key);
        return value;
    }

    //新浪
    private void deviceSina() {
        try {
            Class.forName("cn.sharesdk.sina.weibo.SinaWeibo");

            if (ShareSDK.getPlatform(SinaWeibo.NAME) != null) {
                HashMap<String, Object> sinaMap = new HashMap<String, Object>();
                sinaMap.put("AppKey", getFeature("SinaWeibo-AppKey"));
                sinaMap.put("AppSecret", getFeature("SinaWeibo-AppSecret"));
                sinaMap.put("RedirectUrl", getFeature("SinaWeibo-RedirectUrl"));
                sinaMap.put("ShareByAppClient", getFeature("SinaWeibo-ShareByAppClient"));
                sinaMap.put("Enable", "true");
                ShareSDK.setPlatformDevInfo(SinaWeibo.NAME, sinaMap);
            }
        } catch (ClassNotFoundException ignored) {
        }

    }

    private void deviceDingding() {
        try {
            Class.forName("cn.sharesdk.dingding.friends.Dingding");

            if (ShareSDK.getPlatform(Dingding.NAME) != null) {
                HashMap<String, Object> sinaMap = new HashMap<String, Object>();
                sinaMap.put("AppId", getFeature("Dingding-AppId"));
                sinaMap.put("BypassApproval", getFeature("Dingding-BypassApproval"));
                sinaMap.put("RedirectUrl", getFeature("Dingding-RedirectUrl"));
                sinaMap.put("Enable", "true");
                ShareSDK.setPlatformDevInfo(Dingding.NAME, sinaMap);
            }
        } catch (ClassNotFoundException ignored) {
        }

    }

    //deviceAlipay
    private void deviceAlipay() {
        try {
            Class.forName("cn.sharesdk.alipay.friends.Alipay");

            if (ShareSDK.getPlatform(Alipay.NAME) != null) {
                HashMap<String, Object> sinaMap = new HashMap<String, Object>();
                sinaMap.put("AppId", getFeature("Alipay-AppId"));
                sinaMap.put("Enable", "true");
                ShareSDK.setPlatformDevInfo(Alipay.NAME, sinaMap);
                ShareSDK.setPlatformDevInfo(AlipayMoments.NAME, sinaMap);
            }
        } catch (ClassNotFoundException ignored) {
        }

    }

    //QQ
    private void devicesQQ() {
        try {
            Class.forName("cn.sharesdk.tencent.qq.QQ");
            if (ShareSDK.getPlatform(QQ.NAME) != null) {
                HashMap<String, Object> qqMap = new HashMap<String, Object>();
                qqMap.put("AppId", getFeature("QQ-AppId"));
                qqMap.put("AppKey", getFeature("QQ-AppKey"));
                qqMap.put("BypassApproval", getFeature("QQ-BypassApproval"));
                qqMap.put("ShareByAppClient", getFeature("QQ-ShareByAppClient"));
                qqMap.put("Enable", "true");
                ShareSDK.setPlatformDevInfo(QQ.NAME, qqMap);
                ShareSDK.setPlatformDevInfo(QZone.NAME, qqMap);
            }
        } catch (ClassNotFoundException ignored) {
        }
    }

    //微信
    private void devicesWeChat() {
        try {
            Class.forName("cn.sharesdk.wechat.friends.Wechat");
            if (ShareSDK.getPlatform(Wechat.NAME) != null) {
                HashMap<String, Object> wechatMap = new HashMap<String, Object>();
                wechatMap.put("AppId", getFeature("WeChat-AppId"));
                wechatMap.put("AppSecret", getFeature("WeChat-AppSecret"));
                wechatMap.put("BypassApproval", getFeature("WeChat-BypassApproval"));
                wechatMap.put("WithShareTicket", getFeature("WeChat-WithShareTicket"));
                wechatMap.put("Enable", true);
                ShareSDK.setPlatformDevInfo(Wechat.NAME, wechatMap);
                ShareSDK.setPlatformDevInfo(WechatMoments.NAME, wechatMap);
                ShareSDK.setPlatformDevInfo(WechatFavorite.NAME, wechatMap);
            }
        } catch (ClassNotFoundException ignored) {
        }
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
    //facebook
    private void devicesFacebook() {
        try {
            Class.forName("cn.sharesdk.facebook.Facebook");
            if (ShareSDK.getPlatform(Facebook.NAME) != null) {
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("ConsumerKey", getFeature("Facebook-ConsumerKey"));
                map.put("ConsumerSecret", getFeature("Facebook-ConsumerSecret"));
                map.put("RedirectUrl", getFeature("Facebook-RedirectUrl"));
                map.put("ShareByAppClient", getFeature("Facebook-ShareByAppClient"));
                map.put(Constant.Key.ENABLE, "true");
                ShareSDK.setPlatformDevInfo(Facebook.NAME, map);
            }
        } catch (ClassNotFoundException ignored) {
        }
    }

    //facebookMessage
//    private void devicesFacebookMessage() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppId", "FacebookMessage_AppKey", map);
//        map.put("Enable", "true");
//        ShareSDK.setPlatformDevInfo(FacebookMessenger.NAME, map);
//    }
//
    //Twitter
    private void devicesTwitter() {
        try {
            Class.forName("cn.sharesdk.twitter.Twitter");
            if (ShareSDK.getPlatform(Twitter.NAME) != null) {
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("ConsumerKey", getFeature("Twitter-ConsumerKey"));
                map.put("ConsumerSecret", getFeature("Twitter-ConsumerSecret"));
                map.put("CallbackUrl", getFeature("Twitter-CallbackUrl"));
                map.put("ShareByAppClient", getFeature("Twitter-ShareByAppClient"));
                map.put("BypassApproval", getFeature("Twitter-BypassApproval"));
                map.put("Enable", "true");
                ShareSDK.setPlatformDevInfo(Twitter.NAME, map);
            }
        } catch (ClassNotFoundException ignored) {
        }
    }

    //Instagram
    private void devicesInstagram() {
        try {
            Class.forName("cn.sharesdk.instagram.Instagram");
            if (ShareSDK.getPlatform(Instagram.NAME) != null) {
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("ClientId", getFeature("Instagram-ClientId"));
                map.put("ClientSecret", getFeature("Instagram-ClientSecret"));
                map.put("RedirectUrl", getFeature("Instagram-RedirectUri"));
                map.put("ShareByAppClient", getFeature("Instagram-ShareByAppClient"));
                map.put("Enable", "true");
                ShareSDK.setPlatformDevInfo(Instagram.NAME, map);
            }
        } catch (ClassNotFoundException ignored) {
        }
    }


    //Google
    private void devicesGoogle() {
        try {
            Class.forName("cn.sharesdk.google.GooglePlus");
            if (ShareSDK.getPlatform(GooglePlus.NAME) != null) {
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("ClientID", getFeature("Google-ClientID"));
                map.put("RedirectUrl", getFeature("Google-RedirectUri"));
                map.put("ShareByAppClient", getFeature("Google-ShareByAppClient"));
//                map.put("OfficialVersion", "default");
                map.put("Enable", "true");
                ShareSDK.setPlatformDevInfo(GooglePlus.NAME, map);
            }
        } catch (ClassNotFoundException ignored) {
        }
    }

    //Line
    private void devicesLine() {
        try {
            Class.forName("cn.sharesdk.line.Line");
            if (ShareSDK.getPlatform(Line.NAME) != null) {
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("ChannelID", getFeature("Line-ChannelID"));
                map.put("ChannelSecret", getFeature("Line-ChannelSecret"));
                map.put("RedirectUri", getFeature("Line-RedirectUri"));
                map.put("callbackscheme", "lineauth");
                map.put("Enable", "true");
                ShareSDK.setPlatformDevInfo(Line.NAME, map);
            }
        } catch (ClassNotFoundException ignored) {
        }
    }

    //
//	private void devicesWhatsApp(){
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		map.put("enable", true);
//		ShareSDK.setPlatformDevInfo(WhatsApp.NAME, map);
//	}
//
//
//    //DingTalk
//    private void devicesDingTalk() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("AppId", "DingTalk_AppKey", map);
//        map.put(Constant.Key.SHARE_BY_APP_CLIENT, "true");
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
//        map.put(Constant.Key.SHARE_BY_APP_CLIENT, "true");
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
    //Kakao
    private void devicesKakao() {
        try {
            Class.forName("cn.sharesdk.kakao.utils.KakaoWebViewClient");
            if (ShareSDK.getPlatform(KakaoTalk.NAME) != null) {
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("AppKey", getFeature("Kakao-AppKey"));
                map.put("Enable", "true");
                ShareSDK.setPlatformDevInfo(KakaoTalk.NAME, map);
                ShareSDK.setPlatformDevInfo(KakaoStory.NAME, map);
            }
        } catch (ClassNotFoundException ignored) {
        }
    }

    //Telegram
    private void devicesTelegram() {
        try {
            Class.forName("cn.sharesdk.telegram.Telegram");
            if (ShareSDK.getPlatform(Telegram.NAME) != null) {
                HashMap<String, Object> map = new HashMap<String, Object>();
                map.put("AppKey", getFeature("Telegram-AppKey"));
                map.put("RedirectUrl", getFeature("Telegram-RedirectUrl"));
                map.put("Enable", "true");
                ShareSDK.setPlatformDevInfo(Telegram.NAME, map);
            }
        } catch (ClassNotFoundException ignored) {
        }
    }

//
//    //Youtube
//    private void devicesYoutube() {
//        HashMap<String, Object> map = new HashMap<String, Object>();
//        checkParam("ClientID", "YouTube_AppKey", map);
//        checkParam("AppSecret", "YouTube_AppSecret", map);
//        checkParam("RedirectUrl", "YouTube_RedirectUri", map);
//        map.put(Constant.Key.SHARE_BY_APP_CLIENT, "true");
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
//        map.put(Constant.Key.SHARE_BY_APP_CLIENT, "true");
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

}

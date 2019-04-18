
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

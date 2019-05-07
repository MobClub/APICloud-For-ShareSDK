**Android平台下目录结构说明**

ShareSDKPlus包含一个整体的工程，名称为ApiCloud。此工程是一个在AndroidStudio环境下开发ApiCloud的工程，他包含三个主要的结构。

**app:** Android Studio环境下的效果展示demo

**shareSDKPlus**: 模块桥接包，Android Studio工程下的一个moudle，也是APICloud生成模块主包的必需工程，他的libs文件夹下包含了微信、QQ、新浪微博、facebook、twitter五个主平台。

**shareSDKPlusExtend:** 模块桥接扩展平台的包，这个包内部是一个空的实现，用户可以根据自己的需求自定义实现需要实现的平台。

 

**针对具体的拓展模块的制作做一个说明：**

1.在原有的工程上（也可以自己新建一个工程）新建一个Module，如下图的操作所示。

![https://github.com/MobClub/APICloud-For-ShareSDK/blob/master/image/001.png]()

2.添加所需要的依赖包，所需要的拓展平台的包可以在http://www.mob.com/download 这个地址内获取。同时拓展模块同样需要依赖apiEngine包。

![https://github.com/MobClub/APICloud-For-ShareSDK/blob/master/image/002.png]()

![https://github.com/MobClub/APICloud-For-ShareSDK/blob/master/image/0022.png]()

3. 拓展模块AndroidManifest.xml文件的配置

如下图所示，拓展模块的AndroidManifest.xml文件依然需要集成UZApplication。同时，如果集成的第三方平台需要添加回调监听类，则可以参考http://wiki.mob.com/sharesdk%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E9%9D%9Emaven/ 这个地址下面中的“三、配置Android Manifest.xml”这一栏进行相关的配置。

![https://github.com/MobClub/APICloud-For-ShareSDK/blob/master/image/003.png]()

4. 导出模块包

做完上述步骤之后，需要将该模块编译为AAR包，将项目焦点聚集在shareSDKPlusExtend这个要导出的模块上，并在右侧Gradle projects下找到对应的目录下边，执行assembleRelease命令，如下图：

![https://github.com/MobClub/APICloud-For-ShareSDK/blob/master/image/004.png]()

​	5. 处理module.json文件

新打出的aar在制作自定义模块之前，同样需要module.json文件，名称一定不要书写错误，区分大小写，否则将无法使用。

如下图所示

![https://github.com/MobClub/APICloud-For-ShareSDK/blob/master/image/005.png]()

6. 制作ZIP包

将文件夹压缩为标准的zip格式的文件，即可进行自定义模块的上传，文件夹，及压缩文件的名称与module.json中的要相互对应，区分大小写，否则将无法使用。

![https://github.com/MobClub/APICloud-For-ShareSDK/blob/master/image/006.png]()

![https://github.com/MobClub/APICloud-For-ShareSDK/blob/master/image/0062.png]()

7.上传到自定义模块

以上步骤完成之后，就可以上传到自定义模块了，如下图所示。

![https://github.com/MobClub/APICloud-For-ShareSDK/blob/master/image/007.png]()


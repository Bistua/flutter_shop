

原型图：
https://fbw50t.axshare.com/#g=1

密码：201902


flutter android ios google hybrid方案

需要flutter最新版1.2

或者使用dev1.19版也行

其它版本不确定是否支持hybrid
修改settings.gradle
将'./bristuaftshop/flutter_lib/.android/include_flutter.groovy'中的
bristuaftshop改成你的父类文件夹目录


include ':app'
setBinding(new Binding([gradle: this]))
evaluate(new File(
  settingsDir.parentFile,
  './bristuaftshop/flutter_lib/.android/include_flutter.groovy'
))


首次打开项目，执行以下命令

cd flutter_lib

flutter build apk



google hybrid方案：https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps


蓝图地址：
https://lanhuapp.com/url/tzWeO


百度云地址：

https://pan.baidu.com/s/12gGDI8O5WicXhgkXaEdFMQ

密码: nxms


禅道 项目跟进系统：
pm.bristua.com
初始密码：bristua123456
账号：个人手机号



# 0401RedRock
#0330
###Xcode7 涉及到访问http资源时碰到报错：
App Transport Security has blocked a cleartext HTTP (http://) resource load since it is insecure. 
解决：
录下info.plist
增加属性字典 App Transport Security Settings
在这个属性下增加节点 Allow Arbitrary Loads, value 为 YES
![Alt text](./0F94B6B1-811E-415B-9836-27486DA25F90.png)

iOS9 弃用NSURLconnection 用NSURLSession 
代替
* NSURLSession使用
* CocoaPods 安装和使用
* HTTPS和HTTP的区别
* 原子性与非原子性
* copy、assign与retain
* mac建立txt
* uibutton
 ![Alt text](./1834A82D-D248-4E03-9E3C-CA9737DDBD4B.png)
 如果是选中状态改为非选中状态 如此循环





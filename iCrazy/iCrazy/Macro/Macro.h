//
//  Header.h
//  iLazy
//
//  Created by administrator on 15/9/21.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#ifndef GDLBSAmap_Macro_h
#define GDLBSAmap_Macro_h

#pragma mark - MapAPIkey
#define APIKEY @"498c90a6013d28c1658906ce077416a3"

#pragma mark - 用户密码加密Key
#define USER_KEY @"HuangYiLuisStupid"

#pragma mark - 验证码的key
#define APP_KEY @"a8bce8f5be3e"
#define APP_SECRET @"f42d90905afcacecbe8714c6f24c8c90"

#pragma mark - 设备宽度
#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#pragma mark - 设备高度
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#pragma mark - 颜色
#define COLORMAMP(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]

#define COLORNAVIGATION COLORMAMP(75,195,210,1)

#define COLORMJREFRESH COLORMAMP(47,136,167,1)

#define kArrorHeight        10

#define kCalloutWidth       100.0
#define kCalloutHeight      70.0

#define kPortraitMargin     5
#define kPortraitWidth      70
#define kPortraitHeight     50

#define kTitleWidth         120
#define kTitleHeight        20


#pragma mark - 请求数据操作的URL

#pragma mark - l_order表查询
#define iS_ORDER_ALL_ADDRESS @"http://121.42.205.183:8080/iLazy/index.php/Home/Order/queryAll"
//#define iS_ORDER_ALL_ADDRESS @"http://10.110.6.26:5555/iLazy/index.php/Home/Order/queryAll"

#pragma mark - c_order表查询
#define iS_ORDER_ADDRESS @"http://121.42.205.183:8080/iCrazy/index.php/Home/Order/query"
//#define iS_ORDER_ADDRESS @"http://10.110.6.26:5555/iCrazy/index.php/Home/Order/query"

#pragma mark - l_userInfo表查询
#define iS_SElECT_USERINFO @"http://121.42.205.183:8080/iLazy/index.php/Home/UserInfo/query"
//#define iS_SElECT_USERINFO @"http://10.110.6.26:5555/iLazy/index.php/Home/UserInfo/query"


#pragma mark - 修改l_order状态
#define iS_ALTER_ORDER_STATUS @"http://121.42.205.183:8080/iLazy/index.php/Home/Order/update"
//#define iS_ALTER_ORDER_STATUS @"http://10.110.6.26:5555/iLazy/index.php/Home/Order/update"

#pragma mark - 修改c_order状态
#define iS_ALTER_CRAZY_ORDER_STATUS @"http://121.42.205.183:8080/iCrazy/index.php/Home/Order/update"
//#define iS_ALTER_CRAZY_ORDER_STATUS @"http://10.110.6.26:5555/iCrazy/index.php/Home/Order/update"


#pragma mark - 删除订单表(l_order)中的信息
#define iS_DELETE_LAZY_ORDER @"http://121.42.205.183:8080/iLazy/index.php/Home/Order/delet"
//#define iS_DELETE_LAZY_ORDER @"http://10.110.6.26:5555/iLazy/index.php/Home/Order/delet"

#pragma mark - 删除订单表(c_order)中的信息
#define iS_DELETE_CRAZY_ORDER @"http://121.42.205.183:8080/iCrazy/index.php/Home/Order/delet"
//#define iS_DELETE_CRAZY_ORDER @"http://10.110.6.26:5555/iCrazy/index.php/Home/Order/delet"

#pragma mark - 添加反馈信息
#define iS_INSERT_IDEA @"http://121.42.205.183:8080/iCrazy/index.php/Home/Repeat/idea"
//#define iS_INSERT_IDEA @"http://10.110.6.26:5555/iCrazy/index.php/Home/Repeat/idea"

#pragma mark - 添加反馈图片
#define iS_INSERT_IDEA_IMAGE @"http://121.42.205.183:8080/iCrazy/index.php/Home/Repeat/uploadIderImage"
//#define iS_INSERT_IDEA_IMAGE @"http://10.110.6.26:5555/iCrazy/index.php/Home/Repeat/uploadIderImage"

//--------------------------------------
#pragma mark-------小熊勤人端请求数据

#pragma mark----用户登录
#define iS_LOGIN_ADDRESS @"http://121.42.205.183:8080/iCrazy/index.php/Home/User/login"
//#define iS_LOGIN_ADDRESS @"http://10.110.6.26:5555/iCrazy/index.php/Home/User/login"

#pragma mark - 用户注册信息
#define iS_REGISTER_ADDRESS @"http://121.42.205.183:8080/iCrazy/index.php/Home/User/signin"
//#define iS_REGISTER_ADDRESS @"http://10.110.6.26:5555/iCrazy/index.php/Home/User/signin"

#pragma mark ----查看用户是否已经注册过
#define iS_ExistName @"http://121.42.205.183:8080/iCrazy/index.php/Home/Repeat/query"
//#define iS_ExistName @"http://10.110.6.26:5555/iCrazy/index.php/Home/Repeat/query"

#pragma mark ---请求插入用户信息表
#define iS_Insert_UserInfo @"http://121.42.205.183:8080/iCrazy/index.php/Home/UserInfo/insert"
//#define iS_Insert_UserInfo @"http://10.110.6.26:5555/iCrazy/index.php/Home/UserInfo/insert"

#pragma mark-------请求查询（懒人端）所有订单(模糊订单)
#define iS_Order_Search @"http://121.42.205.183:8080/iLazy/index.php/Home/Order/search"
//#define iS_Order_Search @"http://10.110.6.26:5555/iLazy/index.php/Home/Order/search"

#pragma mark ---请求找回密码请求
#define iS_Uppassword @"http://121.42.205.183:8080/iCrazy/index.php/Home/User/uppassword"
//#define iS_Uppassword @"http://10.110.6.26:5555/iCrazy/index.php/Home/User/uppassword"

#pragma  mark----------请求用户信息表(懒人端)
#define iS_User_Info @"http://121.42.205.183:8080/iLazy/index.php/Home/UserInfo/query"
//#define iS_User_Info @"http://10.110.6.26:5555/iLazy/index.php/Home/UserInfo/query"

#pragma mark -----------请求插入勤人端订单表
#define iS_Insert_order @"http://121.42.205.183:8080/iCrazy/index.php/Home/Order/insert"
//#define iS_Insert_order @"http://10.110.6.26:5555/iCrazy/index.php/Home/Order/insert"

#pragma mark - 插入用户信用表信息
#define iS_INSERT_CREDIT @"http://121.42.205.183:8080/iCrazy/index.php/Home/Credit/insert"

#pragma mark - 根据orderid查询订单
#define iS_Orderid_order @"http://121.42.205.183:8080/iLazy/index.php/Home/Order/queryOrderid"
//#define iS_Orderid_order @"http://10.110.6.26:5555/iLazy/index.php/Home/Order/queryOrderid"

//------------------------------------------------------------


#define iS_RESET_ADDRESS @"http://121.42.205.183:8080/iLazy/index.php/Home/User/uppassword"
//#define iS_RESET_ADDRESS @"http://10.110.6.26:5555/iLazy/index.php/Home/User/uppassword"

#define iS_USER_STATUS_ADDRESS @"http://121.42.205.183:8080/iLazy/index.php/Home/User/upstatus"
//#define iS_USER_STATUS_ADDRESS @"http://10.110.6.26:5555/iLazy/index.php/Home/User/upstatus"

#define iS_INSERT_COMMENT @"http://121.42.205.183:8080/iCrazy/index.php/Home/Comment/insert"
//#define iS_INSERT_COMMENT @"http://10.110.6.26:5555/iCrazy/index.php/Home/Comment/insert"

#pragma mark - 图片路径(勤人)
#define IMAGE_PATH @"http://121.42.205.183:8080/iCrazy/Home/image/images/"
#define LAZY_IMAGE_PATH @"http://121.42.205.183:8080/iLazy/Home/image/images/"
//#define IMAGE_PATH @"http://10.110.6.26:5555/iCrazy/Home/image/images/"
//#define LAZY_IMAGE_PATH @"http://10.110.6.26:5555/iLazy/Home/image/images/"

#pragma mark - 添加头像
#define iS_INSERT_USER_IMAGE @"http://121.42.205.183:8080/iCrazy/index.php/Home/UserInfo/uploadHeaderImage"
//#define iS_INSERT_USER_IMAGE @"http://10.110.6.26:5555/iCrazy/index.php/Home/UserInfo/uploadHeaderImage"

#pragma mark - 检验密码
#define iS_TEST_PASSWORD @"http://121.42.205.183:8080/iCrazy/index.php/Home/User/queryName"
//#define iS_TEST_PASSWORD @"http://10.110.6.26:5555/iCrazy/index.php/Home/User/queryName"


//-------------------------------------------------------------------

//插入存储Crazy端的用户位置信息
#define iS_INSERT_ICRAZY_LOCATION @"http://121.42.205.183:8080/iCrazy/index.php/Home/Location/insert"
//#define iS_INSERT_ICRAZY_LOCATION @"http://10.110.6.26:5555/iCrazy/index.php/Home/Location/insert"

//修改Lazy端的用户信息
#define iS_ALTER_ICRAZY_USERINFO @"http://121.42.205.183:8080/iCrazy/index.php/Home/UserInfo/updata"
//#define iS_ALTER_ICRAZY_USERINFO @"http://10.110.6.26:5555/iCrazy/index.php/Home/UserInfo/updata"

//查询Lrazy端的用户信息
#define iS_SElECT_ILAZY_USERINFO @"http://121.42.205.183:8080/iLazy/index.php/Home/UserInfo/query"
//#define iS_SElECT_ILAZY_USERINFO @"http://10.110.6.26:5555/iLazy/index.php/Home/UserInfo/query"

//查询Crazy端的用户信息
#define iS_SElECT_ICRAZY_USERINFO @"http://121.42.205.183:8080/iCrazy/index.php/Home/UserInfo/query"
//#define iS_SElECT_ICRAZY_USERINFO @"http://10.110.6.26:5555/iCrazy/index.php/Home/UserInfo/query"

//查询Lazy端的用户位置
#define iS_SElECT_ILAZY_USERLOCATION @"http://121.42.205.183:8080/iLazy/index.php/Home/Location/query"
//#define iS_SElECT_ILAZY_USERLOCATION @"http://10.110.6.26:5555/iLazy/index.php/Home/Location/query"

//修改Crazy端的用户位置
#define iS_ALTER_ICRAZY_USERLOCATION @"http://121.42.205.183:8080/iCrazy/index.php/Home/Location/update"
//#define iS_ALTER_ICRAZY_USERLOCATION @"http://10.110.6.26:5555/iCrazy/index.php/Home/Location/update"

//修改Lazy端的用户密码
#define iS_ALTER_ICRAZY_USERPASSWD @"http://121.42.205.183:8080/iCrazy/index.php/Home/User/uppassword"
//#define iS_ALTER_ICRAZY_USERPASSWD @"http://10.110.6.26:5555/iCrazy/index.php/Home/User/uppassword"

//修改身份认证状态
#define iS_ALTER_ILAZY_IDCAR_STATUS @"http://121.42.205.183:8080/iCrazy/index.php/Home/UserInfo/approve"
//#define iS_ALTER_ILAZY_IDCAR_STATUS @"http://10.110.6.26:5555/iCrazy/index.php/Home/UserInfo/approve"

//身份证认证API
#define ILAZY_USER_IDCAR @"http://v.apix.cn/apixcredit/idcardauth/idcardauth"
#define ILAZY_USER_IDCAR_KEY @"9401d5fd850646e744c21da45d870a2f"

//查询状态为2的订单（即未被接的订单）
#define IS_SELECT_ILAZY_ORDERTWO @"http://121.42.205.183:8080/iLazy/index.php/Home/Order/queryStatus"
//#define IS_SELECT_ILAZY_ORDERTWO @"http://10.110.6.26:5555/iLazy/index.php/Home/Order/queryStatus"


// -------------------------------

#pragma mark - 获取用户信用表信息
#define iS_SELECT_CREDIT @"http://121.42.205.183:8080/iCrazy/index.php/Home/Credit/query"
//#define iS_SELECT_CREDIT @"http://10.110.6.26:5555/iCrazy/index.php/Home/Credit/query"


#endif
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
#define APIKEY @"f7643c296ef090778c1f786d7832de5a"

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

#define COLORNAVIGATION COLORMAMP(47,136,167,1)

#define COLORBACKGROUND COLORMAMP(30,56,118,1)

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
#define iS_ORDER_ADDRESS @"http://121.42.205.183:8080/iLazy/index.php/Home/Order/query"
//#define iS_ORDER_ADDRESS @"http://10.110.6.26:5555/iLazy/index.php/Home/Order/query"

#pragma mark - c_order表查询
#define iS_ORDER_ALL_ADDRESS @"http://121.42.205.183:8080/iCrazy/index.php/Home/Order/queryAll"
//#define iS_ORDER_ALL_ADDRESS @"http://10.110.6.26:5555/iCrazy/index.php/Home/Order/queryAll"

#pragma mark - c_userInfo表查询
#define iS_SElECT_USERINFO @"http://121.42.205.183:8080/iCrazy/index.php/Home/UserInfo/query"
//#define iS_SElECT_USERINFO @"http://10.110.6.26:5555/iCrazy/index.php/Home/UserInfo/query"

#pragma mark - 修改l_order状态
#define iS_ALTER_ORDER_STATUS @"http://121.42.205.183:8080/iLazy/index.php/Home/Order/update"
//#define iS_ALTER_ORDER_STATUS @"http://10.110.6.26:5555/iLazy/index.php/Home/Order/update"

#pragma mark - 修改l_order所有信息
#define iS_ALTER_ORDER_INFO @"http://121.42.205.183:8080/iLazy/index.php/Home/Order/updateOreder"
//#define iS_ALTER_ORDER_INFO @"http://10.110.6.26:5555/iLazy/index.php/Home/Order/updateOreder"

#pragma mark - 修改c_order状态
#define iS_ALTER_CRAZY_ORDER_STATUS @"http://121.42.205.183:8080/iCrazy/index.php/Home/Order/update"
//#define iS_ALTER_CRAZY_ORDER_STATUS @"http://10.110.6.26:5555/iCrazy/index.php/Home/Order/update"

#pragma mark - 添加评论(l_comment)
#define iS_INSERT_COMMENT @"http://121.42.205.183:8080/iLazy/index.php/Home/Comment/insert"
//#define iS_INSERT_COMMENT @"http://10.110.6.26:5555/iLazy/index.php/Home/Comment/insert"

#pragma mark - 添加反馈信息
#define iS_INSERT_IDEA @"http://121.42.205.183:8080/iLazy/index.php/Home/Repeat/idea"
//#define iS_INSERT_IDEA @"http://10.110.6.26:5555/iLazy/index.php/Home/Repeat/idea"

#pragma mark - 添加反馈图片
#define iS_INSERT_IDEA_IMAGE @"http://121.42.205.183:8080/iLazy/index.php/Home/Repeat/uploadIderImage"
//#define iS_INSERT_IDEA_IMAGE @"http://10.110.6.26:5555/iLazy/index.php/Home/Repeat/uploadIderImage"

#pragma mark - 添加头像
#define iS_INSERT_USER_IMAGE @"http://121.42.205.183:8080/iLazy/index.php/Home/UserInfo/uploadHeaderImage"
//#define iS_INSERT_USER_IMAGE @"http://10.110.6.26:5555/iLazy/index.php/Home/UserInfo/uploadHeaderImage"

#pragma mark - 图片路径
#define IMAGE_PATH @"http://121.42.205.183:8080/iLazy/Home/image/images/"
#define CRAZY_IMAGE_PATH @"http://121.42.205.183:8080/iCrazy/Home/image/images/"
//#define IMAGE_PATH @"http://10.110.6.26:5555/iLazy/Home/image/images/"
//#define CRAZY_IMAGE_PATH @"http://10.110.6.26:5555/iCrazy/Home/image/images/"

#pragma mark - 检验密码
#define iS_TEST_PASSWORD @"http://121.42.205.183:8080/iLazy/index.php/Home/User/queryName"
//#define iS_TEST_PASSWORD @"http://10.110.6.26:5555/iLazy/index.php/Home/User/queryName"

#pragma mark - 获取用户信用表信息
#define iS_SELECT_CREDIT @"http://121.42.205.183:8080/iCrazy/index.php/Home/Credit/query"
//#define iS_SELECT_CREDIT @"http://10.110.6.26:5555/iCrazy/index.php/Home/Credit/query"

#pragma mark - 获取所有用户信用表信息
#define iS_SELECTALL_CREDIT @"http://121.42.205.183:8080/iCrazy/index.php/Home/Credit/queryAll"
//#define iS_SELECTALL_CREDIT @"http://10.110.6.26:5555/iCrazy/index.php/Home/Credit/queryAll"

#pragma mark - 修改用户信息表
#define iS_INSERT_USER_CREDIT @"http://121.42.205.183:8080/iCrazy/index.php/Home/Credit/updata"
//#define iS_INSERT_USER_CREDIT @"http://10.110.6.26:5555/iCrazy/index.php/Home/Credit/updata"

//-------------------XDD-------------------------

#define iS_LOGIN_ADDRESS @"http://121.42.205.183:8080/iLazy/index.php/Home/User/login"
//#define iS_LOGIN_ADDRESS @"http://10.110.6.26:5555/iLazy/index.php/Home/User/login"

#pragma mark - 用户注册信息
#define iS_REGISTER_ADDRESS @"http://121.42.205.183:8080/iLazy/index.php/Home/User/signin"
//#define iS_REGISTER_ADDRESS @"http://10.110.6.26:5555/iLazy/index.php/Home/User/signin"

#pragma mark ----查看用户是否已经注册过
#define iS_ExistName @"http://121.42.205.183:8080/iLazy/index.php/Home/Repeat/query"
//#define iS_ExistName @"http://10.110.6.26:5555/iLazy/index.php/Home/Repeat/query"

#pragma mark-------请求插入订单
#define iS_Insert_Order @"http://121.42.205.183:8080/iLazy/index.php/Home/Order/insert"
//#define iS_Insert_Order @"http://10.110.6.26:5555/iLazy/index.php/Home/Order/insert"

#pragma mark ---请求用户信息表
#define iS_Insert_UserInfo @"http://121.42.205.183:8080/iLazy/index.php/Home/UserInfo/insert"
//#define iS_Insert_UserInfo @"http://10.110.6.26:5555/iLazy/index.php/Home/UserInfo/insert"

#pragma mark ---请求找回密码请求
#define iS_Uppassword @"http://121.42.205.183:8080/iLazy/index.php/Home/User/uppassword"
//#define iS_Uppassword @"http://10.110.6.26:5555/iLazy/index.php/Home/User/uppassword"

//-------------------------------------------------------------

#define iS_RESET_ADDRESS @"http://121.42.205.183:8080/iLazy/index.php/Home/User/uppassword"
//#define iS_RESET_ADDRESS @"http://10.110.6.26:5555/iLazy/index.php/Home/User/uppassword"

#define iS_USER_STATUS_ADDRESS @"http://121.42.205.183:8080/iLazy/index.php/Home/User/upstatus"
//#define iS_USER_STATUS_ADDRESS @"http://10.110.6.26:5555/iLazy/index.php/Home/User/upstatus"


#define iS_DELETE_ORDER @"http://121.42.205.183:8080/iLazy/index.php/Home/Order/delet"
//#define iS_DELETE_ORDER @"http://10.110.6.26:5555/iLazy/index.php/Home/Order/delet"

#define iS_ALTER_ORDER_STATUS @"http://121.42.205.183:8080/iLazy/index.php/Home/Order/update"
//#define iS_ALTER_ORDER_STATUS @"http://10.110.6.26:5555/iLazy/index.php/Home/Order/update"


//插入存储Lazy端的用户位置信息
#define iS_INSERT_ILAZY_LOCATION @"http://121.42.205.183:8080/iLazy/index.php/Home/Location/insert"
//#define iS_INSERT_ILAZY_LOCATION @"http://10.110.6.26:5555/iLazy/index.php/Home/Location/insert"

//修改Lazy端的用户信息
#define iS_ALTER_ILAZY_USERINFO @"http://121.42.205.183:8080/iLazy/index.php/Home/UserInfo/updata"
//#define iS_ALTER_ILAZY_USERINFO @"http://10.110.6.26:5555/iLazy/index.php/Home/UserInfo/updata"

//修改Lazy端的用户密码
#define iS_ALTER_ILAZY_PASSWORD @"http://121.42.205.183:8080/iLazy/index.php/Home/User/uppassword"
//#define iS_ALTER_ILAZY_PASSWORD @"http://10.110.6.26:5555/iLazy/index.php/Home/User/uppassword"

//查询Lrazy端的用户信息
#define iS_SElECT_ILAZY_USERINFO @"http://121.42.205.183:8080/iLazy/index.php/Home/UserInfo/query"
//#define iS_SElECT_ILAZY_USERINFO @"http://10.110.6.26:5555/iLazy/index.php/Home/UserInfo/query"

//查询Crazy端的用户信息
#define iS_SElECT_ICRAZY_USERINFO @"http://121.42.205.183:8080/iCrazy/index.php/Home/UserInfo/query"
//#define iS_SElECT_ICRAZY_USERINFO @"http://10.110.6.26:5555/iCrazy/index.php/Home/UserInfo/query"

//查询Crazy端的用户位置信息
#define iS_SElECT_ICRAZY_USERLOCATION @"http://121.42.205.183:8080/iCrazy/index.php/Home/Location/query"
//#define iS_SElECT_ICRAZY_USERLOCATION @"http://10.110.6.26:5555/iCrazy/index.php/Home/Location/query"

//修改Crazy端的用户位置信息
#define iS_ALTER_ICRAZY_USERLOCATION @"http://121.42.205.183:8080/iCrazy/index.php/Home/Location/update"
//#define iS_ALTER_ICRAZY_USERLOCATION @"http://10.110.6.26:5555/iCrazy/index.php/Home/Location/update"

//修改Lazy端的用户密码
#define iS_ALTER_ILAZY_USERPASSWD @"http://121.42.205.183:8080/iLazy/index.php/Home/User/uppassword"
//#define iS_ALTER_ILAZY_USERPASSWD @"http://10.110.6.26:5555/iLazy/index.php/Home/User/uppassword"

#endif
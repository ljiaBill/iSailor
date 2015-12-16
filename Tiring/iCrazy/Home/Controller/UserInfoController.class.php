<?php
namespace Home\Controller;
use Think\Controller;
class UserInfoController extends Controller {

    public function index(){
        $this->show('<style type="text/css">*{ padding: 0; margin: 0; } div{ padding: 4px 48px;} body{ background: #fff; font-family: "微软雅黑"; color: #333;font-size:24px} h1{ font-size: 100px; font-weight: normal; margin-bottom: 12px; } p{ line-height: 1.8em; font-size: 36px } a,a:hover,{color:blue;}</style><div style="padding: 24px 48px;"> <h1>:)</h1><p>欢迎使用 <b>ThinkPHP</b>！</p><br/>版本 V{$Think.version}</div><script type="text/javascript" src="http://ad.topthink.com/Public/static/client.js"></script><thinkad id="ad_55e75dfae343f5a1"></thinkad><script type="text/javascript" src="http://tajs.qq.com/stats?sId=9347272" charset="UTF-8"></script>','utf-8');
    }

    //查询用户信息接口
    public function query()
    {
    	$Users = M("c_userinfo");
        // 定义条件 
        $info = $Users -> select();

        if ($info)
        {
            $this -> ajaxReturn(array("code" => "succeed" ,"value" => $info),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"value" => $info ),"JSON");
        }
    }

    //添加用户信息接口
    public function insert()
    {
    	// $userid = "4";
     //    $userphone    = "456789";
     //    $userimage  = "sailor.png";
     //    $registerTime = "099909990";

        $userid     = $_GET["userid"];
        $userphone    = $_GET["phone"];
        $userimage  = $_GET["image"];
        $registerTime  = $_GET["time"];

        $Users = M("c_userinfo");

        $data["c_user_userid"]  = $userid;
        $data["userphone"]   = $userphone;
        $data["userimage"] = $userimage; 
        $data["registerTime"] = $registerTime; 
        $data["userstatus"] = "1";

        $info = $Users -> add($data);

        if ($info) {
            $this -> ajaxReturn(array("code" => "succeed" ,"message" => "修改成功"),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "添加失败" ),"JSON");
        }
    }

    //判断是否重复
    public function isExistUserid($userid)
    {
        $Users = M("c_userinfo");
        $data = $Users -> where(" c_user_userid = '$userid'") -> select();
        if ($data) {
            return true;
        }
        else
        {
            return false;
        }
    }

    //头像上传
    public function uploadHeaderImage()
    {     
        //配置
        $config = array(
            'maxSize' => 1024 * 1024,
            'rootPath' => './Home/image/',                 //根目录
            'savePath' => 'images/',                        //图片文件夹目录
            'autoSub' => true,
            'saveName' => array('uniqid','is'),             //默认的命名规则设置是采用uniqid函数生成一个唯一的字符串序列,is为图片名前缀
            'exts' => array('jpg', 'gif', 'png', 'jpeg'),
            'autoSub' => false,
            'subName' => array('date','Ymd')
          );
        $upload = new \Think\Upload($config);               // 实例化上传类

        $info = $upload -> upload();           //上传

        if ($info) 
        {
             $this -> ajaxReturn(array("code" => "succeed" ,"message" => $info),"JSON");
        }
        else
        {
             $this -> ajaxReturn(array("code" => "error" ,"message" => "$upload->getError()" ),"JSON");
        }
    }

    //删除用户信息接口
    public function delet()
    {
        $userid = $_GET["userid"];

         //重复性判断
        if ($this->isExistUserid($userid)) 
        {
            $Users = M("c_userinfo");

            // 定义条件
            $condition["c_user_userid"] = $userid;

            $info = $Users -> where($condition) -> delete();

            if ($info) 
            {
                $this -> ajaxReturn(array("code" => "succeed" ,"userid" => $userid),"JSON");
            }
            else
            {
                $this -> ajaxReturn(array("code" => "error" ,"message" => "删除失败" ),"JSON");
            }
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "没有该用户"),"JSON");
            return;
        }
    }

    //修改用户是否实名认证
    public function approve()
    {
        $userid = $_GET["userid"];
        $status = $_GET["status"];

        //重复性判断
        if ($this->isExistUserid($userid)) 
        {
            $Users = M("c_userinfo");
            // 定义条件
            $condition["c_user_userid"] = $userid;

            $data["userstatus"] = $status;
        
            $info = $Users -> where($condition) -> save($data);

            if ($info) 
            {
                $this -> ajaxReturn(array("code" => "succeed" ,"userid" => $userid),"JSON");
            }
            else
            {
                $this -> ajaxReturn(array("code" => "error" ,"message" => "修改失败" ),"JSON");
            }
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "没有该用户"),"JSON");
            return;
        }
    }
    // 修改用户信息   
    public function updata() {

        // $userid = "1";
        // $usernick   = "jack";
        // $usersex   = "usersex";
        // $userphone    = "15606946786";
        // $useremail   = "useremail";
        // $userimage  = "dfsfd.png";

        $userid     = $_GET["userid"];
        $usernick   = $_GET["usernick"];
        $usersex = $_GET["usersex"];
        $userphone    = $_GET["userphone"];
        $useremail   = $_GET["useremail"];
        $userimage  = $_GET["userimage"];
        $userstatus = $_GET["userstatus"];

        $userInfo = M("c_userinfo");
        
        $condition["c_user_userid"]  = $userid;

        $data["usernick"]  = $usernick;
        $data["usersex"] = $usersex;
        $data["userphone"]   = $userphone;
        $data["useremail"]  = $useremail;
        $data["userimage"] = $userimage; 
        $data["userstatus"] = $userstatus;

        $result = $userInfo -> where($condition) -> save($data);

        if ($result) {
            $this -> ajaxReturn(array("code" => "succeed" ,"message" => "修改成功"),"JSON");
        } else {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "修改失败"),"JSON");
        } 
    }

}
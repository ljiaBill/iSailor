<?php
namespace Home\Controller;
use Think\Controller;
class UserController extends Controller {

    public function index(){
        $this->show('<style type="text/css">*{ padding: 0; margin: 0; } div{ padding: 4px 48px;} body{ background: #fff; font-family: "微软雅黑"; color: #333;font-size:24px} h1{ font-size: 100px; font-weight: normal; margin-bottom: 12px; } p{ line-height: 1.8em; font-size: 36px } a,a:hover,{color:blue;}</style><div style="padding: 24px 48px;"> <h1>:)</h1><p>欢迎使用 <b>ThinkPHP</b>！</p><br/>版本 V{$Think.version}</div><script type="text/javascript" src="http://ad.topthink.com/Public/static/client.js"></script><thinkad id="ad_55e75dfae343f5a1"></thinkad><script type="text/javascript" src="http://tajs.qq.com/stats?sId=9347272" charset="UTF-8"></script>','utf-8');
    }

    //登陆接口
    public function login()
    {
        $username = $_GET["username"];
        $password = $_GET["password"];

        // $username = $_POST["username"];
        // $password = $_POST["password"];

        $Users = M("c_user");

        // 定义多条件
        $condition["username"] = $username;
        $condition["password"] = $password;

        $data = $Users -> where($condition) -> select();
        $sql=$Users->getLastSql();

        if ($data) 
        {
            $this -> ajaxReturn(array("code" => "succeed" ,"value" => $data ),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error","sql"=>$sql,"value" => "null" ),"JSON");
        }

    }

    //手机号码注册接口
    public function signin()
    {
    	$username = $_GET["username"];
        $password = $_GET["password"];

        // $username = $_POST["username"];
        // $password = $_POST["password"];

        //重复性判断
        if ($this->isExistName($username)) {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "手机号重复"),"JSON");
            return;
        }

        $Users = M("c_user");

        // 添加的数据
        $data["username"] = $username;
        $data["password"] = $password;
        $data["status"] = "0";

        $info = $Users -> add($data);

        $userinfo["userid"]   = $info;
        $userinfo["username"] = $username;
        $userinfo["password"] = $password;

        if ($info) 
        {
            $this -> ajaxReturn(array("code" => "succeed" ,"userinfo" => $userinfo),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "注册失败" ),"JSON");
        }
    }

    //根据id查询username
    public function queryName()
    {
        $userid = $_GET["userid"];

        $Users = M("c_user");
        // 定义条件 
        $condition["userid"] = $userid;
        
        $info = $Users ->where($condition) -> select();

        if ($info)
        {
            $this -> ajaxReturn(array("code" => "succeed" ,"value" => $info),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"value" => $info),"JSON");
        }
    }

    //判断是否已经注册
    public function isExistName($username)
    {
        $Users = M("c_user");
        $data = $Users -> where(" username = '$username'") -> select();
        if ($data) {
            return true;
        }
        else
        {
            return false;
        }
    }

    //修改密码接口
    public function uppassword()
    {
    	$username = $_GET["username"];
        $password = $_GET["password"];

        // $username = $_POST["username"];
        // $password = $_POST["password"];

        //重复性判断
        if ($this->isExistName($username)) 
        {
            $Users = M("c_user");
            // 定义条件
            $condition["username"] = $username;

            $data["password"] = $password;
        
            $info = $Users -> where($condition) -> save($data);

            if ($info) 
            {
                $this -> ajaxReturn(array("code" => "succeed" ,"username" => $username),"JSON");
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

    //修改用户状态接口
    public function upstatus()
    {
        $username = $_GET["username"];
        $status = $_GET["status"];

        // $username = $_POST["username"];
        // $status = $_POST["status"];

        //重复性判断
        if ($this->isExistName($username)) 
        {
            $Users = M("c_user");
            // 定义条件
            $condition["username"] = $username;

            $data["status"] = $status;
        
            $info = $Users -> where($condition) -> save($data);

            if ($info) 
            {
                $this -> ajaxReturn(array("code" => "succeed" ,"username" => $username),"JSON");
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
}
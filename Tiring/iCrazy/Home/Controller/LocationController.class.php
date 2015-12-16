<?php
namespace Home\Controller;
use Think\Controller;
class LocationController extends Controller {

    public function index(){
        $this->show('<style type="text/css">*{ padding: 0; margin: 0; } div{ padding: 4px 48px;} body{ background: #fff; font-family: "微软雅黑"; color: #333;font-size:24px} h1{ font-size: 100px; font-weight: normal; margin-bottom: 12px; } p{ line-height: 1.8em; font-size: 36px } a,a:hover,{color:blue;}</style><div style="padding: 24px 48px;"> <h1>:)</h1><p>欢迎使用 <b>ThinkPHP</b>！</p><br/>版本 V{$Think.version}</div><script type="text/javascript" src="http://ad.topthink.com/Public/static/client.js"></script><thinkad id="ad_55e75dfae343f5a1"></thinkad><script type="text/javascript" src="http://tajs.qq.com/stats?sId=9347272" charset="UTF-8"></script>','utf-8');
    }

    //查询用户位置信息接口
    public function query()
    {
        // $userid = $_GET["userid"];

        // $userid = $_POST["userid"];

        $Users = M("c_location");

        // 定义条件
        // $condition["c_user_userid"] = $userid;

        // $data = $Users -> where($condition) -> select();

        $data = $Users -> select();

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

    //添加用户位置信息接口
    public function insert()
    {
        $userid = $_GET["userid"];
        $locationinfo = $_GET["locationinfo"];

        // $userid = $_POST["userid"];
        // $locationinfo = $_POST["locationinfo"];

        //重复性判断
        if ($this->isExistUserid($userid)) {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "重复ID"),"JSON");
            return;
        }

        $Users = M("c_location");

        // 添加的数据
        $data["c_user_userid"] = $userid;
        $data["locationinfo"] = $locationinfo;

        $info = $Users -> add($data);

        if ($info) {
            $this -> ajaxReturn(array("code" => "succeed" ,"userid" => $userid),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "添加失败" ),"JSON");
        }
    }

    //判断是否已经存在这个ID
    public function isExistUserid($userid)
    {
        $Users = M("c_location");
        $data = $Users -> where(" c_user_userid = '$userid'") -> select();
        if ($data) {
            return true;
        }
        else
        {
            return false;
        }
    }

    //修改用户位置信息接口
    public function update()
    {
        $userid = $_GET["userid"];
        $locationinfo = $_GET["locationinfo"];

        // $userid = $_GET["userid"];
        // $locationinfo = $_GET["locationinfo"];

        //重复性判断
        if ($this->isExistUserid($userid)) 
        {
            $Users = M("c_location");

            // 定义条件
            $condition["c_user_userid"] = $userid;

            $data["locationinfo"] = $locationinfo;
        
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
            $this -> ajaxReturn(array("code" => "error" ,"message" => "没有该ID"),"JSON");
            return;
        }
    }
}
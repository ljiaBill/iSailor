<?php
namespace Home\Controller;
use Think\Controller;
class CreditController extends Controller {

    public function index(){
        $this->show('<style type="text/css">*{ padding: 0; margin: 0; } div{ padding: 4px 48px;} body{ background: #fff; font-family: "微软雅黑"; color: #333;font-size:24px} h1{ font-size: 100px; font-weight: normal; margin-bottom: 12px; } p{ line-height: 1.8em; font-size: 36px } a,a:hover,{color:blue;}</style><div style="padding: 24px 48px;"> <h1>:)</h1><p>欢迎使用 <b>ThinkPHP</b>！</p><br/>版本 V{$Think.version}</div><script type="text/javascript" src="http://ad.topthink.com/Public/static/client.js"></script><thinkad id="ad_55e75dfae343f5a1"></thinkad><script type="text/javascript" src="http://tajs.qq.com/stats?sId=9347272" charset="UTF-8"></script>','utf-8');
    }

    //查询信用接口
    public function query()
    {
    	$userid = $_GET["userid"];
    	
        $Users = M("c_credit");
        
        // 定义条件 
        $condition["c_user_userid"] = $userid;
        
        $info = $Users -> where($condition) -> select();

        if ($info)
        {
            $this -> ajaxReturn(array("code" => "succeed" ,"value" => $info),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"value" => "null" ),"JSON");
        }
    }
    
    //查询所有用户信用度
    public function queryAll()
    {
    	
        $Users = M("c_credit");
        
        $info = $Users -> select();

        if ($info)
        {
            $this -> ajaxReturn(array("code" => "succeed" ,"value" => $info),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"value" => "null" ),"JSON");
        }
    }


    //添加信用信息接口
    public function insert()
    {
        $userid = $_GET["userid"];
        $creditinfo = $_GET["creditinfo"];

        //重复性判断
        if ($this->isExist($userid)) 
        {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "重复添加"),"JSON");
            return;
        }

        $Users = M("c_credit");

        // 添加的数据
        $data["c_user_userid"] = $userid;
        $data["creditinfo"] = $creditinfo;

        $info = $Users -> add($data);

        if ($info) 
        {
            $this -> ajaxReturn(array("code" => "succeed" ,"message" => "添加成功"),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "添加失败" ),"JSON");
        }
    }

    //修改用户信用表
    public function updata() {

        $userid   = $_GET["userid"];
        $creditinfo  = $_GET["creditinfo"];

        $userInfo = M("c_credit");

        $condition["c_user_userid"] = $userid;

        $data["creditinfo"] = $creditinfo;

        $result = $userInfo -> where($condition) -> save($data);

        if ($result) 
        {
            $this -> ajaxReturn(array("code" => "succeed" ,"message" => "修改成功"),"JSON");
        } else 
        {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "修改失败"),"JSON");
        } 
    }


    //判断是否已经存在这个信用信息
    public function isExist($userid)
    {
        $Users = M("c_credit");

        $condition["c_user_userid"] = $userid;

        $data = $Users -> where($condition) -> select();
        if ($data) {
            return true;
        }
        else
        {
            return false;
        }
    }
}
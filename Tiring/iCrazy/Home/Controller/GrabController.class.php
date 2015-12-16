<?php
namespace Home\Controller;
use Think\Controller;
class GrabController extends Controller {

    public function index(){
        $this->show('<style type="text/css">*{ padding: 0; margin: 0; } div{ padding: 4px 48px;} body{ background: #fff; font-family: "微软雅黑"; color: #333;font-size:24px} h1{ font-size: 100px; font-weight: normal; margin-bottom: 12px; } p{ line-height: 1.8em; font-size: 36px } a,a:hover,{color:blue;}</style><div style="padding: 24px 48px;"> <h1>:)</h1><p>欢迎使用 <b>ThinkPHP</b>！</p><br/>版本 V{$Think.version}</div><script type="text/javascript" src="http://ad.topthink.com/Public/static/client.js"></script><thinkad id="ad_55e75dfae343f5a1"></thinkad><script type="text/javascript" src="http://tajs.qq.com/stats?sId=9347272" charset="UTF-8"></script>','utf-8');
    }

    //查询抢单信息
    public function query()
    {
        // $userid = $_GET["userid"];

        $Users = M("c_grab");
        // 定义条件 
        // $condition["c_user_userid"] = $userid;

        // $info = $Users -> where($condition) -> select();

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

    //添加抢单信息接口
    public function insert()
    {
        $userid = $_GET["userid"];
        $orderid = $_GET["orderid"];

        $status = "-1";

        //重复性判断
        if ($this->isExist($userid,$orderid)) 
        {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "已抢过了"),"JSON");
            return;
        }

        $Users = M("c_grab");

        // 添加的数据
        $data["grabstatus"] = $status;
        $data["c_user_userid"] = $userid;
        $data["l_order_orderid"] = $orderid;

        $info = $Users -> add($data);

        if ($info) 
        {
            $this -> ajaxReturn(array("code" => "succeed" ,"message" => "抢单成功"),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "抢单失败" ),"JSON");
        }
    }

    //判断是否已经抢单了
    public function isExist($userid,$orderid)
    {
        $Users = M("c_grab");

        $condition["c_user_userid"] = $userid;
        $condition["l_order_orderid"] = $orderid;

        $data = $Users -> where($condition) -> select();
        if ($data) {
            return true;
        }
        else
        {
            return false;
        }
    }

    //修改抢单的状态接口
    public function update()
    {
    	$userid = $_GET["userid"];
        $orderid = $_GET["orderid"];
        $status = $_GET["status"];

        //重复性判断
        if ($this->isExist($userid,$orderid)) 
        {
            $Users = M("c_grab");

            // 定义条件
            $condition["c_user_userid"] = $userid;
            $condition["l_order_orderid"] = $orderid;

            $data["grabstatus"] = $status;

            $info = $Users -> where($condition) -> save($data);

            if ($info) 
            {
                $this -> ajaxReturn(array("code" => "succeed" ,"message" => "修改成功"),"JSON");
            }
            else
            {
                $this -> ajaxReturn(array("code" => "error" ,"message" => "修改失败" ),"JSON");
            }
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "没有此信息"),"JSON");
            return;
        }
    }
}
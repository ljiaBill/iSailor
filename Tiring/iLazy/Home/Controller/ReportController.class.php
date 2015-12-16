<?php
namespace Home\Controller;
use Think\Controller;
class ReportController extends Controller {

    public function index(){
        $this->show('<style type="text/css">*{ padding: 0; margin: 0; } div{ padding: 4px 48px;} body{ background: #fff; font-family: "微软雅黑"; color: #333;font-size:24px} h1{ font-size: 100px; font-weight: normal; margin-bottom: 12px; } p{ line-height: 1.8em; font-size: 36px } a,a:hover,{color:blue;}</style><div style="padding: 24px 48px;"> <h1>:)</h1><p>欢迎使用 <b>ThinkPHP</b>！</p><br/>版本 V{$Think.version}</div><script type="text/javascript" src="http://ad.topthink.com/Public/static/client.js"></script><thinkad id="ad_55e75dfae343f5a1"></thinkad><script type="text/javascript" src="http://tajs.qq.com/stats?sId=9347272" charset="UTF-8"></script>','utf-8');
    }

    //查询举报信息接口
    public function query()
    {
        $Users = M("l_report");
        // 定义条件 
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

    //添加举报信息接口
    public function insert()
    {
        $userid1 = $_GET["userid1"];
        $userid2 = $_GET["userid2"];
        $orderid = $_GET["orderid"];
        $reason = $_GET["reason"];

        //重复性判断
        if ($this -> isExist($userid1,$userid2)) 
        {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "已有此条记录"),"JSON");
            return;
        }
        else
        {
            $Users = M("l_report");

            // 添加的数据
            $data["c_user_userid"] = $userid1;
            $data["l_user_userid"] = $userid2;
            $data["l_order_orderid"] = $orderid;
            $data["reportReason"] = $reason;

            $info = $Users -> add($data);

            if ($info) 
            {
                $this -> ajaxReturn(array("code" => "succeed" ,"message" => "举报成功"),"JSON");
            }
            else
            {
                $this -> ajaxReturn(array("code" => "error" ,"message" => "举报失败" ),"JSON");
            }
        }
    }

    //修改举报状态接口
    public function update()
    {
        $userid1 = $_GET["userid1"];
        $userid2 = $_GET["userid2"];
        // $reason = $_GET["reason"];
        $status = $_GET["status"];

        //重复性判断
        if ($this -> isExist($userid1,$userid2)) 
        {

            $Users = M("l_report");

            // 定义条件
            $condition["c_user_userid"] = $userid1;
            $condition["l_user_userid"] = $userid2;

            // $data["reportReason"] = $reason;
            $data["reportStatus"] = $status;
  
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
            $this -> ajaxReturn(array("code" => "error" ,"message" => "没有此条记录"),"JSON");
            return;
        }
    }

    //判断是否已经存发布过
    public function isExist($userid1,$userid2)
    {
        $Users = M("l_report");

        $condition["c_user_userid"] = $userid1;
        $condition["l_user_userid"] = $userid2;

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
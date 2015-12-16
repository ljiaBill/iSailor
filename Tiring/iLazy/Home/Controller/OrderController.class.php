<?php
namespace Home\Controller;
use Think\Controller;
class OrderController extends Controller {

    public function index(){
        $this->show('<style type="text/css">*{ padding: 0; margin: 0; } div{ padding: 4px 48px;} body{ background: #fff; font-family: "微软雅黑"; color: #333;font-size:24px} h1{ font-size: 100px; font-weight: normal; margin-bottom: 12px; } p{ line-height: 1.8em; font-size: 36px } a,a:hover,{color:blue;}</style><div style="padding: 24px 48px;"> <h1>:)</h1><p>欢迎使用 <b>ThinkPHP</b>！</p><br/>版本 V{$Think.version}</div><script type="text/javascript" src="http://ad.topthink.com/Public/static/client.js"></script><thinkad id="ad_55e75dfae343f5a1"></thinkad><script type="text/javascript" src="http://tajs.qq.com/stats?sId=9347272" charset="UTF-8"></script>','utf-8');
    }

    //查询全部订单接口
    public function queryAll()
    {
        $Users = M("l_order");
        
        $info = $Users -> order("orderid desc") -> select();

        if ($info)
        {
            $this -> ajaxReturn(array("code" => "succeed" ,"value" => $info),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"value" => $info),"JSON");
        }
    }

    //查询标识为2的所有订单
    public function queryStatus()
    {
        // $orderid = $_GET["orderid"];
        $status = $_GET["status"];

        $Users = M("l_order");
        // 定义条件 
        $condition["orderstatus"] = $status;
        // $condition['orderid']  = array(array('gt',$orderid-1));

        // $info = $Users -> where($condition) ->order("orderid asc") -> limit(3) -> select();
        $info = $Users -> where($condition) -> order("orderid desc") -> select();

        if ($info)
        {
            $this -> ajaxReturn(array("code" => "succeed" ,"value" => $info),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"value" => $info),"JSON");
        }
    }

    //查询某些订单接口
    public function query()
    {
        $userid = $_GET["userid"];

        $Users = M("l_order");
        // 定义条件 
        $condition["l_user_userid"] = $userid;
        
        $info = $Users ->where($condition) -> order("orderid desc") -> select();

        if ($info)
        {
            $this -> ajaxReturn(array("code" => "succeed" ,"value" => $info),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"value" => $info),"JSON");
        }
    }
    
    //查询某些订单接口
    public function queryOrderid()
    {
        $orderid = $_GET["orderid"];

        $Users = M("l_order");
        // 定义条件 
        $condition["orderid"] = $orderid;
        
        $info = $Users -> where($condition) -> select();

        if ($info)
        {
            $this -> ajaxReturn(array("code" => "succeed" ,"value" => $info),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"value" => $info),"JSON");
        }
    }

    //模糊查询
    public function search()
    {
        $data = $_GET["data"];

        $Users = M("l_order");

        $condition["ordertitle"] = array('like',"%$data%");

        $value = $Users ->where($condition) -> order("orderid desc") -> select();

        if($value)
        {
            $this -> ajaxReturn(array("code" => "succeed" ,"value" => $value),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"value" => $value),"JSON");
        }
    }

    //添加订单接口
    public function insert()
    {
        // $orderid = $_GET["orderid"];
        $userid = $_GET["userid"];
        $title    = $_GET["title"];
        $status  = $_GET["status"];
        $price  = $_GET["price"];
        $time  = $_GET["time"];
        $insurance  = $_GET["insurance"];
        $detail  = $_GET["detail"];
        $remark  = $_GET["remark"];
        $phone = $_GET["phone"];
        // $orderid = "3";
        // $userid = "5";
        // $title    = "5666";
        // $status  = "1";
        // $price  = "9";
        // $time  = "2015-9-7";
        // $insurance  = "0";
        // $detail  = "9999999";
        // $remark  = "222222";

        $Users = M("l_order");

        // $data["orderid"]   = $orderid;
        $data["l_user_userid"]   = $userid;
        $data["ordertitle"] = $title; 
        $data["orderstatus"] = $status; 
        $data["orderprice"] = $price; 
        $data["ordertime"] = $time; 
        $data["orderinsurance"] = $insurance; 
        $data["orderdetail"] = $detail; 
        $data["orderremark"] = $remark; 
        $data["orderphone"] = $phone;

        $info = $Users -> add($data);

        if ($info) 
        {
            $this -> ajaxReturn(array("code" => "succeed" ,"value" => $info),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "添加失败" ),"JSON");
        }

        // $infoDic = $_GET["infoDic"];

        // $Users = M("l_order");

        // $info = $Users -> add($infoDic);

        // if ($info) 
        // {
        //     $this -> ajaxReturn(array("code" => "succeed" ,"value" => $infoDic),"JSON");
        // }
        // else
        // {
        //     $this -> ajaxReturn(array("code" => "error" ,"message" => "添加失败" ),"JSON");
        // }


    }

    //修改订单状态接口
    public function update()
    {
        $orderid = $_GET["orderid"];
        $status = $_GET["status"];

        // $orderid = $_POST["orderid"];
        // $status = $_POST["status"];

        //重复性判断
        if ($this->isExistOrderid($orderid)) 
        {
            $Users = M("l_order");
            // 定义条件
            $condition["orderid"] = $orderid;

            $data["orderstatus"] = $status;
        
            $info = $Users -> where($condition) -> save($data);

            if ($info) 
            {
                $this -> ajaxReturn(array("code" => "succeed" ,"orderid" => $orderid),"JSON");
            }
            else
            {
                $this -> ajaxReturn(array("code" => "error" ,"message" => "修改失败" ),"JSON");
            }
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "没有该订单"),"JSON");
            return;
        }
    }
    
    //修改订单接口
    public function updateOreder()
    {
        $orderid = $_GET["orderid"];
        $userid = $_GET["userid"];
        $title    = $_GET["title"];
        $status  = $_GET["status"];
        $price  = $_GET["price"];
        $time  = $_GET["time"];
        $insurance  = $_GET["insurance"];
        $detail  = $_GET["detail"];
        $remark  = $_GET["remark"];
        $phone = $_GET["phone"];

        $Users = M("l_order");

        $condition["orderid"]  = $orderid;

        $data["l_user_userid"]   = $userid;
        $data["ordertitle"] = $title; 
        $data["orderstatus"] = $status; 
        $data["orderprice"] = $price; 
        $data["ordertime"] = $time; 
        $data["orderinsurance"] = $insurance; 
        $data["orderdetail"] = $detail; 
        $data["orderremark"] = $remark; 
        $data["orderphone"] = $phone;

        $result = $Users -> where($condition) -> save($data);

        if ($result) {
            $this -> ajaxReturn(array("code" => "succeed" ,"message" => "修改成功"),"JSON");
        } else {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "修改失败"),"JSON");
        } 
    }

    //判断是否已经存在这个订单
    public function isExistOrderid($orderid)
    {
        $Users = M("l_order");
        $data = $Users -> where(" orderid = '$orderid'") -> select();
        if ($data) {
            return true;
        }
        else
        {
            return false;
        }
    }

    //删除订单接口
    public function delet()
    {
        $orderid = $_GET["orderid"];

         //重复性判断
        if ($this->isExistOrderid($orderid)) 
        {
            $Users = M("l_order");

            // 定义条件
            $condition["orderid"] = $orderid;

            $info = $Users -> where($condition) -> delete();

            if ($info) 
            {
                $this -> ajaxReturn(array("code" => "succeed" ,"orderid" => $orderid),"JSON");
            }
            else
            {
                $this -> ajaxReturn(array("code" => "error" ,"message" => "删除失败" ),"JSON");
            }
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error" ,"message" => "没有该订单"),"JSON");
            return;
        }
    }
}
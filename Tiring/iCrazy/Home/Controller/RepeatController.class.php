<?php
namespace Home\Controller;
use Think\Controller;
class RepeatController extends Controller {

    public function index(){
        $this->show('<style type="text/css">*{ padding: 0; margin: 0; } div{ padding: 4px 48px;} body{ background: #fff; font-family: "微软雅黑"; color: #333;font-size:24px} h1{ font-size: 100px; font-weight: normal; margin-bottom: 12px; } p{ line-height: 1.8em; font-size: 36px } a,a:hover,{color:blue;}</style><div style="padding: 24px 48px;"> <h1>:)</h1><p>欢迎使用 <b>ThinkPHP</b>！</p><br/>版本 V{$Think.version}</div><script type="text/javascript" src="http://ad.topthink.com/Public/static/client.js"></script><thinkad id="ad_55e75dfae343f5a1"></thinkad><script type="text/javascript" src="http://tajs.qq.com/stats?sId=9347272" charset="UTF-8"></script>','utf-8');
    }

    public function query()
    {
       $username = $_GET["username"];
       $Users = M("c_user");

       // 定义多条件
        $condition["username"] = $username;
        $data = $Users -> where($condition) -> select();
        if ($data) 
        {
            $this -> ajaxReturn(array("code" => "succeed" ,"value" => $data),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error","value" => "null"),"JSON");
        }
    }

    public function idea()
    {
        $info = $_GET["info"];
        $imgone = $_GET["imgone"];
        $imgtwo = $_GET["imgtwo"];

        $Users = M("idea");

        $data["info"] = $info;
        $data["imgone"] = $imgone;
        $data["imgtwo"] = $imgtwo;

        $goBack = $Users -> add($data);

        if ($goBack) 
        {
            $this -> ajaxReturn(array("code" => "succeed"),"JSON");
        }
        else
        {
            $this -> ajaxReturn(array("code" => "error"),"JSON");
        }
    }

    public function uploadIderImage()
    {     
        //配置
        $config = array(
            'maxSize' => 1024 * 1024,
            'rootPath' => './Home/image/',                 //根目录
            'savePath' => 'feedbacks/',                        //图片文件夹目录
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

  }
?>
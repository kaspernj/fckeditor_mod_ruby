<?php

class fckeditor_validate_login_mod_ruby{
  function __construct($args = array()){
    require_once "knj/os.php";
    $this->args = $args;
  }
  
  function validate(){
    $data = array(
      "_GET" => $_GET,
      "_POST" => $_POST,
      "_SERVER" => $_SERVER,
      "_COOKIE" => $_COOKIE,
      "args" => $this->args
    );
    $send_data = base64_encode(json_encode($data, true));
    $tmp_path = "/tmp/fckeditor_mod_ruby_validate_" . microtime(true) . ".txt";
    file_put_contents($tmp_path, $send_data);
    
    $cmd = "ruby \"" . dirname(__FILE__) . "/validate_login.rb\" --tmp_path=\"" . $tmp_path . "\"";
    $res = knj_os::shellCMD($cmd);
    unlink($tmp_path);
    
    return array(
      "json" => json_decode($res["result"], true),
      "res" => $res
    );
  }
}
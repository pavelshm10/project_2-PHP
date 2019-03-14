<?php

require_once 'DAL.php';
require_once 'Video.php';


session_start();

//regigter- check if there the user namae is available
function is_username_exist($username) {
	$username = addslashes($username);
	$sql = "select count(*) as total_rows from users where UserName = '$username'";
	$count = get_object($sql)->total_rows;
	return $count > 0;
}

function register($fname,$lname,$username, $password) {
	
    $username = addslashes($username);
    $password = addslashes($password);
    
    $password = crypt($password, "Testing"); // Salt the password.
    $password = sha1($password);
    
    $sql = "insert into users(FName,LName,UserName, Password) values('$fname','$lname','$username','$password')";  
    insert($sql);
    
    $sql1 = "select userID from users where username = '$username' and password = '$password'";
    $_SESSION["userID"] = get_object($sql1)->userID;// get userID
}

//log-in
function is_user_exist($username, $password) {
    
    $username = addslashes($username);
    $password = addslashes($password);

    $password = crypt($password, "Testing"); // Salt the password.
    $password = sha1($password);
 
    $sql = "select count(*) as total_rows from users where username = '$username' and password = '$password'";
    $count = get_object($sql)->total_rows;
    
    if ($count > 0){    
        $sql = "select userID from users where username = '$username' and password = '$password'";
        $_SESSION["userID"] = get_object($sql)->userID;// get userID
        return true;
    }
    
    else{
        return false;
    }
}

//function getUserId($username){
   // $sql= "select userID from users where UserName='$username'";
  //  $_SESSION["userID"] = get_object($sql)->userID;
//}   

//CRUD
function getVideos(){
    $userID=$_SESSION["userID"];
    $sql = "SELECT * from videos where userID=$userID";
    
    $dbVideos = select($sql);
    foreach ($dbVideos as $v) {
        $categoryID=$v->categoryID;
        $category="select categoryName from category where categoryID='$categoryID'";
        $name=get_object($category)->categoryName;
        $videosList[] = new Video($v->videoID,$v->title,$v->description,$name,$v->link);
    }
return $videosList;
}

function deleteVideo($id){
    $sql= "delete from videos where videoID=$id";
    delete($sql);
}
//
function updateVideo($title,$description,$categoryName,$videoID){
    //update videos table
    
    //check if there is any data to update
    if ($title!="" && $description!=""){
        $sql="Update videos set title='$title',description='$description' where videoID=$videoID";
        update($sql);
    }
    
    if ($title!="" && $description==""){
        $sql="Update videos set title='$title' where videoID=$videoID";
        update($sql);
    }
    
    if ($title=="" && $description!=""){
        $sql="Update videos set description='$description' where videoID=$videoID";
        update($sql);
    }
     
    //find category id 
    if ($categoryName!="" ){
        $name="select categoryID from category where categoryName='$categoryName'";
    
        //get the category name by the id
        $categoryID=get_object($name)->categoryID;
        //update new video id 
        $sql2="Update videos set categoryID=$categoryID where videoID=$videoID";
        update($sql2);
    }
}

function getCategory(){
    $sql="select categoryName from category";
    $dbCategory = select($sql);
    foreach ($dbCategory as $c) {
        $categoryList[] = $c->categoryName;
    }
return $categoryList;
}

function addVideo($title,$description,$category,$link,$username){
    //server side validation
    if ($title=="" || $category=="" || $link==""){
        echo 'You need to fill title, category & link, so you can add a new video';
    }
    
    else{
        //get userID by user name
        $userID= "select userID from users where userName='$username'";
        $u_id = get_object($userID)->userID;
       
        //get categoryID by category name
        $categoryid ="select categoryID from category where categoryName='$category'";
        $c_id=get_object($categoryid)->categoryID;  
        
        //add the new video
        $sql="insert into videos(title,categoryID,description,link,userID) values ('$title',$c_id,'$description','$link',$u_id)";
        //echo $sql;
        insert($sql);
    }
}

function findText($text){
    $sql="select * from videos where title LIKE '%$text%' or description LIKE '%$text%'";
    $dbSearch = select($sql);
    foreach ($dbSearch as $s) {
        $categoryID=$s->categoryID;
        $category="select categoryName from category where categoryID='$categoryID'";
        $categoryName=get_object($category)->categoryName;
        $videosList[] = new Video($s->videoID,$s->title,$s->description,$categoryName,$s->link);
    }
return $videosList;
}















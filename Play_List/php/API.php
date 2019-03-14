<?php

require_once 'BLL.php';
//require_once "BusinessLogic.php";


$command = $_REQUEST["command"];

switch ($command) {
    
    case "register":
        //server validation
        
        if($_POST["username"]=="" or $_POST["password"]=="" or $_POST["fname"]=="" or $_POST["lname"]==""){
            echo 'Please fill all the fields for registration';
        }
        
        else if(is_username_exist($_POST["username"])) {
                header("Location: http://localhost/Play_List/html/Register.php?error=Username already taken");
        }
        
        else {
            register($_POST["fname"],$_POST["lname"],$_POST["username"], $_POST["password"]);
            $_SESSION["username"] = $_POST["username"];
            header("Location: http://localhost/Play_List/html/save_register.php");
        }
        break;
               
    case "login": 
        if(is_user_exist($_POST["username"], $_POST["password"])) {
                
            $_SESSION["username"]=$_POST["username"];   
            header("Location: http://localhost/Play_List/html/playList.php");
        }
        else
            //echo "User doesn't exsits"; 
            header("Location: http://localhost/Play_List/html/login.php?error=Incorrect username or password");
        break;

    case "logout":  
        session_destroy();
        header("Location: http://localhost/Play_List/html/HomePage.php");
        break;
    
    case "getVideos":
        $videosList=getVideos();
        echo json_encode($videosList);
        break;
    
    case "delete":
        $id=$_GET["id"];
        deleteVideo($id);
        header("location:http://localhost/Play_List/html/save_delete.php");
        break;
        
    
    case "update":
        $title=$_POST["title"];
        $description=$_POST["description"];
        $categoryName=$_POST["categoryName"];
        $id=$_POST["id"];
        updateVideo($title,$description,$categoryName,$id);
        header("location:http://localhost/Play_List/html/save_update.php");
        break;
    
    case "add":
        $title=$_POST["title"];
        $description=$_POST["description"];
        $category=$_POST["category"];
        $link=$_POST["link"];
        $username=$_POST["username"];
        addVideo($title,$description,$category,$link,$username);
        header("location:http://localhost/Play_List/html/save_add.php");
        break;
    
    case "getAllCategories":
        $categoriesList=getCategory();
        echo json_encode($categoriesList);
        break;
    
    
    
    case "search":
        $text=$_GET["text"];
        $videosList=findText($text);
        echo json_encode($videosList);
        break;
}    
        
        
        
 



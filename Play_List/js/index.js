
var ajax;
//call validation to check validity if user exists in data base
function getVideos(){
   
    ajax = new XMLHttpRequest();
    var url = "http://localhost/Play_List/php/API.php?command=getVideos";
    ajax.open("GET", url, true);
    ajax.onreadystatechange = handleResponse;
    ajax.send();
}

//check if search box is not empty, if so sed ajax request for data
function search(){
    var search=document.getElementById("search_line").value;
    
    if (search==""){
        alert("Search box is empty.");
    }
    else{
        ajax = new XMLHttpRequest();
        var url = "http://localhost/Play_List/php/API.php?command=search&text="+search;
        ajax.open("GET", url, true);
        ajax.onreadystatechange = handleResponse;
        ajax.send();
    }
}   

function handleResponse() {
   
    if(ajax.readyState == 4) { // Data returned from the server.
        if(ajax.status == 200) { // There is no error.
            //alert(ajax.responseText);
                var response=JSON.parse(ajax.responseText);
                if(Array.isArray(response)){   
                    createTable(response);
                }
                else {
                    alert(response.message);
                }    
        }
        else { // There is some error...
            alert("Error! Status: " + ajax.status + ", Message: " + ajax.statusText);
        }
    }
}

function createTable(videos) {
      
    var tableVideos = document.getElementById("tableVideos");
    
    var headerTR = "<tr><th class='scope'>ID</th><th class='scope'>Title</th><th class='scope'>Description</th><th class='scope'>CategoryName</th><th></th></tr>";
    
    var tableContent = headerTR;
    tableVideos.innerHTML="";
    for(var i = 0; i < videos.length; i++) {
       
        var videoIDTD = "<td>" + videos[i].videoID + "</td>";
        var titleTD = "<td>" + videos[i].title + "</td>";
        var categoryTD = "<td>" + videos[i].categoryName + "</td>";
        var descriptionTD = "<td>" + videos[i].description + "</td>";
        var buttons= "<td><button><a href='http://localhost/Play_List/html/play.php?video="+videos[i].link+"'>Play</a></button><br>\n\
                      <button><a href='http://localhost/Play_List/html/edit.php?id="+videos[i].videoID+"'>Edit</a></button><br>\n\
                      <button onclick='confirmDelete("+videos[i].videoID+")'>Delete</button></td>";
        
        var videoTR = "<tr>" +videoIDTD + titleTD +descriptionTD+ categoryTD + buttons+"</tr>";
        
        tableContent += videoTR;
        
    }
    tableVideos.innerHTML = tableContent;
}


//show the user the optional categirues from data base:
function getCategory(flag) {
    
    ajax = new XMLHttpRequest(flag);
    
    var url="http://localhost/Play_List/php/API.php?command=getAllCategories";
    ajax.open("GET", url, true);
    if (flag==1){
        ajax.onreadystatechange = selectCategory1;
    }
    if(flag==2){
        ajax.onreadystatechange = selectCategory2;
    }
    
    ajax.send();
}

//ajax for editing
function selectCategory1() {
    
    if (ajax.readyState == 4) {
        if (ajax.status == 200) {
            var categories = JSON.parse(ajax.responseText);
                var selectCategory = document.getElementById("category");
                for (var i = 0; i < categories.length; i++) {
                    var option = document.createElement('option');
                    option.value = categories[i];
                    option.innerHTML = categories[i];
                    selectCategory.appendChild(option);

                }
        }
    }
}

//ajax for adding
function selectCategory2() {
    
    if (ajax.readyState == 4) {
        if (ajax.status == 200) {
            var categories = JSON.parse(ajax.responseText);
                var selectCategory = document.getElementById("categoryAdd");
                for (var i = 0; i < categories.length; i++) {
                    var option = document.createElement('option');
                    option.value = categories[i];
                    option.innerHTML = categories[i];
                    selectCategory.appendChild(option);
                }
        }
    }
}

//messege box to confirm the delete
function confirmDelete(id){
    
    var answer=confirm("Are you sure you want to delete the video?");
    if(answer==true){
        window.location.assign("http://localhost/Play_List/php/API.php?command=delete&id="+id);
    }
}

//all validation client side 

function updateValidation(){
    
    //check if there is any data in the inputs
    var title=document.getElementById("title").value;
    var songDescription=document.getElementById("songDescription").value;
    var category=document.getElementById("category").value;
    
    if(title == "" && songDescription=="" && category==""){
        alert("You didn't fill nothing to update");
        return false;
    }
    else{
        return true;
    }
}

function addValidation(){
   var link=document.getElementById("link").value;
    var category=document.getElementById("categoryAdd").value;
    var title=document.getElementById("title").value;
    
    if(link=="" || category=="" || title==""){
        alert("You must fill the Title, Category & link to add a new video to your play list.");
        return false;
    }    
    
    //validation of the link
    if(!linkVlidation(link)){
        alert("The link is not valid!\nplease check the link.");   
        return false;   
    }    
    return true;
}

function linkVlidation(link){
    if(link.substring(0,17)=='https://youtu.be/'){
        return true;
    }
    return false;
}

function registerValidation(){
    
    var username=document.getElementById("username").value; 
    var password=document.getElementById("password").value; 
    var fname=document.getElementById("fname").value; 
    var lname=document.getElementById("lname").value; 
    if(username=="" ||password==""||fname==""||lname==""){
        alert ("One of the details is missing,\nplease fill all the fields");
        cleanInput();
        return false;
    }
   
    return true;
}

function cleanInput(){
    document.getElementById("username").value="";
    document.getElementById("password").value="";
    document.getElementById("fname").value="";
    document.getElementById("lname").value="";
}


 













<?php

class Video{
        public $title;
        public $categoryName;
        public $description;
        public $videoID;
        public $link;
        
        public function __construct($videoID,$title,$description,$categoryName,$link){
            $this->videoID=$videoID;
            $this->title = $title;
            $this->description=$description;
            $this->categoryName = $categoryName;
            $this->link=$link;
            
            
        }  
        
        
}

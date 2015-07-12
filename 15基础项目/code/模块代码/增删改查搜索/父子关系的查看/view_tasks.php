<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">

    <title>View_tasks</title>
    
</head>

<body>
<?php
/*function make_list($parent) {
    
    // Need the main $tasks array:
    global $tasks;

    echo '<ol>'; // Start an ordered list.
    
    // Loop through each subarray:
	foreach ($parent as $task_id => $todo) {
    
	    // Display the item:
	    echo "<li>$todo";
            
        // Check for subtasks:
		if (isset($tasks[$task_id])) { 
		    // Call this function again:
		    make_list($tasks[$task_id]);
		}
            
        echo '</li>'; // Complete the list item.
    
    } // End of FOREACH loop.
    
    echo '</ol>'; // Close the ordered list.

} // End of make_list() function*/
/*function make_list ($parent){
        global $tasks;
        echo'<ol>';
           
            foreach ($parent as $task_id=>$todo) {
                echo"<li>$todo";
                if (isset($tasks[$task_id])) {
                    make_list($tasks[$task_id]);
                }
                echo'</li>';
            }
        echo'</ol>';
    }

 */
function make_list ($parent,$all=null){
    static $tasks;
    if(isset($all)){
        $tasks=$all;
    }
    echo'<ol>';
        foreach ($parent as $task_id=>$todo) {
            echo"<li>$todo";
            if(isset($tasks[$task_id])){
                make_list($tasks[$task_id]);
            }
            echo'</li>';
        }
        
    echo'</ol>';
    
}
    
    //connect to database
    $dbc=mysqli_connect('localhost','root','xiaolong','xiaoyan');

    $q='select parent_id,task_id,task from tasks order by parent_id,date_added ASC';

    $r=mysqli_query($dbc,$q);
    
   
    while(list($parent_id,$task_id,$task)=mysqli_fetch_array($r,MYSQLI_NUM))   {
        $tasks[$parent_id][$task_id]=$task;
    }
    echo'<pre>';
        print_r($tasks);
    echo'</pre>';
    //make_list($tasks[0]);
    make_list($tasks[0],$tasks);
?>
</body>
</html>

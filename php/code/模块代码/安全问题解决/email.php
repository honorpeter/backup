<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Contact Me</title>
</head>
<body>
<h1>Contact Me</h1>
<?php # Script 13.1 - email.php #2
// This version now scrubs dangerous strings from the submitted input.

// Check for form submission:
if ($_SERVER['REQUEST_METHOD'] == 'POST') {

	/* The function takes one argument: a string.
	* The function returns a clean version of the string.
	* The clean version may be either an empty string or
	* just the removal of all newline characters.
	*/
	function spam_scrubber($value) {

		// List of very bad values:
        //发送邮件不应该有的字符   这些字符 是一些关键字  命令选项
		$very_bad = array('to:', 'cc:', 'bcc:', 'content-type:', 'mime-version:', 'multipart-mixed:', 'content-transfer-encoding:');
	
		// If any of the very bad strings are in 
		// the submitted value, return an empty string:
		foreach ($very_bad as $v) {
			if (stripos($value, $v) !== false) return '';
            //return 为结束函数     直接返回这个函数
            //stripos 函数 查找字符串在 里面没有 有返回 true 
            //如果找到的话 返回一个 空字符窜    结束 函数
		}
	
		// Replace any newline characters with spaces:
		$value = str_replace(array( "\r", "\n", "%0a", "%0d"), ' ', $value);
        //去掉换行符    \r  \n %0a %0d 表示换行符   用空格代替 
        //换行符 可能对邮件造成影响 也可能不会
	
		// Return the value:
		return trim($value);

	} // End of spam_scrubber() function.

	// Clean the form data:
	$scrubbed = array_map('spam_scrubber', $_POST);


	// Minimal form validation:
	if (!empty($scrubbed['name']) && !empty($scrubbed['email']) && !empty($scrubbed['comments']) ) {
	
		// Create the body:
		$body = "Name: {$scrubbed['name']}\n\nComments: {$scrubbed['comments']}";

		// Make it no longer than 70 characters long:
		$body = wordwrap($body, 70);
	
		// Send the email:
		mail('your_email@example.com', 'Contact Form Submission', $body, "From: {$scrubbed['email']}");

		// Print a message:
		echo '<p><em>Thank you for contacting me. I will reply some day.</em></p>';
		
		// Clear $scrubbed (so that the form's not sticky):
		$scrubbed = array();
	
	} else {
		echo '<p style="font-weight: bold; color: #C00">Please fill out the form completely.</p>';
	}
	
} // End of main isset() IF.

// Create the HTML form:
?>
<p>Please fill out this form to contact me.</p>
<form action="email.php" method="post">
	<p>Name: <input type="text" name="name" size="30" maxlength="60" value="<?php if (isset($scrubbed['name'])) echo $scrubbed['name']; ?>" /></p>
	<p>Email Address: <input type="text" name="email" size="30" maxlength="80" value="<?php if (isset($scrubbed['email'])) echo $scrubbed['email']; ?>" /></p>
	<p>Comments: <textarea name="comments" rows="5" cols="30"><?php if (isset($scrubbed['comments'])) echo $scrubbed['comments']; ?></textarea></p>
	<p><input type="submit" name="submit" value="Send!" /></p>
</form>
</body>
</html>

<?php

$dbconn = pg_connect("host=localhost dbname=vanilla user=postgres password=postgres") or die('Could not connect: ' . pg_last_error());

$action = $_REQUEST['action'];

if (isset($action) && $action == "create") {
	$title = $_POST['title'];
	$body = $_POST['body'];
	if (isset($title) && isset($body)) {
		pg_prepare('ins_post', "INSERT INTO posts(title, body) VALUES($1, $2);");
		pg_execute('ins_post', array($title, $body)) or die('Query failed: ' . pg_last_error());
		echo "Post Added! <a href='/index.php'>Return</a>";
	} else {
		echo "No Values Provided";
	}
}

if (isset($action) && $action == "save" && $_POST['delete']) {
	$id = $_POST['id'];
	if (isset($id)) {
		$res = pg_delete($dbconn, 'posts', array("id" => $id));
		if ($res) {
			echo "Post Deleted! <a href='/index.php'>Return</a>";
		}
	} else {
		echo "No Values Provided";
	}
}

if (isset($action) && $action == "save" && !$_POST['delete']) {
	$id = $_POST['id'];
	$title = $_POST['title'];
	$body = $_POST['body'];
	if (isset($title) && isset($body) && isset($id)) {
		pg_prepare('update_post', "UPDATE posts SET(title, body) = ($2, $3) WHERE id = $1;") or die('Query failed: ' . pg_last_error());
		pg_execute('update_post', array($id, $title, $body)) or die('Query failed: ' . pg_last_error());
		echo "Post Updated! <a href='/index.php'>Return</a>";
	} else {
		echo "No Values Provided";
	}
}

if (isset($action) && $action == "edit") {
	$id = $_GET['id'];
	$result = pg_query_params($dbconn, "SELECT * FROM posts WHERE id = $1", array($id));
	$row = pg_fetch_assoc($result);
?>
<form method="post" action="updates.php">
<input type="hidden" name="action" value="save">
<input type="hidden" name="id" value="<?php echo "$id" ?>">
<table>
	<tr>
	<td colspan=2><b>Edit Post</b></td>
	</tr>
	<tr>
	<td>Title:</td>
	<td><input type="text" size=20 name="title" value="<?php echo $row['title'] ?>"></td>
	</tr>
	<tr>
	<td>Body:</td>
	<td><textarea rows=5 cols=20 name="body"><?php echo $row['body'] ?></textarea></td>
	</tr>
	<tr>
	<td></td>
	<td><input type="submit" value="Save Post"> <input type="submit" name="delete" value="Delete Post"></td>
	</tr>
</table>
</form>
<?php
}
?>
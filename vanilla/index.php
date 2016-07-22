<form method="post" action="updates.php">
<input type="hidden" name="action" value="create">
<table>
	<tr>
	<td colspan=2><b>Create a New Post</b></td>
	</tr>
	<tr>
	<td>Title:</td>
	<td><input type="text" size=20 name="title"></td>
	</tr>
	<tr>
	<td>Body:</td>
	<td><textarea rows=5 cols=20 name="body"></textarea></td>
	</tr>
	<tr>
	<td></td>
	<td><input type="submit" value="Create Post"></td>
	</tr>
</table>
</form>

<hr>
<b>Posts:</b>
<?php
$dbconn = pg_connect("host=localhost dbname=vanilla user=postgres password=postgres") or die('Could not connect: ' . pg_last_error());

$result = pg_query($dbconn, "SELECT * FROM posts");

while($row=pg_fetch_assoc($result)) {
	echo "<p>Title: ";
	echo "<a href='/newsite/posts/". $row['id'] ."/edit'>" . $row['title'] . "</a><br/>";
	echo "Body: ";
	echo $row['body'] . "</p>";
	
}
echo "</table>";               
?>
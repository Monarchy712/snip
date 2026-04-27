[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

while ($true) {

Clear-Host

Write-Host ""
Write-Host "  +======================================================+" -ForegroundColor Cyan
Write-Host "  |              Exam Snippet Picker                     |" -ForegroundColor Cyan
Write-Host "  +======================================================+" -ForegroundColor Cyan
Write-Host ""
Write-Host "   [1] PHP - Count Character Frequency"
Write-Host "   [2] PHP - Reverse String"
Write-Host "   [3] PHP - Palindrome Check"
Write-Host "   [4] PHP - Form Input (`$_POST)"
Write-Host "   [5] PHP - Insert into MySQL"
Write-Host "   [6] PHP - Fetch from MySQL (Login)"
Write-Host ""
Write-Host "   [7] JS - onclick Alert"
Write-Host "   [8] JS - Prompt Input + Even/Odd"
Write-Host "   [9] JS - Reverse String"
Write-Host "   [10] JS - Palindrome"
Write-Host "   [11] JS - Factorial"
Write-Host ""
Write-Host "   [12] PHP - All Loops"
Write-Host "   [13] JS - All Loops"
Write-Host "   [14] PHP - Student Form (Insert + Display)"
Write-Host ""

$choice = Read-Host "  Enter choice (1-14)"

switch ($choice) {

# ---------------- PHP ----------------

"1" {
$code = @"
<?php
$str = "hello";
$freq = [];

for ($i = 0; $i < strlen($str); $i++) {
    $ch = $str[$i];
    if (isset($freq[$ch])) $freq[$ch]++;
    else $freq[$ch] = 1;
}

foreach ($freq as $k => $v) {
    echo "$k => $v <br>";
}
?>
"@
}

"2" {
$code = @"
<?php
$str = "hello";
echo strrev($str);
?>
"@
}

"3" {
$code = @"
<?php
$str = "madam";

if ($str == strrev($str)) {
    echo "Palindrome";
} else {
    echo "Not Palindrome";
}
?>
"@
}

"4" {
$code = @"
<?php
$name = $_POST['name'];
echo "Hello " . $name;
?>
"@
}

"5" {
$code = @"
<?php
$conn = new mysqli("localhost", "root", "", "test");

$name = $_POST['name'];

$sql = "INSERT INTO users(name) VALUES('$name')";
$conn->query($sql);

echo "Inserted successfully";
?>
"@
}

"6" {
$code = @"
<?php
$conn = new mysqli("localhost", "root", "", "test");

$email = $_POST['email'];
$password = $_POST['password'];

$sql = "SELECT * FROM users WHERE email='$email' AND password='$password'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "Login success";
} else {
    echo "Invalid";
}
?>
"@
}

# ---------------- JAVASCRIPT ----------------

"7" {
$code = @"
<button onclick="show()">Click</button>

<script>
function show() {
    alert("Hello");
}
</script>
"@
}

"8" {
$code = @"
<script>
let num = prompt("Enter number");

if (num % 2 == 0)
    alert("Even");
else
    alert("Odd");
</script>
"@
}

"9" {
$code = @"
<script>
let str = "hello";
let rev = "";

for (let i = str.length - 1; i >= 0; i--) {
    rev += str[i];
}

alert(rev);
</script>
"@
}

"10" {
$code = @"
<script>
let str = prompt("Enter string");
let rev = str.split("").reverse().join("");

if (str == rev)
    alert("Palindrome");
else
    alert("Not Palindrome");
</script>
"@
}

"11" {
$code = @"
<script>
let n = 5, fact = 1;

for (let i = 1; i <= n; i++) {
    fact *= i;
}

alert(fact);
</script>
"@
}

# ---------------- LOOPS ----------------

"12" {
$code = @"
<?php

echo "FOR LOOP<br>";
for ($i = 1; $i <= 5; $i++) {
    echo $i . "<br>";
}

echo "<br>WHILE LOOP<br>";
$i = 1;
while ($i <= 5) {
    echo $i . "<br>";
    $i++;
}

echo "<br>DO-WHILE LOOP<br>";
$i = 1;
do {
    echo $i . "<br>";
    $i++;
} while ($i <= 5);

echo "<br>FOREACH LOOP<br>";
$arr = array("A", "B", "C");

foreach ($arr as $val) {
    echo $val . "<br>";
}

?>
"@
}

"13" {
$code = @"
<script>

document.write("FOR LOOP<br>");
for (let i = 1; i <= 5; i++) {
    document.write(i + "<br>");
}

document.write("<br>WHILE LOOP<br>");
let i = 1;
while (i <= 5) {
    document.write(i + "<br>");
    i++;
}

document.write("<br>DO-WHILE LOOP<br>");
i = 1;
do {
    document.write(i + "<br>");
    i++;
} while (i <= 5);

document.write("<br>FOR...OF LOOP<br>");
let arr = ["A", "B", "C"];
for (let val of arr) {
    document.write(val + "<br>");
}

document.write("<br>FOR...IN LOOP<br>");
let obj = {a:1, b:2, c:3};
for (let key in obj) {
    document.write(key + " => " + obj[key] + "<br>");
}

</script>
"@
}

"14" {
$code = @"
<?php
$conn = new mysqli("localhost", "root", "", "college_db");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name  = $_POST['name'];
    $email = $_POST['email'];
    $marks = $_POST['marks'];

    if (!empty($name) && !empty($email) && is_numeric($marks)) {
        $stmt = $conn->prepare("INSERT INTO students (name, email, marks) VALUES (?, ?, ?)");
        $stmt->bind_param("ssi", $name, $email, $marks);
        $stmt->execute();
        $stmt->close();
        echo "Inserted successfully<br>";
    }
}

$result = $conn->query("SELECT * FROM students ORDER BY id DESC");
?>

<form method="POST">
    <input type="text" name="name" placeholder="Name"><br>
    <input type="email" name="email" placeholder="Email"><br>
    <input type="number" name="marks" placeholder="Marks"><br>
    <button type="submit">Submit</button>
</form>

<table border="1">
<tr><th>ID</th><th>Name</th><th>Email</th><th>Marks</th></tr>

<?php
while ($row = $result->fetch_assoc()) {
    echo "<tr>
        <td>{$row['id']}</td>
        <td>{$row['name']}</td>
        <td>{$row['email']}</td>
        <td>{$row['marks']}</td>
    </tr>";
}
?>

</table>
"@
}

default {
    Write-Host "Invalid choice" -ForegroundColor Red
    Start-Sleep -Seconds 1
    continue
}
}

# Clipboard
if (Get-Command Set-Clipboard -ErrorAction SilentlyContinue) {
    $code | Set-Clipboard
    Write-Host ""
    Write-Host "  OK copied to clipboard!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "Clipboard not supported. Showing code below:" -ForegroundColor Yellow
    Write-Host $code
}

$again = Read-Host "`nDo you want another snippet? (y/n)"
if ($again -ne "y") { break }

}

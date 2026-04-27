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
Write-Host "   [15] HTML - User Registration Form"
Write-Host "   [16] HTML - Seminar Invite Form"
Write-Host ""

$choice = Read-Host "  Enter choice (1-16)"

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
<input type="text" name="name"><br>
<input type="email" name="email"><br>
<input type="number" name="marks"><br>
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

# ---------------- NEW ----------------

"15" {
$code = @"
<!DOCTYPE html>
<html>
<head>
    <title>User Form</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
        }
        .card {
            width: 420px;
            margin: 60px auto;
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            font-size: 14px;
            font-weight: 600;
        }
        input, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            margin-bottom: 14px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        .row {
            margin-bottom: 10px;
        }
        .gender {
            display: flex;
            gap: 15px;
            margin: 8px 0 15px;
        }
        button {
            width: 100%;
            padding: 12px;
            background: #4facfe;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background: #3a8be0;
        }
        .error {
            color: red;
            font-size: 13px;
            text-align: center;
        }
        .success {
            color: green;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="card">
    <h2>User Registration</h2>

    <div id="msg"></div>

    <label>Full Name</label>
    <input type="text" id="name">

    <label>Email Address</label>
    <input type="text" id="email">

    <label>Phone Number</label>
    <input type="text" id="phone">

    <label>Gender</label>
    <div class="gender">
        <label><input type="radio" name="g" value="Male"> Male</label>
        <label><input type="radio" name="g" value="Female"> Female</label>
    </div>

    <label>Address</label>
    <textarea id="addr"></textarea>

    <button onclick="validateForm()">Submit</button>
</div>

<script>
function validateForm() {
    let name = document.getElementById("name").value.trim();
    let email = document.getElementById("email").value.trim();
    let phone = document.getElementById("phone").value.trim();
    let addr = document.getElementById("addr").value.trim();
    let gender = document.getElementsByName("g");
    let gval = "";

    for (let i = 0; i < gender.length; i++) {
        if (gender[i].checked) gval = gender[i].value;
    }

    let emailPattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;
    let phonePattern = /^[0-9]{10}$/;

    if (name === "" || email === "" || phone === "" || addr === "" || gval === "") {
        showMsg("Please fill all fields", "error");
        return;
    }

    if (!emailPattern.test(email)) {
        showMsg("Enter valid email", "error");
        return;
    }

    if (!phonePattern.test(phone)) {
        showMsg("Phone must be 10 digits", "error");
        return;
    }

    showMsg("Form submitted successfully", "success");
}

function showMsg(text, type) {
    let box = document.getElementById("msg");
    box.className = type;
    box.innerHTML = text;
}
</script>

</body>
</html>
"@
}

"16" {
$code = @"
<!DOCTYPE html>
<html>
<head>
    <title>Seminar Invite</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #eef2f7;
        }
        .title {
            text-align: center;
            margin-top: 30px;
        }
        .title h1 {
            margin: 5px;
        }
        table {
            margin: 30px auto;
            border-collapse: collapse;
            width: 60%;
            background: white;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ccc;
            text-align: center;
        }
        th {
            background: #4facfe;
            color: white;
        }
        .formbox {
            width: 420px;
            margin: 30px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        input, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            margin-bottom: 14px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        button {
            width: 100%;
            padding: 12px;
            background: #4facfe;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background: #3a8be0;
        }
    </style>
</head>
<body>

<div class="title">
    <h1>Indian Institute Of Information Technology, Nagpur</h1>
    <p>Seminar Invitation Program</p>
</div>

<table>
    <tr>
        <th>Expert</th>
        <th>Time</th>
    </tr>
    <tr>
        <td>Prof. Ruchira Selote</td>
        <td>10:00 AM</td>
    </tr>
    <tr>
        <td>Prof. Prasad Joshi</td>
        <td>12:00 PM</td>
    </tr>
    <tr>
        <td>Prof. Santosh Sahu</td>
        <td>2:00 PM</td>
    </tr>
</table>

<div class="formbox">
    <input type="text" id="name" placeholder="Name (max 20 chars)">
    <textarea id="addr" placeholder="Address"></textarea>
    <input type="text" id="email" placeholder="Email">
    <input type="password" id="pass" placeholder="Password">
    <input type="text" id="phone" placeholder="Phone">
    <input type="date" id="dob">

    <button onclick="check()">Register</button>
</div>

<script>
function check() {
    let name = document.getElementById("name").value.trim();
    let email = document.getElementById("email").value.trim();
    let pass = document.getElementById("pass").value;
    let phone = document.getElementById("phone").value;
    let dob = document.getElementById("dob").value;

    let emailReg = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;
    let passReg = /^(?=.*[!@#$%^&*])(?=.*[A-Za-z0-9]).{8,}$/;

    if (name.length > 20) {
        alert("Name should be max 20 characters");
        return;
    }

    if (!emailReg.test(email)) {
        alert("Invalid Email");
        return;
    }

    if (!passReg.test(pass)) {
        alert("Password must be 8+ chars with special character");
        return;
    }

    if (!/^[0-9]{10}$/.test(phone)) {
        alert("Enter valid 10 digit phone");
        return;
    }

    let birth = new Date(dob);
    let today = new Date();
    let age = today.getFullYear() - birth.getFullYear();

    if (age < 15) {
        alert("Participants must be above 15");
        return;
    }

    alert("Registration Successful");
}
</script>

</body>
</html>
"@
}

default {
    Write-Host "Invalid choice" -ForegroundColor Red
    Start-Sleep -Seconds 1
    continue
}
}

# Clipboard stays SAME
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

<?php
include("db/connect.php");
session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = $_POST['name'];
    $address = $_POST['address'];
    $contact = $_POST['contact'];
    $member_type = $_POST['member_type'];
    $password = $_POST['password'];
    $confirm = $_POST['confirm_password'];

    if ($password != $confirm) {
        echo "<script>alert('Passwords do not match!');</script>";
    } else {
        // Hash password
        $hashed = password_hash($password, PASSWORD_DEFAULT);

        // Insert into member table
        $sql = "INSERT INTO member (name, address, contact_no, member_type, password) 
                VALUES ('$name','$address','$contact','$member_type','$hashed')";

        if (mysqli_query($conn, $sql)) {
            // Get auto-generated member_id
            $member_id = mysqli_insert_id($conn);
            echo "<script>
                    alert('Signup successful! Your Member ID is: $member_id. Use it to log in.');
                    window.location.href='index.html';
                  </script>";
        } else {
            echo "Error: " . mysqli_error($conn);
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Member Sign Up</title>
    <link rel="stylesheet" href="log.css">
</head>
<body>
    <div class="login">
        <form action="signup.php" method="post">
            <h1>Sign Up</h1>

            <label for="name">Full Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="address">Address:</label>
            <input type="text" id="address" name="address" required>

            <label for="contact">Contact Number:</label>
            <input type="text" id="contact" name="contact" required>

            <label for="member_type">Member Type:</label>
            <select name="member_type" id="member_type" required>
                <option value="">Select</option>
                <option value="Student">Student</option>
                <option value="Teacher">Teacher</option>
            </select>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <label for="confirm_password">Confirm Password:</label>
            <input type="password" id="confirm_password" name="confirm_password" required>

            <button type="submit">Sign Up</button>

            <h4>Already have an account? <a href="index.html" class="signupbtn">Log In</a></h4>
        </form>
    </div>
</body>
</html>

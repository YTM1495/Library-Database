<?php
session_start();
include("db/connect.php");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $role = $_POST['role'];
    $input_id = $_POST['username']; // This is member_id or librarian_id
    $input_password = $_POST['password'];

    if ($role == 'member') {
        $stmt = $conn->prepare("SELECT member_id, password FROM MEMBER WHERE member_id=?");
    } else {
        $stmt = $conn->prepare("SELECT librarian_id, lib_pass FROM LIBRARIAN WHERE librarian_id=?");
    }

    $stmt->bind_param("i", $input_id);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows > 0) {
        if ($role == 'member') {
            $stmt->bind_result($id, $db_password);
        } else {
            $stmt->bind_result($id, $db_password);
        }
        $stmt->fetch();

        // Check password
        if (password_verify($input_password, $db_password)) {
            $_SESSION['username'] = $id;
            $_SESSION['role'] = $role;

            if ($role == 'member') {
                header("Location: dashboard-member.php");
            } else {
                header("Location: dashboard-librarian.php");
            }
            exit();
        } else {
            echo "<script>alert('Invalid Password'); window.location.href='index.html';</script>";
        }
    } else {
        echo "<script>alert('User not found'); window.location.href='index.html';</script>";
    }
    $stmt->close();
}
?>

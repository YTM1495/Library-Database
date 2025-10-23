<?php
session_start();
include("db/connect.php");

if (!isset($_SESSION['username']) || $_SESSION['role'] != 'member') {
    header("Location: index.html");
    exit();
}

$member_id = $_SESSION['username'];
$member_name = '';
$member_type = '';

// Fetch member details
$stmt = $conn->prepare("SELECT name, member_type FROM MEMBER WHERE member_id=?");
$stmt->bind_param("i", $member_id);
$stmt->execute();
$stmt->bind_result($member_name, $member_type);
$stmt->fetch();
$stmt->close();

// Handle Return Book
if (isset($_POST['return_book'])) {
    $book_id = $_POST['book_id'];
    $return_date = date('Y-m-d');
    $stmt = $conn->prepare("CALL return_book(?, ?, ?)");
    $stmt->bind_param("iis", $member_id, $book_id, $return_date);
    $stmt->execute();
    $stmt->close();
    echo "<script>alert('Book returned successfully!'); window.location.href='dashboard-member.php';</script>";
}

// Handle Pay Fine
if (isset($_POST['pay_fine'])) {
    $fine_id = $_POST['fine_id'];
    $stmt = $conn->prepare("CALL pay_fine(?, ?)");
    $stmt->bind_param("ii", $member_id, $fine_id);
    $stmt->execute();
    $stmt->close();
    echo "<script>alert('Fine paid successfully!'); window.location.href='dashboard-member.php';</script>";
}

// Handle Take Book
if (isset($_POST['take_book'])) {
    $book_id = $_POST['book_id'];
    $librarian_id = $_POST['librarian_id'];
    $stmt = $conn->prepare("CALL take_book((SELECT book_name FROM BOOKS WHERE book_id=?), ?, ?, ?)");
    $stmt->bind_param("iiii", $book_id, $book_id, $librarian_id, $member_id);
    $stmt->execute();
    $stmt->close();
    echo "<script>alert('Book issued successfully!'); window.location.href='dashboard-member.php';</script>";
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Member Dashboard</title>
    <link rel="stylesheet" href="log.css">
</head>
<body>
<h2>Welcome, <?php echo $member_name; ?></h2>
<p>Member Type: <?php echo $member_type; ?></p>
<hr>

<h3>Borrowed Books</h3>
<table border="1" cellpadding="5">
<tr>
    <th>Book Name</th>
    <th>Borrow Date</th>
    <th>Return Date</th>
    <th>Action</th>
</tr>
<?php
$result = $conn->query("SELECT b.book_id, b.book_name, bo.borrow_date, bo.return_date 
                        FROM BORROWS bo 
                        JOIN BOOKS b ON bo.book_id=b.book_id
                        WHERE bo.member_id=$member_id");

while ($row = $result->fetch_assoc()) {
    echo "<tr>";
    echo "<td>{$row['book_name']}</td>";
    echo "<td>{$row['borrow_date']}</td>";
    echo "<td>{$row['return_date']}</td>";
    echo "<td>";
    if (is_null($row['return_date'])) {
        echo "<form method='post' style='display:inline;'>
                <input type='hidden' name='book_id' value='{$row['book_id']}'>
                <button type='submit' name='return_book'>Return</button>
              </form>";
    } else {
        echo "Returned";
    }
    echo "</td></tr>";
}
?>
</table>

<h3>Fines</h3>
<table border="1" cellpadding="5">
<tr>
    <th>Fine ID</th>
    <th>Amount</th>
    <th>Status</th>
    <th>Action</th>
</tr>
<?php
$result = $conn->query("SELECT fine_id, amount, status FROM FINE WHERE member_id=$member_id");
while ($row = $result->fetch_assoc()) {
    echo "<tr>";
    echo "<td>{$row['fine_id']}</td>";
    echo "<td>{$row['amount']}</td>";
    echo "<td>{$row['status']}</td>";
    echo "<td>";
    if ($row['status'] != 'Cleared') {
        echo "<form method='post' style='display:inline;'>
                <input type='hidden' name='fine_id' value='{$row['fine_id']}'>
                <button type='submit' name='pay_fine'>Pay Fine</button>
              </form>";
    } else {
        echo "Paid";
    }
    echo "</td></tr>";
}
?>
</table>

<h3>All Books</h3>
<table border="1" cellpadding="5">
<tr>
    <th>Book ID</th>
    <th>Name</th>
    <th>Stock</th>
    <th>Librarian ID</th>
    <th>Action</th>
</tr>
<?php
$result = $conn->query("SELECT b.book_id, b.book_name, b.no_of_stock, l.librarian_id 
                        FROM BOOKS b 
                        JOIN ISSUED_BY l ON b.book_id=l.book_id");

while ($row = $result->fetch_assoc()) {
    echo "<tr>";
    echo "<td>{$row['book_id']}</td>";
    echo "<td>{$row['book_name']}</td>";
    echo "<td>{$row['no_of_stock']}</td>";
    echo "<td>{$row['librarian_id']}</td>";
    echo "<td>";
    if ($row['no_of_stock'] > 0) {
        echo "<form method='post' style='display:inline;'>
                <input type='hidden' name='book_id' value='{$row['book_id']}'>
                <input type='hidden' name='librarian_id' value='{$row['librarian_id']}'>
                <button type='submit' name='take_book'>Take Book</button>
              </form>";
    } else {
        echo "Out of Stock";
    }
    echo "</td></tr>";
}
?>
</table>

<h3>Most Popular Authors</h3>
<table border="1" cellpadding="5">
<tr>
    <th>Author Name</th>
    <th>Total Borrows</th>
</tr>
<?php
$result = $conn->query("CALL most_popular_authors()");
while ($row = $result->fetch_assoc()) {
    echo "<tr>";
    echo "<td>{$row['author_name']}</td>";
    echo "<td>{$row['total_borrows']}</td>";
    echo "</tr>";
}
$conn->next_result(); // Important to free the CALL
?>
</table>

<br>
<a href="logout.php">Logout</a>
</body>
</html>

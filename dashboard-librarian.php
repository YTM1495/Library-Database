<?php
session_start();
include("db/connect.php");

// Check if librarian is logged in
if (!isset($_SESSION['username']) || $_SESSION['role'] != 'librarian') {
    header("Location: index.html");
    exit();
}

$librarian_id = $_SESSION['username']; // assuming username = librarian_id
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Librarian Dashboard</title>
    <link rel="stylesheet" href="log.css">
</head>
<body>
    <h2>Welcome, Librarian ID: <?php echo $librarian_id; ?></h2>
    <a href="logout.php">Logout</a>

    <!-- Books Issued Today -->
    <h3>Books Issued Today</h3>
    <form method="post">
        <input type="date" name="issue_date" required>
        <button type="submit" name="show_issued">Show</button>
    </form>

    <?php
    if (isset($_POST['show_issued'])) {
        $date = $_POST['issue_date'];
        $stmt = $conn->prepare("CALL books_issued_in_a_day(?)");
        $stmt->bind_param("s", $date);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            echo "<table border='1'>
                    <tr>
                        <th>Book ID</th>
                        <th>Book Name</th>
                        <th>Author</th>
                        <th>Member Name</th>
                        <th>Librarian Name</th>
                        <th>Issue Date</th>
                    </tr>";
            while ($row = $result->fetch_assoc()) {
                echo "<tr>
                        <td>{$row['book_id']}</td>
                        <td>{$row['book_name']}</td>
                        <td>{$row['author_name']}</td>
                        <td>{$row['member_name']}</td>
                        <td>{$row['librarian_name']}</td>
                        <td>{$row['issue_date']}</td>
                      </tr>";
            }
            echo "</table>";
        } else {
            echo "No books issued on this date.";
        }
        $stmt->close();
        $conn->next_result(); // Important for multiple stored procedures
    }
    ?>

    <!-- New Members -->
    <h3>New Members</h3>
    <?php
    $result = $conn->query("SELECT * FROM member ORDER BY member_id DESC LIMIT 15");
    if ($result->num_rows > 0) {
        echo "<table border='1'>
                <tr>
                    <th>Member ID</th>
                    <th>Name</th>
                    <th>Type</th>
                    <th>Address</th>
                    <th>Contact No</th>
                </tr>";
        while ($row = $result->fetch_assoc()) {
            echo "<tr>
                    <td>{$row['member_id']}</td>
                    <td>{$row['name']}</td>
                    <td>{$row['member_type']}</td>
                    <td>{$row['address']}</td>
                    <td>{$row['contact_no']}</td>
                  </tr>";
        }
        echo "</table>";
    }
    ?>

    <!-- Display Books -->
    <h3>Books</h3>
    <?php
    $result = $conn->query("CALL display_books()");
    if ($result) {
        echo "<table border='1'>
                <tr>
                    <th>Book ID</th>
                    <th>Name</th>
                    <th>Stock</th>
                </tr>";
        while ($row = $result->fetch_assoc()) {
            echo "<tr>
                    <td>{$row['book_id']}</td>
                    <td>{$row['book_name']}</td>
                    <td>{$row['no_of_stock']}</td>
                  </tr>";
        }
        echo "</table>";
        $conn->next_result();
    }
    ?>

    <!-- Remove Member -->
    <h3>Remove Member</h3>
    <form method="post">
        <input type="number" name="remove_member_id" placeholder="Member ID" required>
        <button type="submit" name="remove_member">Remove</button>
    </form>
    <?php
    if (isset($_POST['remove_member'])) {
        $mid = $_POST['remove_member_id'];
        $stmt = $conn->prepare("CALL remove_member(?)");
        $stmt->bind_param("i", $mid);
        if ($stmt->execute()) {
            echo "<p>Member $mid removed successfully.</p>";
        } else {
            echo "<p>Error removing member.</p>";
        }
        $stmt->close();
        $conn->next_result();
    }
    ?>

    <!-- Members with Unpaid Fines or Books Due -->
    <h3>Members with Unpaid Fines or Books Due</h3>
    <?php
    $result = $conn->query("CALL members_with_unpaid_fines_and_books()");
    if ($result) {
        echo "<table border='1'>
                <tr>
                    <th>Member ID</th>
                    <th>Name</th>
                    <th>Fine Amount</th>
                    <th>Fine Status</th>
                    <th>Book Name</th>
                    <th>Borrow Date</th>
                    <th>Return Date</th>
                </tr>";
        while ($row = $result->fetch_assoc()) {
            echo "<tr>
                    <td>{$row['member_id']}</td>
                    <td>{$row['member_name']}</td>
                    <td>{$row['fine_amount']}</td>
                    <td>{$row['fine_status']}</td>
                    <td>{$row['book_name']}</td>
                    <td>{$row['borrow_date']}</td>
                    <td>{$row['return_date']}</td>
                  </tr>";
        }
        echo "</table>";
        $conn->next_result();
    }
    ?>

    <!-- Most Popular Authors -->
    <h3>Most Popular Authors</h3>
    <?php
    $result = $conn->query("CALL most_popular_authors()");
    if ($result) {
        echo "<table border='1'>
                <tr>
                    <th>Author Name</th>
                    <th>Total Borrows</th>
                </tr>";
        while ($row = $result->fetch_assoc()) {
            echo "<tr>
                    <td>{$row['author_name']}</td>
                    <td>{$row['total_borrows']}</td>
                  </tr>";
        }
        echo "</table>";
        $conn->next_result();
    }
    ?>

    <!-- Monthly Borrow Summary -->
    <h3>Monthly Borrow Summary</h3>
    <form method="post">
        <input type="number" name="month" placeholder="Month (1-12)" required>
        <input type="number" name="year" placeholder="Year (e.g., 2025)" required>
        <button type="submit" name="show_summary">Show</button>
    </form>
    <?php
    if (isset($_POST['show_summary'])) {
        $month = $_POST['month'];
        $year = $_POST['year'];
        $stmt = $conn->prepare("CALL MONTHLY_BORROWING_SUMMARY(?, ?)");
        $stmt->bind_param("ii", $month, $year);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            echo "<table border='1'>
                    <tr>
                        <th>Month</th>
                        <th>Year</th>
                        <th>Total Books Borrowed</th>
                        <th>Total Members</th>
                        <th>Unique Books</th>
                    </tr>";
            while ($row = $result->fetch_assoc()) {
                echo "<tr>
                        <td>{$row['borrow_month']}</td>
                        <td>{$row['borrow_year']}</td>
                        <td>{$row['total_books_borrowed']}</td>
                        <td>{$row['total_members']}</td>
                        <td>{$row['unique_books']}</td>
                      </tr>";
            }
            echo "</table>";
        } else {
            echo "<p>No data for this month/year.</p>";
        }

        $stmt->close();
        $conn->next_result();
    }
    ?>
</body>
</html>

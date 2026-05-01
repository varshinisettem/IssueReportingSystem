<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 🔐 SESSION CHECK
    String user = (String) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.html");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Home Dashboard</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI';
            background: #f2f2f2;
        }

        /* NAV BAR */
        .nav {
            background: #4a69bd;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            color: white;
            align-items: center;
        }

        .nav-left {
            font-weight: bold;
            font-size: 18px;
        }

        .nav-right a {
            color: white;
            text-decoration: none;
            margin: 0 12px;
            font-weight: 500;
        }

        .nav-right a:hover {
            text-decoration: underline;
        }

        /* ADMIN BUTTON STYLE */
        .admin-btn {
            background: red;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            border: none;
            color: white;
            font-weight: bold;
        }

        /* MAIN CONTENT */
        .container {
            text-align: center;
            margin-top: 80px;
        }

        h1 {
            color: #333;
        }

        .card {
            display: inline-block;
            background: white;
            padding: 25px;
            margin: 15px;
            border-radius: 12px;
            width: 200px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .card a {
            text-decoration: none;
            color: #4a69bd;
            font-weight: bold;
        }

        /* ADMIN LOGIN BOX */
        .admin-box {
            margin-top: 40px;
            background: white;
            display: inline-block;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        input {
            padding: 8px;
            margin: 5px;
            width: 180px;
        }

        button {
            padding: 8px 15px;
            background: red;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        button:hover {
            background: darkred;
        }
    </style>

</head>

<body>

<!-- NAVBAR -->
<div class="nav">
    <div class="nav-left">
        Issue Reporting System
    </div>

    <div class="nav-right">
        <a href="home.jsp">Home</a>
        <a href="complaint.jsp">Complaint</a>
        <a href="view_status.jsp">Status</a>
		<a href="admin_login.html">Admin</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<!-- MAIN DASHBOARD -->
<div class="container">

    <h1>Issue Reporting System</h1>
    <p>Report problems. Track status. Resolve efficiently.</p>

</div>



</body>
</html>
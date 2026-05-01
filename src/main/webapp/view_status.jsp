<%@ page import="java.sql.*, com.db.DB" %>

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
    <title>Complaint Status</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Segoe UI';
            background: #f2f2f2;
        }

        .container {
            width: 80%;
            margin: 50px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th {
            background: #4a69bd;
            color: white;
            padding: 10px;
        }

        td {
            padding: 10px;
            text-align: center;
        }

        .pending {
            color: orange;
            font-weight: bold;
        }

        .resolved {
            color: green;
            font-weight: bold;
        }
    </style>

</head>

<body>

<div class="container">

<h2>Your Complaint Status</h2>

<table>
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Description</th>
        <th>Status</th>
        <th>Date</th>
    </tr>

<%
    try {
        Connection con = DB.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM complaints WHERE user_email=? ORDER BY id DESC"
        );

        ps.setString(1, user);

        ResultSet rs = ps.executeQuery();

        while(rs.next()) {
%>

    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("title") %></td>
        <td><%= rs.getString("description") %></td>

        <td>
            <%
                String status = rs.getString("status");
                if(status.equalsIgnoreCase("Resolved")) {
            %>
                <span class="resolved"><%= status %></span>
            <%
                } else {
            %>
                <span class="pending"><%= status %></span>
            <%
                }
            %>
        </td>

        <td><%= rs.getTimestamp("created_at") %></td>
    </tr>

<%
        }

    } catch(Exception e) {
        e.printStackTrace();
    }
%>

</table>

</div>

</body>
</html>
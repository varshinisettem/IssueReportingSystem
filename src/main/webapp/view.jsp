<%@ page import="java.sql.*" %>

<%
String admin = (String) session.getAttribute("admin");
if (admin == null) {
    response.sendRedirect("admin_login.html");
    return;
}
%>

<html>
<head>
<title>Admin Dashboard</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
body {
    font-family: Arial;
    margin: 0;
    background: #f4f6f9;
}

.header {
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    padding: 15px;
    text-align: center;
    font-size: 22px;
}

.table-container {
    overflow-x: auto;
    padding: 10px;
}

table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    min-width: 700px;
}

th, td {
    padding: 10px;
    border: 1px solid #ddd;
    text-align: center;
}

th {
    background: #667eea;
    color: white;
}

.pending { color: orange; font-weight: bold; }
.resolved { color: green; font-weight: bold; }

button {
    padding: 5px 10px;
    border: none;
    background: #28a745;
    color: white;
    border-radius: 5px;
}

select {
    padding: 5px;
}
</style>
</head>

<body>

<div class="header">Admin Complaints Dashboard</div>

<div class="table-container">

<table>
<tr>
    <th>ID</th>
    <th>Title</th>
    <th>Description</th>
    <th>Category</th>
    <th>Status</th>
    <th>Date</th>
    <th>Action</th>
</tr>

<%
Connection con = com.db.DB.getConnection();
PreparedStatement ps = con.prepareStatement("SELECT * FROM complaints ORDER BY id DESC");
ResultSet rs = ps.executeQuery();

while(rs.next()) {
%>

<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("title") %></td>
    <td><%= rs.getString("description") %></td>
    <td><%= rs.getString("category") %></td>

    <td>
        <% if ("Pending".equalsIgnoreCase(rs.getString("status"))) { %>
            <span class="pending">Pending</span>
        <% } else { %>
            <span class="resolved">Resolved</span>
        <% } %>
    </td>

    <td><%= rs.getString("created_at") %></td>

    <td>
        <form action="UpdateStatusServlet" method="post">
            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">

            <select name="status">
                <option value="Pending">Pending</option>
                <option value="Resolved">Resolved</option>
            </select>

            <button type="submit">Update</button>
        </form>
    </td>
</tr>

<%
}
%>

</table>
</div>

</body>
</html>
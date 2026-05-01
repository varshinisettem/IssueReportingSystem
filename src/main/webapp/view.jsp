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
<title>Complaints Dashboard</title>

<!-- ✅ MOBILE RESPONSIVE FIX -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
body {
    font-family: Arial;
    margin: 0;
    background: #f4f6f9;
}

/* HEADER */
.header {
    background: #667eea;
    color: white;
    padding: 15px;
    text-align: center;
}

/* RESPONSIVE TABLE WRAPPER */
.table-container {
    width: 100%;
    overflow-x: auto;
}

/* TABLE */
table {
    width: 90%;
    margin: 20px auto;
    border-collapse: collapse;
    background: white;
    min-width: 600px; /* important for mobile scroll */
}

th, td {
    padding: 10px;
    text-align: center;
    border: 1px solid #ddd;
}

th {
    background: #667eea;
    color: white;
}

/* STATUS COLORS */
.pending { color: orange; font-weight: bold; }
.resolved { color: green; font-weight: bold; }

/* BUTTON */
button {
    padding: 6px 12px;
    background: #28a745;
    color: white;
    border: none;
    border-radius: 5px;
}

/* MOBILE FIX */
@media screen and (max-width: 768px) {
    table {
        width: 100%;
        font-size: 13px;
    }

    .header {
        font-size: 18px;
    }
}
</style>

</head>

<body>

<div class="header">Complaints Dashboard</div>

<div class="table-container">

<%
Connection con = com.db.DB.getConnection();
PreparedStatement ps = con.prepareStatement("SELECT * FROM complaints ORDER BY id DESC");
ResultSet rs = ps.executeQuery();

while(rs.next()) {
%>

<form action="UpdateStatusServlet" method="post">

<table>

<tr>
    <th>ID</th>
    <th>Title</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("title") %></td>

    <td>
        <% if ("Pending".equalsIgnoreCase(rs.getString("status"))) { %>
            <span class="pending">Pending</span>
        <% } else { %>
            <span class="resolved">Resolved</span>
        <% } %>
    </td>

    <td>
        <input type="hidden" name="id" value="<%= rs.getInt("id") %>"/>

        <select name="status">
            <option value="Pending">Pending</option>
            <option value="Resolved">Resolved</option>
        </select>

        <button type="submit">Update</button>
    </td>
</tr>

</table>

</form>

<%
}
%>

</div>

</body>
</html>
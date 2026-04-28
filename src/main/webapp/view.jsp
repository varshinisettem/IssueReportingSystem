<%@ page import="java.sql.*" %>

<%
    // 🔐 Admin protection
    String admin = (String) session.getAttribute("admin");

    if (admin == null) {
        response.sendRedirect("admin_login.html");
        return;
    }
%>

<html>
<head>
<title>Dashboard</title>

<style>
body {
    font-family: 'Segoe UI';
    background: #f4f6f9;
    margin: 0;
}

.header {
    background: #667eea;
    color: white;
    padding: 15px;
    text-align: center;
    font-size: 24px;
}

.logout {
    text-align: right;
    margin: 10px;
}

.stats {
    text-align: center;
    margin-top: 20px;
    font-size: 18px;
}

table {
    width: 90%;
    margin: 30px auto;
    border-collapse: collapse;
    background: white;
}

th, td {
    padding: 12px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

th {
    background: #667eea;
    color: white;
}

.pending {
    color: orange;
    font-weight: bold;
}

.resolved {
    color: green;
    font-weight: bold;
}

button {
    padding: 6px 12px;
    background: #28a745;
    color: white;
    border: none;
    border-radius: 5px;
}
</style>

</head>

<body>

<div class="header">Complaints Dashboard</div>

<div class="logout">
    <a href="LogoutServlet">Logout</a>
</div>

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

int total = 0, pending = 0, resolved = 0;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/issue_db", "root", "varshi"
    );

    // ==============================
    // 🔥 FETCH ALL COMPLAINTS ONCE
    // ==============================
    ps = con.prepareStatement("SELECT * FROM complaints");
    rs = ps.executeQuery();

    java.util.ArrayList<java.util.HashMap<String, String>> list =
        new java.util.ArrayList<>();

    while (rs.next()) {

        total++;

        String status = rs.getString("status");

        if ("Pending".equalsIgnoreCase(status))
            pending++;
        else
            resolved++;

        java.util.HashMap<String, String> row = new java.util.HashMap<>();
        row.put("id", rs.getString("id"));
        row.put("title", rs.getString("title"));
        row.put("description", rs.getString("description"));
        row.put("category", rs.getString("category"));
        row.put("status", status);

        list.add(row);
    }

%>

<div class="stats">
    Total: <%= total %> |
    Pending: <%= pending %> |
    Resolved: <%= resolved %>
</div>

<table>
<tr>
    <th>ID</th>
    <th>Title</th>
    <th>Description</th>
    <th>Category</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<%
    for (java.util.Map<String, String> row : list) {
%>

<tr>
    <td><%= row.get("id") %></td>
    <td><%= row.get("title") %></td>
    <td><%= row.get("description") %></td>
    <td><%= row.get("category") %></td>

    <td>
        <% if ("Pending".equalsIgnoreCase(row.get("status"))) { %>
            <span class="pending">Pending</span>
        <% } else { %>
            <span class="resolved">Resolved</span>
        <% } %>
    </td>

    <td>
        <form action="UpdateStatusServlet" method="post">
            <input type="hidden" name="id" value="<%= row.get("id") %>">

            <% if ("Pending".equalsIgnoreCase(row.get("status"))) { %>
                <button type="submit">Resolve</button>
            <% } else { %>
                ✔
            <% } %>
        </form>
    </td>
</tr>

<%
    }
%>

</table>

<%
} catch (Exception e) {
    out.println("<h3 style='color:red'>Error: " + e.getMessage() + "</h3>");
} finally {
    try { if (rs != null) rs.close(); } catch(Exception e) {}
    try { if (ps != null) ps.close(); } catch(Exception e) {}
    try { if (con != null) con.close(); } catch(Exception e) {}
}
%>

</body>
</html>
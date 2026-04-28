	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
	<%
	String user = (String) session.getAttribute("user");
	
	if (user == null) {
	    response.sendRedirect("login.html");
	    return;
	}
	%>
	
	<!DOCTYPE html>
	<html>
	<head>
	<title>Submit Complaint</title>
	
	<style>
	body {
	    font-family: 'Segoe UI';
	    background: linear-gradient(to right, #667eea, #764ba2);
	    margin: 0;
	}
	
	.container {
	    width: 400px;
	    margin: 80px auto;
	    background: white;
	    padding: 25px;
	    border-radius: 12px;
	    box-shadow: 0 8px 20px rgba(0,0,0,0.2);
	    text-align: center;
	}
	
	h2 {
	    margin-bottom: 20px;
	}
	
	input, textarea {
	    width: 90%;
	    padding: 12px;
	    margin: 10px 0;
	    border-radius: 8px;
	    border: 1px solid #ccc;
	}
	
	button {
	    width: 95%;
	    padding: 12px;
	    background: #667eea;
	    color: white;
	    border: none;
	    border-radius: 8px;
	    font-size: 16px;
	    cursor: pointer;
	}
	
	button:hover {
	    background: #5a67d8;
	}
	</style>
	
	</head>
	
	<body>
	
	<div class="container">
	    <h2>Submit Complaint</h2>
	
	    <form action="ComplaintServlet" method="post">
	
	        <input type="text" name="subject" placeholder="Title" required>
	
	        <textarea name="description" placeholder="Describe your issue..." required></textarea>
	
	        <input type="text" name="category" placeholder="Category (optional)">
	
	        <button type="submit">Submit Complaint</button>
	    </form>
	</div>
	
	</body>
	</html>
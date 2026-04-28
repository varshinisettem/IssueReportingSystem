<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 🔐 DESTROY SESSION
    if (session != null) {
        session.invalidate();
    }

    // 🚫 PREVENT BACK BUTTON CACHE (optional but good practice)
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // 🔄 REDIRECT TO LOGIN PAGE
    response.sendRedirect("login.html");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 🔐 GET EXISTING SESSION ONLY
    javax.servlet.http.HttpSession sessionObj = request.getSession(false);

    if (sessionObj != null) {
        sessionObj.invalidate();
    }

    // 🚫 PREVENT BACK BUTTON CACHE
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // 🔄 REDIRECT TO LOGIN PAGE
    response.sendRedirect("login.html");
%>
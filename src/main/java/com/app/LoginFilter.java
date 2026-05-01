package com.app;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {}

    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        HttpSession session = req.getSession(false);

        boolean loggedIn = (session != null && session.getAttribute("user") != null);

        // ✅ PUBLIC PAGES LIST
        boolean isPublic =
                uri.contains("login.html") ||
                uri.contains("register.html") ||
                uri.contains("index.html") ||
                uri.contains("LoginServlet") ||
                uri.contains("RegisterServlet");

        if (loggedIn || isPublic) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect("login.html");
        }
    }

    public void destroy() {}
}
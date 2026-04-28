import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        HttpSession session = req.getSession(false);

        boolean loggedIn = (session != null && session.getAttribute("user") != null);

        // ✅ PUBLIC PAGES (NO LOGIN REQUIRED)
        boolean isPublic =
                uri.endsWith("login.html") ||
                uri.endsWith("register.html") ||
                uri.endsWith("index.html") ||
                uri.endsWith("LoginServlet") ||
                uri.endsWith("RegisterServlet");

        if (loggedIn || isPublic) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect("login.html");
        }
    }
}
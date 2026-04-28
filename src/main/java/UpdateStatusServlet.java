import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import com.db.DB;
public class UpdateStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/issue_db", "root", "varshi");

            PreparedStatement ps = con.prepareStatement(
                "UPDATE complaints SET status='Resolved' WHERE id=?");

            ps.setInt(1, id);
            ps.executeUpdate();

            response.sendRedirect("view.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
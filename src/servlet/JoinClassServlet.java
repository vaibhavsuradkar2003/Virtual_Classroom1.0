package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;

import dao.DBConnection;
import dao.EnrollmentDAO;
import model.User;

@WebServlet("/joinClass")
public class JoinClassServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        res.setContentType("text/plain");

        String code = req.getParameter("code");

        HttpSession session = req.getSession(false);
        if(session == null || session.getAttribute("user") == null){
            res.getWriter().write("Session Expired!");
            return;
        }

        User user = (User) session.getAttribute("user");

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT id FROM classes WHERE class_code=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, code);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                int classId = rs.getInt("id");

                EnrollmentDAO dao = new EnrollmentDAO();

                if(dao.isAlreadyEnrolled(user.getId(), classId)){
                    res.getWriter().write("Already Joined!");
                    return;
                }

                dao.enrollStudent(user.getId(), classId);
                res.getWriter().write("Joined Successfully!");

            } else {
                res.getWriter().write("Invalid Code!");
            }

        } catch(Exception e){
            e.printStackTrace();
            res.getWriter().write("Server Error!");
        }
    }
}
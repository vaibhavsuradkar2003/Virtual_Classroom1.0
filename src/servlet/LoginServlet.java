package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import dao.UserDAO;
import model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.login(email, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            String path = req.getContextPath();   // ✅ IMPORTANT FIX

            if(user.getRole().trim().equalsIgnoreCase("admin"))
                res.sendRedirect(path + "/admin_dashboard.jsp");
            else if(user.getRole().equals("faculty"))
                res.sendRedirect(path + "/faculty_dashboard.jsp");
            else
                res.sendRedirect(path + "/student_dashboard.jsp");

        } else {
            req.setAttribute("error", "Invalid Credentials");
            req.getRequestDispatcher("login.jsp").forward(req, res);
        }
    }
}
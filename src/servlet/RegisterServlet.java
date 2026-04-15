package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

import dao.UserDAO;
import model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        // Faculty → pending | Student → approved
        if("faculty".equals(role)){
            user.setStatus("pending");
        } else {
            user.setStatus("approved");
        }

        UserDAO dao = new UserDAO();
        boolean status = dao.register(user);

        if(status){
            req.setAttribute("msg", "Registration Successful!");
        } else {
            req.setAttribute("msg", "Registration Failed!");
        }

        req.getRequestDispatcher("login.jsp").forward(req, res);
    }
}
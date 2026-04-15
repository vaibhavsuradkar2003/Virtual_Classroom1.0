package dao;

import java.sql.*;
import model.User;

public class UserDAO {

    public boolean register(User user) {
        boolean status = false;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO users(name,email,password,role,status) VALUES(?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());
            ps.setString(5, "pending");

            status = ps.executeUpdate() > 0;
        } catch(Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public User login(String email, String password) {
        User user = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email=? AND password=? AND status='approved'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                user.setName(rs.getString("name"));
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return user;
    }
}
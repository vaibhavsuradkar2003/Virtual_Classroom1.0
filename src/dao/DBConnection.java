package dao;

import java.sql.*;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/virtual_classroom";
    private static final String USER = "root";  // mysql user name
    private static final String PASSWORD = "root123"; // mysql password 

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
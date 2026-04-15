package dao;

import java.sql.*;
import java.util.*;
import model.ClassRoom;
import model.User;

public class EnrollmentDAO {

    // ✅ JOIN CLASS
    public boolean enrollStudent(int studentId, int classId) {
        boolean status = false;

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "INSERT INTO enrollments(student_id, class_id) VALUES(?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, studentId);
            ps.setInt(2, classId);

            status = ps.executeUpdate() > 0;

        } catch(Exception e){
            e.printStackTrace();
        }

        return status;
    }

    // ✅ GET CLASSES BY STUDENT (USED IN DASHBOARD)
    public List<ClassRoom> getClassesByStudent(int studentId) {
        List<ClassRoom> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT c.* FROM classes c " +
                         "JOIN enrollments e ON c.id = e.class_id " +
                         "WHERE e.student_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                ClassRoom c = new ClassRoom();

                c.setId(rs.getInt("id"));
                c.setClassName(rs.getString("class_name"));
                c.setFacultyId(rs.getInt("faculty_id"));
                c.setClassCode(rs.getString("class_code"));

                // ✅ IMPORTANT
                c.setSubject(rs.getString("subject"));
                c.setSection(rs.getString("section"));

                list.add(c);
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }

    // ✅ CHECK ALREADY JOINED
    public boolean isAlreadyEnrolled(int studentId, int classId) {
        boolean exists = false;

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT * FROM enrollments WHERE student_id=? AND class_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, studentId);
            ps.setInt(2, classId);

            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                exists = true;
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return exists;
    }

    // ✅ GET STUDENTS BY CLASS (PEOPLE TAB)
    public List<User> getStudentsByClass(int classId) {
        List<User> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT u.* FROM users u " +
                         "JOIN enrollments e ON u.id = e.student_id " +
                         "WHERE e.class_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, classId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                User u = new User();

                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getString("role"));

                list.add(u);
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
}
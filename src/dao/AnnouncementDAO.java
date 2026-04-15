package dao;

import java.sql.*;
import java.util.*;
import model.Announcement;

public class AnnouncementDAO {

    // ✅ ADD ANNOUNCEMENT
    public boolean addAnnouncement(Announcement a){
        boolean status = false;

        try(Connection conn = DBConnection.getConnection()){

            String sql = "INSERT INTO announcements(class_id, message, file_path, date) VALUES(?,?,?,NOW())";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, a.getClassId());
            ps.setString(2, a.getMessage());
            ps.setString(3, a.getFilePath());

            status = ps.executeUpdate() > 0;

        }catch(Exception e){
            e.printStackTrace();
        }

        return status;
    }

    // ✅ GET ANNOUNCEMENTS BY CLASS
    public List<Announcement> getByClass(int classId){
        List<Announcement> list = new ArrayList<>();

        try(Connection conn = DBConnection.getConnection()){

            String sql = "SELECT * FROM announcements WHERE class_id=? ORDER BY date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, classId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Announcement a = new Announcement();

                a.setId(rs.getInt("id"));
                a.setClassId(rs.getInt("class_id"));
                a.setMessage(rs.getString("message"));
                a.setDate(rs.getTimestamp("date"));
                a.setFilePath(rs.getString("file_path"));
                list.add(a);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
}
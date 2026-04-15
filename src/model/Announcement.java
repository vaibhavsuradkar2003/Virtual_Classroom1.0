package model;

import java.sql.Timestamp;

public class Announcement {

    private int id;
    private int classId;
    private String message;
    private Timestamp date;
    private String filePath;

    // ✅ Default Constructor
    public Announcement() {}

    // ✅ Parameterized Constructor
    public Announcement(int classId, String message) {
        this.classId = classId;
        this.message = message;
    }

    // ✅ Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
}
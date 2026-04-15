package model;

public class Enrollment {

    private int id;
    private int studentId;
    private int classId;

    // ✅ Default Constructor
    public Enrollment() {}

    // ✅ Parameterized Constructor
    public Enrollment(int studentId, int classId) {
        this.studentId = studentId;
        this.classId = classId;
    }

    // ✅ Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }
}
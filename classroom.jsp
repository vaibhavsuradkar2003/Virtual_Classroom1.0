<%@ page import="java.sql.*,dao.DBConnection,model.User,dao.EnrollmentDAO,dao.AnnouncementDAO,model.Announcement,dao.MaterialDAO,model.Material,java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
User user = (User) session.getAttribute("user");

if(user == null){
    response.sendRedirect("login.jsp");
    return;
}

int classId = Integer.parseInt(request.getParameter("id"));
String tab = request.getParameter("tab");

// Dashboard redirect
String dashboard = "student_dashboard.jsp";
if("faculty".equals(user.getRole())){
    dashboard = "faculty_dashboard.jsp";
}

// Class details
String className="", subject="", section="", classCode="";
int facultyId=0;
String teacherName="", teacherEmail="";

try(Connection conn = DBConnection.getConnection()){

    String sql="SELECT * FROM classes WHERE id=?";
    PreparedStatement ps=conn.prepareStatement(sql);
    ps.setInt(1,classId);
    ResultSet rs=ps.executeQuery();

    if(rs.next()){
        className=rs.getString("class_name");
        subject=rs.getString("subject");
        section=rs.getString("section");
        classCode=rs.getString("class_code");
        facultyId=rs.getInt("faculty_id");
    }

    String tSql="SELECT name,email FROM users WHERE id=?";
    PreparedStatement ps2=conn.prepareStatement(tSql);
    ps2.setInt(1,facultyId);
    ResultSet rs2=ps2.executeQuery();

    if(rs2.next()){
        teacherName=rs2.getString("name");
        teacherEmail=rs2.getString("email");
    }
}

// DAO
EnrollmentDAO edao = new EnrollmentDAO();
List<User> students = edao.getStudentsByClass(classId);

AnnouncementDAO adao = new AnnouncementDAO();
List<Announcement> announcements = adao.getByClass(classId);

MaterialDAO mdao = new MaterialDAO();
List<Material> materials = mdao.getMaterialsByClass(classId);
%>

<!DOCTYPE html>
<html>
<head>
<title>Classroom</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
/* 🌄 FULL BACKGROUND */
body {
    background: url('https://images.unsplash.com/photo-1496307042754-b4aa456c4a2d') no-repeat center center fixed;
    background-size: cover;
    font-family: 'Segoe UI';
}

/* DARK OVERLAY */
body::before {
    content:"";
    position: fixed;
    width:100%;
    height:100%;
    background: rgba(0,0,0,0.7);
    top:0;
    left:0;
    z-index:-1;
}

/* CONTAINER GLASS */
.container {
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(15px);
    border-radius: 20px;
    padding: 25px;
}

/* BACK BUTTON */
.btn-light {
    border-radius: 25px;
}

/* HEADER / BANNER */
.banner {
    background: linear-gradient(135deg,#667eea,#764ba2);
    color:white;
    padding:35px;
    border-radius:20px;
    box-shadow:0 10px 25px rgba(0,0,0,0.3);
}

/* TABS */
.tabs {
    display:flex;
    gap:25px;
    border-bottom:1px solid rgba(255,255,255,0.2);
}

.tabs a {
    text-decoration:none;
    font-weight:600;
    padding-bottom:10px;
    color:#ddd;
    transition:0.3s;
}

.tabs a:hover {
    color:white;
}

.tabs a.active {
    border-bottom:3px solid #fff;
    color:white;
}

/* CARDS */
.card-custom {
    border-radius:15px;
    box-shadow:0 6px 20px rgba(0,0,0,0.25);
    border:none;
    background: rgba(255,255,255,0.1);
    backdrop-filter: blur(10px);
    color:white;
}

/* FORM INPUT */
.form-control {
    background: rgba(255,255,255,0.15);
    border:none;
    color:white;
}

.form-control::placeholder {
    color:#ddd;
}

.form-control:focus {
    background: rgba(255,255,255,0.25);
    box-shadow:none;
    color:white;
}

/* BUTTON */
.btn-primary {
    background: linear-gradient(135deg,#43cea2,#185a9d);
    border:none;
}

/* AVATAR */
.avatar {
    width:45px;
    height:45px;
    background: linear-gradient(135deg,#ff758c,#ff7eb3);
    color:white;
    border-radius:50%;
    display:flex;
    align-items:center;
    justify-content:center;
    font-weight:bold;
}

/* VIDEO */
video {
    border-radius:12px;
    box-shadow:0 4px 15px rgba(0,0,0,0.4);
}
h4.mb-3{
    color: white;
}
</style>
</head>

<body>

<div class="container mt-4 mb-4">

<a href="<%= dashboard %>" class="btn btn-light mb-3">← Back</a>

<!-- HEADER -->
<div class="banner mb-4">
<h2><%= className %></h2>
<p>
Subject: <%= subject %> |
Section: <%= section %><br>
Code: <b><%= classCode %></b>
</p>
</div>

<!-- TABS -->
<div class="tabs mb-4">
<a href="classroom.jsp?id=<%= classId %>" class="<%= tab==null?"active":"" %>">Stream</a>
<a href="classroom.jsp?id=<%= classId %>&tab=material" class="<%= "material".equals(tab)?"active":"" %>">Material</a>
<a href="classroom.jsp?id=<%= classId %>&tab=people" class="<%= "people".equals(tab)?"active":"" %>">People</a>
</div>

<%
if(tab == null){
%>

<!-- ===== STREAM ===== -->

<% if("faculty".equals(user.getRole())){ %>
<div class="card card-custom p-3 mb-3">
<form action="addAnnouncement" method="post" enctype="multipart/form-data">
<input type="hidden" name="classId" value="<%= classId %>">

<textarea name="message" class="form-control mb-2" placeholder="Announce something..." required></textarea>

<input type="file" name="file" class="form-control mb-2">

<button class="btn btn-primary">Post</button>
</form>
</div>
<% } %>

<% for(Announcement a: announcements){ %>
<div class="card card-custom p-3 mb-3">
<b>📢 Announcement</b>
<p><%= a.getMessage() %></p>

<% if(a.getFilePath()!=null && !a.getFilePath().isEmpty()){ %>
<a href="uploads/<%= a.getFilePath() %>" target="_blank" class="btn btn-success btn-sm">📄 PDF</a>
<% } %>

</div>
<% } %>

<%
} else if("material".equals(tab)){
%>

<!-- ===== MATERIAL ===== -->

<h4 class="mb-3">📚 Materials</h4>

<% if("faculty".equals(user.getRole())){ %>
<div class="card card-custom p-3 mb-3">

<form action="uploadMaterial" method="post" enctype="multipart/form-data">

<input type="hidden" name="classId" value="<%= classId %>">

<input type="text" name="title" class="form-control mb-2" placeholder="Material Title" required>

<!-- SINGLE ATTACH BUTTON -->
<input type="file" name="file" class="form-control mb-2"
       accept=".pdf,.mp4,.mov,.avi">

<input type="text" name="videoLink" class="form-control mb-2"
       placeholder="OR Paste Video Link">

<button class="btn btn-primary">Attach & Upload</button>

</form>

</div>
<% } %>

<% for(Material m: materials){ %>

<div class="card card-custom p-3 mb-3">

<h5><%= m.getTitle() %></h5>

<%
String file = m.getFilePath();
String ext = "";

if(file != null){
    ext = file.substring(file.lastIndexOf(".") + 1).toLowerCase();
}
%>

<!-- PDF -->
<% if(file != null && file.endsWith(".pdf")){ %>
<a href="uploads/<%= file %>" target="_blank"
class="btn btn-success btn-sm">📄 View PDF</a>
<% } %>

<!-- VIDEO FILE -->
<% if(file != null && (ext.equals("mp4") || ext.equals("mov") || ext.equals("avi"))){ %>

<video width="100%" height="350" controls>
    <source src="<%= request.getContextPath() %>/uploads/<%= file %>" 
            type="video/<%= ext.equals("mp4") ? "mp4" : "quicktime" %>">
    Your browser does not support video.
</video>

<% } %>
<!-- VIDEO LINK -->
<% if(m.getVideoLink()!=null && !m.getVideoLink().isEmpty()){ %>
<a href="<%= m.getVideoLink() %>" target="_blank"
class="btn btn-danger btn-sm">▶ Watch Video</a>
<% } %>

</div>

<% } %>

<%
} else if("people".equals(tab)){
%>

<!-- ===== PEOPLE ===== -->

<div class="card card-custom p-3">

<h5>👨‍🏫 Teacher</h5>
<p><%= teacherName %> (<%= teacherEmail %>)</p>

<hr>

<h5>👨‍🎓 Students (<%= students.size() %>)</h5>

<% for(User s: students){ %>
<div class="d-flex align-items-center mb-2">
<div class="avatar"><%= s.getName().charAt(0) %></div>
<div class="ms-2">
<b><%= s.getName() %></b><br>
<small><%= s.getEmail() %></small>
</div>
</div>
<% } %>

</div>

<%
}
%>

</div>

</body>
</html>
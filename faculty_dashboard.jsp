<%@ page import="java.util.*,model.ClassRoom,dao.ClassDAO,model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
User user = (User) session.getAttribute("user");

if(user == null){
    response.sendRedirect("login.jsp");
    return;
}

ClassDAO dao = new ClassDAO();
List<ClassRoom> classes = dao.getClassesByFaculty(user.getId());
%>

<!DOCTYPE html>
<html>
<head>
<title>Faculty Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

/* 🌄 BACKGROUND */
body {
    background: url('https://images.unsplash.com/photo-1523240795612-9a054b0db644') no-repeat center center fixed;
    background-size: cover;
    font-family: 'Segoe UI';
}

body::before {
    content:"";
    position: fixed;
    width:100%;
    height:100%;
    background: rgba(0,0,0,0.6);
    top:0;
    left:0;
    z-index:-1;
}

/* HEADER */
.header {
    background: rgba(255,255,255,0.15);
    backdrop-filter: blur(12px);
    border-radius: 15px;
    padding: 15px 25px;
    color: white;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

/* GRID */
.class-grid {
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(280px,1fr));
    gap:20px;
}

/* CARD */
.class-card {
    border-radius:15px;
    overflow:hidden;
    cursor:pointer;
    transition:0.3s;
}

.class-card:hover {
    transform: translateY(-6px);
    box-shadow:0 10px 30px rgba(0,0,0,0.4);
}

/* CARD TOP */
.card-top {
    padding:20px;
    color:white;
}

/* COLORS */
.bg1 { background:linear-gradient(135deg,#667eea,#764ba2); }
.bg2 { background:linear-gradient(135deg,#ff758c,#ff7eb3); }
.bg3 { background:linear-gradient(135deg,#43cea2,#185a9d); }
.bg4 { background:linear-gradient(135deg,#f7971e,#ffd200); }

/* CARD BOTTOM */
.card-bottom {
    background:white;
    padding:15px;
}

/* CODE BADGE */
.code-badge {
    background:#198754;
    color:white;
    padding:5px 10px;
    border-radius:8px;
    font-size:13px;
}

/* BUTTON */
.create-btn {
    border-radius:25px;
}

/* MODAL */
.glass-modal {
    background: rgba(20,20,20,0.6);
    backdrop-filter: blur(20px);
    border-radius: 20px;
    color: white;
}

.modal-header {
    background: linear-gradient(135deg,#667eea,#764ba2);
    border-radius: 20px 20px 0 0;
}

.custom-input {
    background: rgba(255,255,255,0.1) !important;
    border: 1px solid rgba(255,255,255,0.2);
    color: white;
    border-radius: 10px;
}

.custom-input:focus {
    background: rgba(255,255,255,0.15) !important;
    border: 1px solid #667eea;
    box-shadow: 0 0 10px rgba(102,126,234,0.7);
    color: white;
}

.btn-gradient {
    background: linear-gradient(135deg,#ff758c,#ff7eb3);
    border:none;
    border-radius:25px;
    color:white;
}

</style>

<script>
function openClass(id){
    window.location.href="classroom.jsp?id="+id;
}
</script>

</head>

<body>

<div class="container mt-4">

<!-- HEADER -->
<div class="header mb-4">
    <h4>📚 Faculty Dashboard</h4>
    <div>
        Welcome, <b><%= user.getName() %></b>
        <a href="logout" class="btn btn-danger btn-sm ms-3">Logout</a>
    </div>
</div>

<!-- CREATE BUTTON -->
<div class="text-end mb-3">
    <button class="btn btn-primary create-btn"
            data-bs-toggle="modal"
            data-bs-target="#createModal">
        + Create Class
    </button>
</div>

<!-- CLASS GRID -->
<div class="class-grid">

<%
int i = 1;
for(ClassRoom c : classes){
String bg = "bg"+((i%4)+1);
%>

<div class="class-card shadow" onclick="openClass(<%= c.getId() %>)">
    <div class="card-top <%= bg %>">
        <h5><%= c.getClassName() %></h5>
        <p>
            Subject: <%= c.getSubject() %><br>
            Section: <%= c.getSection() %>
        </p>
    </div>

    <div class="card-bottom d-flex justify-content-between">
        <span class="code-badge">Code: <%= c.getClassCode() %></span>
        <i class="fa fa-trash text-danger"></i>
    </div>
</div>

<%
i++;
}
%>

</div>

</div>

<!-- CREATE CLASS MODAL -->
<div class="modal fade" id="createModal">
<div class="modal-dialog modal-dialog-centered">
<div class="modal-content glass-modal border-0">

<div class="modal-header">
    <h5>Create Class</h5>
    <button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
</div>

<form action="createClass" method="post">

<div class="modal-body">

<input type="hidden" name="facultyId" value="<%= user.getId() %>">

<div class="mb-3">
<label>Class Name</label>
<input type="text" name="className" class="form-control custom-input" required>
</div>

<div class="mb-3">
<label>Subject</label>
<input type="text" name="subject" class="form-control custom-input">
</div>

<div class="mb-3">
<label>Section</label>
<input type="text" name="section" class="form-control custom-input">
</div>

</div>

<div class="modal-footer border-0">
<button class="btn btn-gradient w-100">Create Class</button>
</div>

</form>

</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
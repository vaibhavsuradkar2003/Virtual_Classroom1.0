<%@ page import="java.util.*,model.ClassRoom,dao.EnrollmentDAO,model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
User user = (User) session.getAttribute("user");

if(user == null){
    response.sendRedirect("login.jsp");
    return;
}

EnrollmentDAO dao = new EnrollmentDAO();
List<ClassRoom> classes = dao.getClassesByStudent(user.getId());
%>

<!DOCTYPE html>
<html>
<head>
<title>Student Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

/* 🌄 PREMIUM BACKGROUND IMAGE */
body {
    background: url('https://images.unsplash.com/photo-1498050108023-c5249f4df085') no-repeat center center fixed;
    background-size: cover;
    font-family: 'Segoe UI';
}

/* 🌫️ DARK OVERLAY (PRO LOOK) */
body::before {
    content:"";
    position: fixed;
    width:100%;
    height:100%;
    background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.8));
    top:0;
    left:0;
    z-index:-1;
}

/* 🌟 GLASS CONTAINER */
.glass {
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(18px);
    border-radius: 20px;
    padding: 20px;
    box-shadow: 0 10px 40px rgba(0,0,0,0.4);
}

/* HEADER */
.header {
    display:flex;
    justify-content:space-between;
    align-items:center;
}

/* PROFILE */
.profile {
    display:flex;
    align-items:center;
    gap:10px;
}

/* AVATAR */
.avatar {
    width:45px;
    height:45px;
    border-radius:50%;
    background: linear-gradient(135deg,#ff758c,#ff7eb3);
    color:white;
    display:flex;
    align-items:center;
    justify-content:center;
    font-weight:bold;
}

/* SEARCH */
.search-box input {
    border-radius:25px;
    border:none;
    background: rgba(255,255,255,0.15);
    color:white;
    padding:8px 15px;
}

.search-box input::placeholder {
    color:#ddd;
}

/* GRID */
.class-grid {
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(280px,1fr));
    gap:20px;
}

/* CARD */
.class-card {
    border-radius:18px;
    overflow:hidden;
    cursor:pointer;
    transition:0.35s;
    background: rgba(255,255,255,0.12);
    backdrop-filter: blur(12px);
}

.class-card:hover {
    transform:translateY(-8px) scale(1.02);
    box-shadow:0 15px 35px rgba(0,0,0,0.5);
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

/* BADGE */
.code-badge {
    background: linear-gradient(135deg,#00c9ff,#92fe9d);
    color:black;
    padding:6px 12px;
    border-radius:10px;
    font-size:13px;
    font-weight:600;
}

/* NOTIFICATION */
.notification {
    position:relative;
    cursor:pointer;
}

.notification .badge {
    position:absolute;
    top:-5px;
    right:-5px;
}

/* BUTTON */
.btn-primary {
    background: linear-gradient(135deg,#43cea2,#185a9d);
    border:none;
    border-radius:25px;
    padding:8px 18px;
}

/* MODAL */
.modal-content {
    border-radius:20px;
}
/* GLASS MODAL */
.glass-modal {
    background: rgba(20,20,20,0.6);
    backdrop-filter: blur(20px);
    border-radius: 20px;
    box-shadow: 0 15px 40px rgba(0,0,0,0.6);
    color: white;
}

/* HEADER */
.modal-header {
    background: linear-gradient(135deg,#667eea,#764ba2);
    border-radius: 20px 20px 0 0;
}

/* INPUT */
.custom-input {
    background: rgba(255,255,255,0.1) !important;
    border: 1px solid rgba(255,255,255,0.2);
    color: white;
    border-radius: 10px;
    padding: 10px;
}

/* PLACEHOLDER */
.custom-input::placeholder {
    color: rgba(255,255,255,0.6);
}

/* FOCUS */
.custom-input:focus {
    background: rgba(255,255,255,0.15) !important;
    border: 1px solid #667eea;
    box-shadow: 0 0 12px rgba(102,126,234,0.7);
    color: white;
}

/* BUTTON */
.btn-gradient {
    background: linear-gradient(135deg,#ff758c,#ff7eb3);
    border: none;
    border-radius: 25px;
    color: white;
    font-weight: 600;
    padding: 10px;
    transition: 0.3s;
}

.btn-gradient:hover {
    transform: scale(1.05);
}
</style>

<script>
function openClass(id){
    window.location.href="classroom.jsp?id="+id;
}

function filterClasses(){
    let input = document.getElementById("search").value.toLowerCase();
    let cards = document.getElementsByClassName("class-card");

    for(let i=0;i<cards.length;i++){
        let text = cards[i].innerText.toLowerCase();
        cards[i].style.display = text.includes(input) ? "" : "none";
    }
}
</script>

</head>

<body>

<div class="container mt-4 mb-5">

<div class="glass mb-4">

<!-- HEADER -->
<div class="header">

    <h4 class="text-white">📚 My Classes</h4>

    <div class="d-flex align-items-center gap-3">

        <!-- SEARCH -->
        <div class="search-box">
            <input type="text" id="search" onkeyup="filterClasses()" 
                   placeholder="Search..." class="form-control">
        </div>

        <!-- NOTIFICATION -->
        <div class="notification text-white">
            <i class="fa fa-bell fa-lg"></i>
            <span class="badge bg-danger">3</span>
        </div>

        <!-- PROFILE -->
        <div class="profile text-white">
            <div class="avatar">
                <%= user.getName().charAt(0) %>
            </div>
            <span><%= user.getName() %></span>
        </div>

        <a href="logout" class="btn btn-danger btn-sm">Logout</a>

    </div>

</div>

</div>

<!-- JOIN BUTTON -->
<div class="text-end mb-3">
<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#joinModal">
➕ Join Class
</button>
</div>

<!-- CLASS GRID -->
<div class="class-grid">

<%
int i=1;
for(ClassRoom c: classes){

String bg = "bg"+((i%4)+1);
%>

<div class="class-card" onclick="openClass(<%= c.getId() %>)">

<div class="card-top <%= bg %>">
    <h5><%= c.getClassName() %></h5>
    <p>
        <%= c.getSubject() %><br>
        Section: <%= c.getSection() %>
    </p>
</div>

<div class="p-3 d-flex justify-content-between">
    <span class="code-badge">Code: <%= c.getClassCode() %></span>
</div>

</div>

<%
i++;
}
%>

</div>

</div>

<!-- JOIN MODAL -->
<div class="modal fade" id="joinModal">
<div class="modal-dialog modal-dialog-centered">
<div class="modal-content glass-modal border-0">

<!-- HEADER -->
<div class="modal-header">
    <h5 class="modal-title text-white">🎯 Join Class</h5>
    <button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
</div>

<form action="joinClass" method="post">

<div class="modal-body">

<input type="hidden" name="studentId" value="<%= user.getId() %>">

<!-- CLASS CODE INPUT -->
<div class="mb-3">
    <label class="form-label text-white">Enter Class Code</label>
    <input type="text" name="classCode"
           class="form-control custom-input"
           placeholder="e.g. 123abcde"
           required>
</div>

<!-- INFO TEXT -->
<p class="text-light small">
    Ask your teacher for the class code, then enter it here.
</p>

</div>

<div class="modal-footer border-0">
    <button class="btn btn-gradient w-100">🚀 Join Class</button>
</div>

</form>

</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
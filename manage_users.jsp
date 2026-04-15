<%@ page import="java.sql.*,dao.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
if(session.getAttribute("user") == null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Manage Users</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

/* 🌄 BACKGROUND */
body {
    background: url('https://images.unsplash.com/photo-1492724441997-5dc865305da7') no-repeat center center fixed;
    background-size: cover;
    font-family: 'Segoe UI';
    position: relative;
}

/* OVERLAY */
body::before {
    content:"";
    position: fixed;
    width:100%;
    height:100%;
    background: rgba(0,0,0,0.65);
    top:0;
    left:0;
    z-index:-1;
}

/* GLASS CONTAINER */
.container {
    background: rgba(255,255,255,0.12);
    backdrop-filter: blur(12px);
    border-radius: 15px;
    padding: 25px;
    margin-top: 40px;
    box-shadow: 0 8px 30px rgba(0,0,0,0.3);
}

/* TITLE */
h3 {
    color:white;
    font-weight:600;
}

/* TABLE */
.table {
    color:white;
    background: rgba(255,255,255,0.1);
    backdrop-filter: blur(10px);
    border-radius:10px;
    overflow:hidden;
}

.table thead {
    background: rgba(0,0,0,0.6);
}

.table th, .table td {
    border-color: rgba(255,255,255,0.1);
}

/* ROW HOVER */
.table tbody tr:hover {
    background: rgba(255,255,255,0.15);
    transition: 0.3s;
}

/* BUTTONS */
.btn-success {
    background: linear-gradient(135deg,#43cea2,#185a9d);
    border:none;
}

.btn-warning {
    background: linear-gradient(135deg,#f7971e,#ffd200);
    border:none;
    color:black;
}

.btn-danger {
    background: linear-gradient(135deg,#ff758c,#ff7eb3);
    border:none;
}

/* SEARCH */
.search-box {
    margin-bottom:15px;
}

.search-box input {
    background: rgba(255,255,255,0.2);
    border:none;
    color:white;
}

.search-box input::placeholder {
    color:#ddd;
}

/* BACK BUTTON */
.back-btn {
    margin-bottom:15px;
}

</style>

<script>
function filterUsers(){
    let input = document.getElementById("search").value.toLowerCase();
    let rows = document.querySelectorAll("tbody tr");

    rows.forEach(row => {
        row.style.display = row.innerText.toLowerCase().includes(input) ? "" : "none";
    });
}
</script>

</head>

<body>

<div class="container">

<a href="admin_dashboard.jsp" class="btn btn-light back-btn">← Back</a>

<h3 class="mb-3">👥 Manage Users</h3>

<!-- SEARCH -->
<div class="search-box">
    <input type="text" id="search" onkeyup="filterUsers()" 
           class="form-control" placeholder="Search users...">
</div>

<table class="table table-bordered text-center">
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Email</th>
    <th>Role</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<%
try(Connection conn = DBConnection.getConnection()){
    Statement st = conn.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM users");

    while(rs.next()){
%>
<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getString("email") %></td>
    <td><%= rs.getString("role") %></td>
    <td><%= rs.getString("status") %></td>

    <td>
        <% if("faculty".equals(rs.getString("role")) && 
              "pending".equals(rs.getString("status"))) { %>

            <a href="admin?action=approve&id=<%= rs.getInt("id") %>" 
               class="btn btn-success btn-sm">Approve</a>

            <a href="admin?action=reject&id=<%= rs.getInt("id") %>" 
               class="btn btn-warning btn-sm">Reject</a>

        <% } %>

        <a href="admin?action=delete&id=<%= rs.getInt("id") %>" 
           class="btn btn-danger btn-sm"
           onclick="return confirm('Delete user?')">Delete</a>
    </td>
</tr>
<%
    }
} catch(Exception e){
    e.printStackTrace();
}
%>

</table>

</div>

</body>
</html>
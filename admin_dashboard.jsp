<%@ page import="java.sql.*,dao.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // ✅ Session check
    if(session.getAttribute("user") == null){
        response.sendRedirect("login.jsp");
        return;
    }

    int totalUsers = 0, totalStudents = 0, totalFaculty = 0, totalClasses = 0;

    try(Connection conn = DBConnection.getConnection()){
        Statement st = conn.createStatement();

        ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM users");
        if(rs1.next()) totalUsers = rs1.getInt(1);

        ResultSet rs2 = st.executeQuery("SELECT COUNT(*) FROM users WHERE role='student'");
        if(rs2.next()) totalStudents = rs2.getInt(1);

        ResultSet rs3 = st.executeQuery("SELECT COUNT(*) FROM users WHERE role='faculty'");
        if(rs3.next()) totalFaculty = rs3.getInt(1);

        ResultSet rs4 = st.executeQuery("SELECT COUNT(*) FROM classes");
        if(rs4.next()) totalClasses = rs4.getInt(1);

    } catch(Exception e){
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>

    <!-- Bootstrap + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <style>
        /* 🌄 PREMIUM BACKGROUND */
body {
    background: url('https://images.unsplash.com/photo-1519389950473-47ba0277781c') no-repeat center center fixed;
    background-size: cover;
    font-family: 'Segoe UI';
    position: relative;
}

/* DARK OVERLAY */
body::before {
    content: "";
    position: fixed;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.65);
    top: 0;
    left: 0;
    z-index: -1;
}

/* 🌫️ GLASS EFFECT MAIN */
.container-fluid {
    position: relative;
    z-index: 1;
}

/* SIDEBAR GLASS */
.sidebar {
    height: 100vh;
    background: rgba(0,0,0,0.7);
    backdrop-filter: blur(10px);
    color: white;
    border-right: 1px solid rgba(255,255,255,0.1);
}

.sidebar h4 {
    text-align: center;
    margin-bottom: 20px;
}

.sidebar a {
    color: white;
    display: block;
    padding: 12px;
    border-radius: 8px;
    margin-bottom: 8px;
    transition: 0.3s;
}

.sidebar a:hover {
    background: linear-gradient(135deg,#667eea,#764ba2);
    transform: translateX(5px);
}

/* HEADER */
h3 {
    color: white;
    font-weight: 600;
}

/* CARDS */
.card {
    border-radius: 15px;
    border: none;
    backdrop-filter: blur(8px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.3);
    transition: 0.3s;
}

.card:hover {
    transform: translateY(-5px);
}

/* CARD COLORS ENHANCED */
.bg-primary { background: linear-gradient(135deg,#667eea,#764ba2)!important; }
.bg-success { background: linear-gradient(135deg,#43cea2,#185a9d)!important; }
.bg-warning { background: linear-gradient(135deg,#f7971e,#ffd200)!important; }
.bg-danger  { background: linear-gradient(135deg,#ff758c,#ff7eb3)!important; }

/* TABLE */
.table {
    background: rgba(255,255,255,0.1);
    backdrop-filter: blur(10px);
    color: white;
    border-radius: 10px;
    overflow: hidden;
}

.table thead {
    background: rgba(0,0,0,0.6);
}

.table td, .table th {
    border-color: rgba(255,255,255,0.1);
}

/* SEARCH */
#search {
    background: rgba(255,255,255,0.2);
    border: none;
    color: white;
}

#search::placeholder {
    color: rgba(255,255,255,0.7);
}

/* BUTTON */
.btn {
    border-radius: 25px;
}

/* DARK MODE */
body.dark {
    background: #121212;
}
    </style>
</head>

<body>

<div class="container-fluid">
    <div class="row">

        <!-- Sidebar -->
        <div class="col-md-2 sidebar p-3">
            <h4><i class="fa fa-user-shield"></i> Admin</h4>
            <hr>
            <a href="#"><i class="fa fa-home"></i> Dashboard</a>
            <a href="manage_users.jsp"><i class="fa fa-users"></i> Users</a>
            <a href="#"><i class="fa fa-book"></i> Classes</a>
            <a href="logout"><i class="fa fa-sign-out-alt"></i> Logout</a>
        </div>

        <!-- Main Content -->
        <div class="col-md-10 p-4">

            <!-- Navbar -->
            <div class="d-flex justify-content-between mb-4">
                <h3>Dashboard</h3>
                <button class="btn btn-dark" onclick="toggleDarkMode()">🌙</button>
            </div>

            <!-- Cards -->
            <div class="row text-center">

                <div class="col-md-3">
                    <div class="card bg-primary text-white p-3">
                        <h5>Total Users</h5>
                        <h2><%= totalUsers %></h2>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card bg-success text-white p-3">
                        <h5>Students</h5>
                        <h2><%= totalStudents %></h2>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card bg-warning text-white p-3">
                        <h5>Faculty</h5>
                        <h2><%= totalFaculty %></h2>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card bg-danger text-white p-3">
                        <h5>Classes</h5>
                        <h2><%= totalClasses %></h2>
                    </div>
                </div>

            </div>

            <!-- Chart -->
            <div class="card mt-4 p-3">
                <h5>User Statistics</h5>
                <canvas id="chart"></canvas>
            </div>

            <!-- Search -->
            <input type="text" id="search" class="form-control mt-4" placeholder="Search users...">

            <!-- Users Table -->
            <div id="usersSection" class="table-responsive mt-3">
                <table class="table table-bordered table-hover" id="userTable">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>

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

                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>

<!-- Chart JS -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    // ✅ FIXED CHART (no string error)
    const students = <%= totalStudents %>;
    const faculty = <%= totalFaculty %>;

    new Chart(document.getElementById("chart"), {
        type: 'bar',
        data: {
            labels: ["Students", "Faculty"],
            datasets: [{
                label: "Users",
                data: [students, faculty]
            }]
        }
    });

    // 🌙 Dark Mode
    function toggleDarkMode(){
        document.body.classList.toggle("dark");
    }

    // 🔍 Search Filter
    document.getElementById("search").addEventListener("keyup", function(){
        let filter = this.value.toLowerCase();
        let rows = document.querySelectorAll("#userTable tbody tr");

        rows.forEach(row => {
            row.style.display = row.innerText.toLowerCase().includes(filter) ? "" : "none";
        });
    });
</script>

</body>
</html>
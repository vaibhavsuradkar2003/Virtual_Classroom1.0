<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Register</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

/* 🌄 BACKGROUND */
body {
    height:100vh;
    background: url('https://images.unsplash.com/photo-1498050108023-c5249f4df085') no-repeat center center fixed;
    background-size: cover;
    display:flex;
    align-items:center;
    justify-content:center;
    font-family:'Segoe UI';
    position:relative;
}

/* DARK OVERLAY */
body::before {
    content:"";
    position:absolute;
    width:100%;
    height:100%;
    background: rgba(0,0,0,0.6);
    top:0;
    left:0;
}

/* GLASS CARD */
.register-card {
    width:420px;
    padding:30px;
    border-radius:20px;
    background: rgba(255,255,255,0.15);
    backdrop-filter: blur(15px);
    box-shadow: 0 8px 40px rgba(0,0,0,0.3);
    color:white;
    position:relative;
    z-index:1;
}

/* TITLE */
.register-card h3 {
    text-align:center;
    margin-bottom:20px;
}

/* INPUT GROUP */
.input-group {
    margin-bottom:15px;
}

.input-group-text {
    background: rgba(255,255,255,0.3);
    border:none;
    color:white;
}

.form-control {
    background: rgba(255,255,255,0.2);
    border:none;
    color:white;
}

.form-control::placeholder {
    color:#eee;
}

/* BUTTON */
.btn-register {
    width:100%;
    border-radius:25px;
    background: linear-gradient(135deg,#667eea,#764ba2);
    border:none;
}

/* LINK */
a {
    color:#fff;
    text-decoration:none;
}

a:hover {
    text-decoration:underline;
}

/* SELECT */
select {
    background: rgba(255,255,255,0.2) !important;
    color: white !important;
    border: none !important;
    backdrop-filter: blur(10px);
}

/* dropdown options fix */
select option {
    background: #2c2f4a;
    color: white;
}

</style>

</head>

<body>

<div class="register-card">

    <h3>📝 Register</h3>

    <form action="register" method="post">

        <!-- NAME -->
        <div class="input-group">
            <span class="input-group-text">
                <i class="fa fa-user"></i>
            </span>
            <input type="text" name="name" class="form-control"
                   placeholder="Full Name" required>
        </div>

        <!-- EMAIL -->
        <div class="input-group">
            <span class="input-group-text">
                <i class="fa fa-envelope"></i>
            </span>
            <input type="email" name="email" class="form-control"
                   placeholder="Email Address" required>
        </div>

        <!-- PASSWORD -->
        <div class="input-group">
            <span class="input-group-text">
                <i class="fa fa-lock"></i>
            </span>
            <input type="password" name="password" class="form-control"
                   placeholder="Password" required>
        </div>

        <!-- ROLE -->
        <div class="input-group">
            <span class="input-group-text">
                <i class="fa fa-users"></i>
            </span>
            <select name="role" class="form-control" required>
                <option value="">Select Role</option>
                <option value="student">Student</option>
                <option value="faculty">Faculty</option>
            </select>
        </div>

        <!-- BUTTON -->
        <button class="btn btn-register text-white mt-3">Register</button>

    </form>

    <!-- LOGIN LINK -->
    <div class="text-center mt-3">
        <p>Already have an account? 
            <a href="login.jsp">Login</a>
        </p>
    </div>

</div>

</body>
</html>
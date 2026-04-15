<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

/* 🌄 BACKGROUND */
body {
    height:100vh;
    background: url('https://images.unsplash.com/photo-1518770660439-4636190af475') no-repeat center center fixed;
    background-size: cover;
    display:flex;
    align-items:center;
    justify-content:center;
    font-family:'Segoe UI';
}

/* 🌫️ GLASS CARD */
.login-card {
    width: 380px;
    padding: 30px;
    border-radius: 20px;
    background: rgba(255,255,255,0.15);
    backdrop-filter: blur(15px);
    box-shadow: 0 8px 40px rgba(0,0,0,0.3);
    color:white;
}

/* TITLE */
.login-card h3 {
    text-align:center;
    margin-bottom:20px;
}

/* INPUT */
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
.btn-login {
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

</style>

</head>

<body>

<div class="login-card">

    <h3>🔐 Login</h3>

    <form action="login" method="post">

        <!-- EMAIL -->
        <div class="input-group">
            <span class="input-group-text">
                <i class="fa fa-envelope"></i>
            </span>
            <input type="email" name="email" class="form-control"
                   placeholder="Enter Email" required>
        </div>

        <!-- PASSWORD -->
        <div class="input-group">
            <span class="input-group-text">
                <i class="fa fa-lock"></i>
            </span>
            <input type="password" name="password" class="form-control"
                   placeholder="Enter Password" required>
        </div>

        <!-- BUTTON -->
        <button class="btn btn-login text-white mt-3">Login</button>

    </form>

    <!-- REGISTER -->
    <div class="text-center mt-3">
        <p>Don't have an account? 
            <a href="register.jsp">Register</a>
        </p>
    </div>

</div>

</body>
</html>
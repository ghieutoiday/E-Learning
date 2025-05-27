<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            background: url('https://images.unsplash.com/photo-1516321497487-e288fb19713f?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80') no-repeat center center fixed;
            background-size: cover;
        }
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.3);
            filter: blur(5px);
            z-index: -1;
        }
        .header {
            background: linear-gradient(90deg, #00C4CC, #0097A7);
            padding: 15px 20px;
            display: flex;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            position: relative;
            z-index: 1;
        }
        .header img {
            height: 45px;
            margin-right: 20px;
        }
        .header nav {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            margin-right: 100px;
        }
        .header nav a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-size: 16px;
            transition: color 0.3s;
        }
        .header nav a:hover {
            color: #ffd700;
        }
        .header .user-icon {
            margin-left: auto;
            font-size: 24px;
            color: white;
            display: flex;
            align-items: center;
        }
        .header .user-icon svg {
            width: 24px;
            height: 24px;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-grow: 1;
            position: relative;
            z-index: 1;
            padding: 0 30px;
        }
        .change-password {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            max-width: 450px;
            width: 100%;
            margin: 0 auto;
            text-align: center;
        }
        .change-password h2 {
            color: #333;
            margin-bottom: 30px;
            font-size: 26px;
        }
        .change-password input {
            width: 100%;
            padding: 14px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 15px;
            transition: border-color 0.3s;
            box-sizing: border-box;
        }
        .change-password input:focus {
            border-color: #00C4CC;
            outline: none;
        }
        .change-password button {
            background: linear-gradient(90deg, #00C4CC, #0097A7);
            color: white;
            padding: 0;
            width: 100px;
            height: 40px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
            line-height: 40px;
            margin-left: auto;
        }
        .change-password button:hover {
            background: linear-gradient(90deg, #0097A7, #007f8c);
        }

        /* Style cho thông báo */
        .notification {
            background: linear-gradient(90deg, #00C4CC, #0097A7);
            color: white;
            padding: 0 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            font-size: 14px;
            min-width: 250px; /* Kéo dài thêm để hiển thị đủ nội dung */
            height: 40px;
            line-height: 40px;
            text-align: left;
            display: inline-block;
            white-space: nowrap; /* Ngăn ngắt dòng */
            overflow: visible; /* Đảm bảo nội dung không bị cắt */
        }
        .notification::before {
            content: "!";
            display: inline-block;
            width: 16px;
            height: 16px;
            background-color: #007f8c;
            border-radius: 50%;
            text-align: center;
            line-height: 16px;
            margin-right: 8px;
            font-weight: bold;
            vertical-align: middle;
        }

        /* Sắp xếp thông báo và nút Save trong cùng một hàng */
        .change-password form {
            display: flex;
            flex-direction: column;
            align-items: stretch;
        }
        .change-password .button-row {
            display: flex;
            align-items: center;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div class="header">
        <img src="logo-f5-edu.jpg" alt="F5 EDU Logo" height="45"> <!-- Thêm ảnh logo của bạn tại đây -->
        <nav>
            <a href="#">Home</a>
            <a href="#">Page</a>
            <a href="#">Our Course</a>
            <a href="#">Blog</a>
        </nav>
        <span class="user-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                <circle cx="12" cy="7" r="4"></circle>
            </svg>
        </span>
    </div>
    <div class="container">
        <div class="change-password">
            <h2>Change Password</h2>
            <form method="post" action="usercontroller">
                <input type="hidden" name="action" value="changePassword">
                <input type="email" name="email" value="" placeholder="Email" required><br>
                <input type="password" name="password" value="" placeholder="Old Password" required><br>
                <input type="password" name="newPassword" value="" placeholder="New Password" required><br>
                <input type="password" name="confirmPassword" value="" placeholder="Password Confirm" required><br>
                <div class="button-row">
                    <c:if test="${not empty requestScope.mess}">
                        <div class="notification">${requestScope.mess}</div>
                    </c:if>
                    <button type="submit">Save</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
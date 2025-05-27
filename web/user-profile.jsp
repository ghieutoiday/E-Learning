<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Profile</title>
        <%-- Link Font Awesome để hiển thị icon bút chì --%>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                background-color: #f0f2f5; /* Một màu xám nhạt hơn, hiện đại hơn */
                color: #333;
                display: flex;
                flex-direction: column;
                align-items: center;
                min-height: 100vh;
                padding: 20px; /* Thêm padding cho body */
                box-sizing: border-box;
            }

            .page-title-container {
                width: 100%; /* Chiếm toàn bộ chiều rộng của vùng chứa cha */
                max-width: 750px; /* Tăng nhẹ max-width */
                margin-bottom: 25px; /* Tăng khoảng cách */
            }

            .page-title-text {
                font-family: 'Times New Roman', Times, serif; /* Giữ nguyên font cho tiêu đề lớn */
                font-size: 2em; /* Tăng nhẹ kích thước */
                color: #1d3557; /* Một màu xanh đậm cho tiêu đề */
                font-weight: bold;
            }

            .profile-card {
                display: flex;
                width: 100%; /* Chiếm toàn bộ chiều rộng của vùng chứa cha */
                max-width: 750px; /* Đồng bộ với page-title-container */
                background-color: #4a4a4a; /* Giữ màu sidebar */
                box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1); /* Shadow mềm mại hơn */
                border-radius: 10px; /* Bo góc lớn hơn một chút */
                overflow: hidden; /* Đảm bảo các con không tràn ra ngoài border-radius */
            }

            .sidebar {
                color: white;
                background-color: #343a40; /* Màu xám đậm hơn cho sidebar */
                padding: 30px 20px;
                width: 220px; /* Tăng nhẹ chiều rộng sidebar */
                text-align: center;
                display: flex;
                flex-direction: column;
                align-items: center;
                /* border-top-left-radius và border-bottom-left-radius được xử lý bởi .profile-card overflow:hidden */
            }

            .avatar-placeholder {
                width: 110px; /* Tăng kích thước avatar */
                height: 110px;
                border-radius: 50%;
                background-color: #6c757d; /* Màu nền cho avatar */
                display: flex;
                justify-content: center;
                align-items: center;
                margin-bottom: 20px; /* Tăng khoảng cách */
                border: 4px solid #ffffff; /* Border trắng nổi bật hơn */
                overflow: hidden;
            }

            .avatar-placeholder img {
                width: 100%; /* Cho ảnh SVG/placeholder fill hoàn toàn */
                height: 100%;
                object-fit: cover; /* Đảm bảo ảnh che phủ mà không bị méo */
                opacity: 0.8; /* Giảm nhẹ opacity nếu muốn */
            }

            .user-name {
                font-size: 1.3em; /* Tăng kích thước tên */
                font-weight: bold;
                margin-top: 5px;
                color: #f8f9fa; /* Màu trắng sáng hơn cho tên */
            }

            /* CSS cho phần .update (form) - Kế thừa từ .main-content style */
            .update {
                flex-grow: 1;
                background-color: #ffffff;
                padding: 30px 40px; /* Tăng padding cho form */
                /* border-radius được xử lý bởi .profile-card overflow:hidden */
                box-sizing: border-box;
            }

            .update h2 { /* Tiêu đề cho form nếu có, ví dụ: "Edit Profile" */
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* Font hiện đại hơn */
                font-size: 1.75em;
                font-weight: 600; /* Semi-bold */
                margin-top: 0;
                margin-bottom: 30px;
                color: #2c3e50; /* Màu chữ tiêu đề form */
            }

            .update .tablee {
                width: 100%;
                border-collapse: collapse;
            }

            .update .tablee td {
                padding: 10px 5px; /* Giữ padding vừa phải */
                vertical-align: middle;
                border-bottom: 1px solid #e9ecef; /* Đường kẻ mờ giữa các hàng */
            }
            .update .tablee tr:last-child td {
                border-bottom: none; /* Bỏ đường kẻ cho hàng cuối cùng */
            }


            .update .tablee tr td.text:first-child { /* Label cells */
                font-weight: 600; /* Semi-bold cho label */
                color: #495057; /* Màu chữ label */
                width: 110px; /* Điều chỉnh độ rộng label */
                text-align: right;
                padding-right: 20px; /* Tăng khoảng cách label và input */
            }

            .update input[type="text"],
            .update input[type="email"], /* Input email nếu bạn thêm */
            .update input[type="file"] {
                width: 100%; /* Input chiếm toàn bộ cell */
                padding: 10px 12px; /* Padding cho input */
                border: 1px solid #ced4da; /* Border màu xám nhạt */
                border-radius: 5px; /* Bo góc input */
                box-sizing: border-box;
                font-size: 0.95em;
                color: #495057;
                transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
            }

            .update input[type="text"]:focus,
            .update input[type="email"]:focus {
                border-color: #80bdff; /* Màu border khi focus */
                box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25); /* Shadow nhẹ khi focus */
                outline: none;
            }

            .update input::placeholder { /* Kiểu cho placeholder */
                color: #adb5bd;
                opacity: 1;
            }

            .update input[type="file"] {
                padding: 8px 12px; /* Điều chỉnh padding cho input file */
            }
            .update input[type="file"]::-webkit-file-upload-button { /* Kiểu nút browse cho Chrome/Edge */
                background-color: #e9ecef;
                color: #495057;
                border: none;
                padding: 8px 12px;
                border-radius: 4px;
                margin-right: 10px;
                cursor: pointer;
            }
            .update input[type="file"]::-moz-file-upload-button { /* Kiểu nút browse cho Firefox */
                background-color: #e9ecef;
                color: #495057;
                border: none;
                padding: 8px 12px;
                border-radius: 4px;
                margin-right: 10px;
                cursor: pointer;
            }


            .update .tablee input[type="radio"] {
                margin-right: 5px;
                vertical-align: middle;
                accent-color: #007bff; /* Màu cho radio button khi được chọn */
            }

            .update .tablee label { /* Label cho radio button */
                margin-right: 20px;
                font-weight: normal;
                color: #495057;
                vertical-align: middle;
                cursor: pointer; /* Cho biết label có thể click */
            }

            .update input[type="submit"] {
                background-color: #007bff;
                color: white;
                padding: 10px 25px; /* Tăng padding nút */
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 1em;
                font-weight: 600; /* Semi-bold */
                transition: background-color 0.2s ease-in-out, transform 0.1s ease;
            }

            .update input[type="submit"]:hover {
                background-color: #0056b3;
                transform: translateY(-1px); /* Hiệu ứng nhấc nhẹ khi hover */
            }
            .update input[type="submit"]:active {
                transform: translateY(0px); /* Hiệu ứng nhấn xuống */
            }

            .update .tablee tr.submit td:first-child {
                text-align: left;
            }

            .update .mess {
                display: inline-block; /* Để padding có tác dụng */
                margin-left: 15px; /* Khoảng cách từ nút */
                padding: 8px 0; /* Padding cho message */
                font-style: normal; /* Bỏ italic */
                font-size: 0.9em;
                color: #dc3545;
                font-weight: 500;
            }
            .update .mess.success {
                color: #28a745;
            }

            /* CSS cho phần hiển thị thông tin (nếu bạn có) - .main-content */
            /* Các rule .info-field, .edit-icon bạn đã có có thể giữ nguyên hoặc điều chỉnh tương tự */
            .main-content { /* Nếu bạn dùng lại class này cho phần hiển thị thông tin */
                flex-grow: 1;
                background-color: #ffffff;
                padding: 30px 40px;
                border-top-right-radius: 10px;
                border-bottom-right-radius: 10px;
            }

            .main-content h2 {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                font-size: 2.2em; /* Kích thước chữ "About" (ví dụ) */
                font-weight: 600;
                margin-top: 0;
                margin-bottom: 30px;
                color: #2c3e50;
            }

            .info-field {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
                font-size: 1em;
                padding: 10px 0;
                border-bottom: 1px solid #f0f2f5; /* Đường kẻ phân cách nhẹ nhàng */
            }
            .info-field:last-child {
                border-bottom: none;
            }

            .info-field .label {
                width: 100px; /* Độ rộng label */
                font-weight: 600; /* Label đậm hơn */
                color: #555;
                margin-right: 15px;
            }

            .info-field .value {
                flex-grow: 1;
                color: #333;
            }

            .edit-icon {
                color: #007bff; /* Màu icon edit */
                font-size: 1.1em;
                cursor: pointer;
                margin-left: 15px; /* Tăng khoảng cách */
                transition: color 0.2s ease;
            }
            .edit-icon:hover {
                color: #0056b3; /* Màu đậm hơn khi hover */
            }

        </style>
    </head>
    <body>
        <div class="page-title-container">
            <div class="page-title-text">User Profile</div>
        </div>

        <div class="profile-card">
            <div class="sidebar">
                <div class="avatar-placeholder">
                    <%-- 
                        Để hiển thị ảnh Canva như trong hình, bạn cần có file ảnh đó.
                        Ví dụ: <img src="${pageContext.request.contextPath}/images/canva-placeholder.png" alt="Avatar Placeholder"> 
                        Nếu không, đây là một SVG placeholder đơn giản:
                    --%>
                    <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgdmlld0JveD0iMCAwIDEwMCAxMDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CiAgPGNpcmNsZSBjeD0iNTAiIGN5PSI1MCIgcj0iNDAiIGZpbGw9IiNlMGUwZTAiLz4KICA8Y2lyY2xlIGN4PSI1MCIgY3k9IjQwIiByPSIxNSIgZmlsbD0iI2NjYyIvPgogIDxwYXRoIGQ9Ik0zMCA3NSBDMzAgNjAgNzAgNjAgNzAgNzUgWiIgZmlsbD0iI2NjYyIvPgo8L3N2Zz4=" alt="Avatar Placeholder">
                </div>
                <%-- Thay "The Hung" bằng dữ liệu động từ request hoặc session nếu có --%>
                <%-- Ví dụ: <div class="user-name">${currentUser.fullName != null ? currentUser.fullName : 'The Hung'}</div> --%>
                <div class="user-name">
                    <form action="UserDAO" method="post">
                        ${sessionScope.users.getFullName()}
                    </form>
                </div>
            </div>

            <div class="update">
                <form action="userDAO" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="acction" value="edit">
                    <table class="tablee">
                        <tbody>

                        <div class="input-box">
                            <tr>
                                <td class="text">Full Name: </td>
                                <td class="text"><input type="text" name="fullname" value="${sessionScope.users.getFullName()}" placeholder="Enter your full name"></td>
                            </tr>
                        </div>

                        <div class="input-box">
                            <tr>
                                <td class="text">Sex: </td>
                                <td><input type="radio" id="male" name="gender" value="Male">
                                    <label for="male">Male</label>

                                    <input type="radio" id="female" name="gender" value="Female">
                                    <label for="female">Female</label>

                                    <input type="radio" id="other" name="gender" value="Other">
                                    <label for="other">Other</label><br></td>
                            </tr>

                        </div>

                        <div class="input-box">
                            <tr>
                                <td class="text">Email: </td>
                                <td class="text"><input type="text" name="email" value="${sessionScope.users.getEmail()}" placeholder="Enter your email"></td>
                            </tr>
                        </div>
                        <div class="input-box">
                            <tr>
                                <td class="text">Mobile: </td>
                                <td class="text"><input type="text" name="email" value="${sessionScope.users.getMobile()}" placeholder="Enter your mobile"></td>
                            </tr>
                        </div>

                        <tr class="image">
                            <td class="text">Image</td>
                            <td class="text"><input type="file" name="file" id="file" accept="image/*"></td>
                        </tr>
                        <tr class="submit">
                        <div class="btn">
                            <td><input type="submit" value="Update"></td>
                        </div>
                        <td class="mess">${requestScope.mess}</td>
                        </tr>

                        </tbody>
                    </table>

                </form>
            </div>


        </div>
    </body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>User Details</title>
        <style>
            /* CSS hiện tại của bạn (đã được cung cấp ở các lượt trước) */
            body {
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
                margin: 0;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh; 
                padding: 20px 0; 
                line-height: 1.6; 
                color: #333;
            }
            .container {
                background-color: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                width: 80%; 
                max-width: 700px; 
                display: flex;
                flex-direction: column; 
                align-items: center; 
            }
            h1 {
                color: #333;
                margin-bottom: 20px;
                font-size: 2em;
                text-align: center;
                font-weight: 600;
            }
            .user-info-section {
                display: flex;
                width: 100%;
                gap: 30px; 
                margin-top: 20px; 
                flex-wrap: wrap; 
                /* THAY ĐỔI: Căn các item lên trên nếu chúng không cao bằng nhau */
                align-items: flex-start; 
                justify-content: center; 
            }
            .avatar-section { /* THÊM MỚI: Wrapper cho avatar và tên */
                display: flex;
                flex-direction: column;
                align-items: center;
                flex: 0 0 150px; /* Giữ kích thước cho phần avatar */
                 margin-bottom: 15px; /* Khoảng cách nếu details-box xuống dòng trên mobile */
            }
            .avatar-container {
                /* flex: 0 0 150px; */ /* Chuyển flex-basis ra avatar-section */
                width: 150px; /* Kích thước cố định */
                height: 150px;
                border-radius: 50%; 
                overflow: hidden; 
                background-color: #e9ecef; 
                display: flex;
                justify-content: center;
                align-items: center;
                border: 2px solid #dee2e6; 
                margin-bottom: 10px; /* Khoảng cách giữa avatar và tên */
            }
            .avatar-container img {
                width: 100%;
                height: 100%;
                object-fit: cover; 
            }
            .avatar-container .default-avatar {
                font-size: 80px; 
                color: #adb5bd; 
            }
            .user-name-under-avatar { /* THÊM MỚI: CSS cho tên dưới avatar */
                font-size: 1.2em;
                font-weight: 600;
                color: #333;
                text-align: center;
                margin-top: 5px; /* Điều chỉnh khoảng cách với avatar nếu cần */
            }
            .details-box {
                flex: 1; 
                background-color: #f8f9fa; 
                padding: 25px; 
                border-radius: 8px;
                color: #343a40; 
                box-sizing: border-box; 
                display: flex;
                flex-direction: column;
                justify-content: center;
                min-width: 300px; 
                border: 1px solid #e9ecef; 
            }
            .details-box p {
                margin: 12px 0; 
                font-size: 1rem; 
                display: flex;
                align-items: baseline; 
                line-height: 1.5; 
                flex-wrap: wrap;
            }
            .details-box p .detail-label {
                display: inline-block;
                width: 110px; 
                color: #495057; 
                font-weight: 600; 
                flex-shrink: 0;
                margin-right: 15px; 
                text-align: right;
            }
            .details-box p .value-text, 
            .details-box p select { 
                flex-grow: 1;
                word-wrap: break-word;
                box-sizing: border-box; 
                color: #212529; 
            }
             .details-box select { 
                padding: 8px 10px; 
                border: 1px solid #ced4da; 
                border-radius: 4px;
                font-size: 0.95rem; 
                min-width: 150px; 
                background-color: #fff; 
                color: #495057; 
            }
            .details-box p strong { 
                font-weight: 600; 
            }
            .actions {
                margin-top: 30px;
                text-align: center;
                width: 100%;
                display: flex;
                justify-content: center;
                gap: 15px;
                flex-wrap: wrap;
            }
            .actions a, .actions button {
                display: inline-block;
                padding: 10px 22px; 
                text-decoration: none;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.2s ease, transform 0.1s ease; 
                font-size: 0.95rem; 
                font-weight: 500; 
                white-space: nowrap;
            }
            .actions a:hover, .actions button:hover {
                opacity: 0.9; 
            }
            .actions a:active, .actions button:active {
                transform: scale(0.98); 
            }
            .actions .save-button { 
                 background-color: #28a745; 
            }
            .actions .save-button:hover {
                 background-color: #218838; 
                 opacity: 1; 
            }
            .actions .back-button { 
                background-color: #007bff;
            }
            .actions .back-button:hover {
                background-color: #0056b3; 
                opacity: 1; 
            }
            .error-message, .success-message {
                text-align: center;
                margin-top: 20px; 
                margin-bottom: 15px;
                width: 100%;
                padding: 12px 15px; 
                border-radius: 5px;
                box-sizing: border-box;
                font-size: 0.95rem; 
            }
            .error-message {
                color: #721c24;
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
            }
            .success-message {
                color: #155724;
                background-color: #d4edda;
                border: 1px solid #c3e6cb;
            }
            @media (max-width: 768px) {
                body { padding: 15px 0; }
                .container { width: 95%; padding: 20px; }
                h1 { font-size: 1.6em; }
                .user-info-section {  align-items: center; gap: 20px; } /* Giữ lại flex-direction: column; nếu muốn xếp chồng avatar và details-box*/
                .avatar-section { /* Điều chỉnh cho mobile */
                    flex-basis: auto; /* Cho phép co giãn */
                    width: 100%; /* Chiếm hết chiều rộng nếu xếp chồng */
                    margin-bottom: 20px;
                }
                .avatar-container { flex-basis: 120px; height: 120px; margin-left:auto; margin-right:auto; /* Căn giữa avatar trong .avatar-section */}
                .avatar-container .default-avatar { font-size: 60px; }
                .details-box { min-width: unset; width: 100%; margin-top: 0; padding: 15px; }
                .details-box p { margin: 8px 0; font-size: 0.95rem; }
                .details-box p .detail-label { width: 100%; text-align: left; margin-right: 0; margin-bottom: 3px; font-weight: 500; }
                .details-box p { flex-direction: column; align-items: flex-start; }
                .details-box select { width: 100%; font-size: 0.9rem; padding: 8px; }
                .actions { gap: 10px; }
                .actions a, .actions button { font-size: 0.9rem; padding: 10px 15px; }
            }
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
        <div class="container">
            <h1>User Details</h1>

            <c:if test="${not empty successMessage}">
                <p class="success-message"><c:out value="${successMessage}"/></p>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <p class="error-message"><c:out value="${errorMessage}"/></p>
            </c:if>

            <c:if test="${user != null}">
                <form method="POST" action="${pageContext.request.contextPath}/viewUser" style="width:100%;">
                    <input type="hidden" name="action" value="updateRoleStatus">
                    <input type="hidden" name="userID" value="${user.userID}">

                    <div class="user-info-section">
                        <%-- BỌC AVATAR VÀ TÊN VÀO CHUNG MỘT KHỐI ĐỂ DỄ QUẢN LÝ LAYOUT --%>
                        <div class="avatar-section">
                            <div class="avatar-container">
                                <c:choose>
                                    <c:when test="${user.avatar != null && !user.avatar.isEmpty()}">
                                        <img src="<c:out value="${user.avatar}"/>" alt="User Avatar">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-user-circle default-avatar"></i>
                                    </c:otherwise>    
                                </c:choose>
                            </div>
                            <%-- THÊM PHẦN HIỂN THỊ TÊN ĐẦY ĐỦ DƯỚI AVATAR --%>
                            <div class="user-name-under-avatar">
                                <c:out value="${user.fullName}"/>
                            </div>
                        </div>
                        
                        <div class="details-box">
                            <%-- Các trường thông tin khác giữ nguyên --%>
                            <p><label class="detail-label">Name:</label> <span class="value-text"><c:out value="${user.fullName}"/></span></p>
                            <p><label class="detail-label">Sex:</label> <span class="value-text"><c:out value="${user.gender}"/></span></p>
                            <p><label class="detail-label">E-Mail:</label> <span class="value-text"><c:out value="${user.email}"/></span></p>
                            <p><label class="detail-label">Mobile:</label> <span class="value-text"><c:out value="${user.mobile}"/></span></p>
                            
                            <p>
                                <label class="detail-label" for="roleID"><strong>Role:</strong></label>
                                <select name="roleID" id="roleID">
                                    <c:if test="${empty roles}">
                                        <option value="">No roles available</option>
                                    </c:if>
                                    <c:forEach var="roleItem" items="${roles}">
                                        <option value="${roleItem.roleID}" 
                                                <c:if test="${user.role != null && user.role.roleID == roleItem.roleID}">selected</c:if> >
                                            <c:out value="${roleItem.roleName}"/>
                                        </option>
                                    </c:forEach>
                                </select>
                            </p>

                            <p><label class="detail-label">Address:</label> <span class="value-text"><c:out value="${user.address}"/></span></p>

                            <p>
                                <label class="detail-label" for="status"><strong>Status:</strong></label>
                                <select name="status" id="status">
                                    <option value="Active" ${user.status == 'Active' ? 'selected' : ''}>Active</option>
                                    <option value="Inactive" ${user.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                    <%-- Bỏ option Pending nếu chỉ có Active/Inactive --%>
                                    <%-- <option value="Pending" ${user.status == 'Pending' ? 'selected' : ''}>Pending</option> --%>
                                </select>
                            </p>
                        </div>
                    </div>

                    <div class="actions">
                        <button type="submit" class="save-button">Update Role & Status</button>
                        <a href="${pageContext.request.contextPath}/userController" class="back-button">Back to User List</a>
                    </div>
                </form>
            </c:if>

            <c:if test="${user == null && empty successMessage && empty errorMessage}">
                <p class="error-message">User not found.</p>
                <div class="actions">
                    <a href="${pageContext.request.contextPath}/userController" class="back-button">Back to User List</a>
                </div>
            </c:if>
        </div>
    </body>
</html>
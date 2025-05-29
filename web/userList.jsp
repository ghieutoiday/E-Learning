<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>User List</title>
    <style>
        /* CSS cho form l?c */
        .filter-form {
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #eee;
            border-radius: 5px;
            background-color: #f9f9f9;
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }
        .filter-form input[type="text"],
        .filter-form select,
        .filter-form button {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .filter-form button {
            background-color: #007bff;
            color: white;
            cursor: pointer;
            border: none;
        }
        .filter-form button:hover {
            background-color: #0056b3;
        }

        /* CSS cho b?ng */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }

        /* Style cho các header có th? s?p x?p */
        .sortable-header {
            position: relative; /* ?? ??nh v? icon */
            padding-right: 25px; /* T?o không gian cho icon m?i tên */
        }

        .sortable-header a {
            text-decoration: none;
            color: black;
            display: block; /* ??m b?o toàn b? khu v?c header có th? nh?p ???c */
            padding-right: 0; /* B? padding-right c? c?a a n?u có */
        }

        .sort-icon {
            position: absolute; /* ??nh v? tuy?t ??i */
            right: 5px; /* Cách l? ph?i */
            top: 50%; /* C?n gi?a theo chi?u d?c */
            transform: translateY(-50%); /* D?ch chuy?n lên 50% chi?u cao c?a chính nó */
            font-size: 0.9em; /* Kích th??c icon */
            color: #888; /* Màu icon m?c ??nh */
            transition: color 0.2s ease; /* Hi?u ?ng chuy?n ??ng m??t mà */
        }

        .sortable-header:hover .sort-icon {
            color: #000; /* Màu icon khi hover */
        }

        .sortable-header a.active-sort .sort-icon { /* Màu cho icon c?a c?t ?ang sort */
            color: #007bff; /* Màu xanh d??ng cho icon active */
        }


        /* CSS cho phân trang */
        .pagination {
            margin-top: 30px;
            text-align: center;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
        }

        .pagination a {
            margin: 0;
            padding: 10px 18px;
            text-decoration: none;
            color: #333;
            background-color: #f8f9fa;
            border: 1px solid #ced4da;
            border-radius: 6px;
            transition: all 0.3s ease;
            min-width: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .pagination a:hover:not(.active) {
            background-color: #e2e6ea;
            color: #000;
            border-color: #dae0e5;
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .pagination a.active {
            background-color: #007bff;
            color: white;
            border: 1px solid #007bff;
            font-weight: bold;
            cursor: default;
            box-shadow: 0 2px 5px rgba(0, 123, 255, 0.2);
        }

        .pagination a.active:hover {
            background-color: #007bff;
            color: white;
            transform: none;
            box-shadow: 0 2px 5px rgba(0, 123, 255, 0.2);
        }

        .pagination a:first-child,
        .pagination a:last-child {
            padding: 10px 20px;
        }

        /* CSS cho liên k?t v? trang ch? */
        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px; /* Kho?ng cách v?i form l?c */
        }
        .home-link, .action-button {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
            padding: 8px 15px;
            border: 1px solid #007bff;
            border-radius: 5px;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .home-link:hover, .action-button:hover {
            background-color: #007bff;
            color: white;
        }
        .action-button {
            background-color: #28a745; /* Green for add */
            border-color: #28a745;
            color: white;
        }
        .action-button:hover {
            background-color: #218838;
        }

        /* Add User Form Styling */
        .add-user-form-container {
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 20px;
            background-color: #f9f9f9;
        }
        .add-user-form-container h2 {
            margin-top: 0;
        }
        .add-user-form-container label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .add-user-form-container input[type="text"],
        .add-user-form-container input[type="email"],
        .add-user-form-container input[type="password"],
        .add-user-form-container select {
            width: calc(100% - 22px); /* Account for padding and border */
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .add-user-form-container .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 15px;
        }
        .add-user-form-container .form-row > div {
            flex: 1;
        }
        .add-user-form-container .form-row input,
        .add-user-form-container .form-row select {
             width: calc(100% - 22px); /* For two columns */
             margin-bottom: 0;
        }

        .add-user-form-container button[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .add-user-form-container button[type="submit"]:hover {
            background-color: #0056b3;
        }
        .message {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
            text-align: center;
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

    </style>
</head>
<body>
    <div class="header-section">
        <a href="index.jsp" class="home-link">Home</a>
        <h1>All Users</h1>
        <button id="toggleAddUserFormBtn" class="action-button">Add New User</button>
    </div>

    <%-- Display Success/Error Messages --%>
    <c:if test="${not empty pageSuccessMessage}">
        <div class="message success-message">${pageSuccessMessage}</div>
    </c:if>
    <c:if test="${not empty pageErrorMessage}">
        <div class="message error-message">${pageErrorMessage}</div>
    </c:if>

    <%-- Add User Form Container (initially hidden) --%>
    <div id="addUserFormContainer" class="add-user-form-container" style="display: ${showAddUserFormOnErrorForJSP == true ? 'block' : 'none'};">
        <h2>Add New User</h2>
        <form action="userController" method="POST">
            <input type="hidden" name="formAction" value="addUser">
            <%-- Include current query string to maintain filter/sort/page state after redirect --%>
            <input type="hidden" name="currentQueryString" value="${pageContext.request.queryString != null ? pageContext.request.queryString.replaceAll('&?formAction=addUser','').replaceAll('formAction=addUser&?','') : ''}">

            <div class="form-row">
                <div>
                    <label for="newUser_fullName">Full Name*:</label>
                    <input type="text" id="newUser_fullName" name="newUser_fullName" value="${sessionScope.input_newUser_fullName != null ? sessionScope.input_newUser_fullName : ''}" required>
                </div>
                <div>
                    <label for="newUser_email">Email*:</label>
                    <input type="email" id="newUser_email" name="newUser_email" value="${sessionScope.input_newUser_email != null ? sessionScope.input_newUser_email : ''}" required>
                </div>
            </div>

            <label for="newUser_password">Password*:</label>
            <input type="password" id="newUser_password" name="newUser_password" required>

            <div class="form-row">
                <div>
                    <label for="newUser_gender">Gender:</label>
                    <select id="newUser_gender" name="newUser_gender">
                        <option value="Male" ${sessionScope.input_newUser_gender == 'Male' ? 'selected' : ''}>Male</option>
                        <option value="Female" ${sessionScope.input_newUser_gender == 'Female' ? 'selected' : ''}>Female</option>
                        <option value="Other" ${sessionScope.input_newUser_gender == 'Other' ? 'selected' : ''}>Other</option>
                    </select>
                </div>
                <div>
                    <label for="newUser_mobile">Mobile:</label>
                    <input type="text" id="newUser_mobile" name="newUser_mobile" value="${sessionScope.input_newUser_mobile != null ? sessionScope.input_newUser_mobile : ''}">
                </div>
            </div>

            <label for="newUser_address">Address:</label>
            <input type="text" id="newUser_address" name="newUser_address" value="${sessionScope.input_newUser_address != null ? sessionScope.input_newUser_address : ''}">
            
            <div class="form-row">
                <div>
                    <label for="newUser_roleID">Role*:</label>
                    <select id="newUser_roleID" name="newUser_roleID" required>
                        <option value="">-- Select Role --</option>
                        <c:forEach var="role" items="${rolesList}">
                            <option value="${role.roleID}" ${sessionScope.input_newUser_roleID == role.roleID ? 'selected' : ''}>
                                ${role.roleName}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label for="newUser_status">Status:</label>
                    <select id="newUser_status" name="newUser_status">
                        <option value="Active" ${sessionScope.input_newUser_status == 'Active' ? 'selected' : ''}>Active</option>
                        <option value="Inactive" ${sessionScope.input_newUser_status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>
            </div>
            
            <%-- Avatar is excluded as per requirement --%>
            <%-- <label for="newUser_avatar">Avatar URL:</label> --%>
            <%-- <input type="text" id="newUser_avatar" name="newUser_avatar" value="${sessionScope.input_newUser_avatar != null ? sessionScope.input_newUser_avatar : ''}"> --%>

            <button type="submit">Submit New User</button>
        </form>
    </div>

    <script>
        document.getElementById('toggleAddUserFormBtn').addEventListener('click', function() {
            var formContainer = document.getElementById('addUserFormContainer');
            if (formContainer.style.display === 'none' || formContainer.style.display === '') {
                formContainer.style.display = 'block';
                this.textContent = 'Cancel Adding User';
            } else {
                formContainer.style.display = 'none';
                this.textContent = 'Add New User';
            }
        });
    </script>

    <form action="userController" method="GET" class="filter-form">
        <input type="text" name="search" placeholder="Search by name, email, mobile"
               value="${searchValue != null ? searchValue : ''}">

        <select name="gender">
            <option value="all" ${genderFilter == null || genderFilter == 'all' ? 'selected' : ''}>All Genders</option>
            <option value="Male" ${genderFilter == 'Male' ? 'selected' : ''}>Male</option>
            <option value="Female" ${genderFilter == 'Female' ? 'selected' : ''}>Female</option>
        </select>

        <select name="roleID">
            <option value="" ${roleIDFilter == null || roleIDFilter == '' ? 'selected' : ''}>All Roles</option> <%-- Ensure empty value for "All Roles" matches controller logic --%>
            <c:forEach var="role" items="${rolesList}">
                <option value="${role.roleID}" ${roleIDFilter != null && roleIDFilter == role.roleID ? 'selected' : ''}>
                    ${role.roleName}
                </option>
            </c:forEach>
        </select>

        <select name="status">
            <option value="all" ${statusFilter == null || statusFilter == 'all' ? 'selected' : ''}>All Statuses</option>
            <option value="Active" ${statusFilter == 'Active' ? 'selected' : ''}>Active</option>
            <option value="Inactive" ${statusFilter == 'Inactive' ? 'selected' : ''}>Inactive</option>
        </select>

        <button type="submit">Apply Filter</button>
    </form>

    <table class="user-table">
        <thead>
            <tr>
                <th class="sortable-header">
                    <a href="userController?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=userID&sortOrder=${sortBy == 'userID' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                       class="${sortBy == 'userID' ? 'active-sort' : ''}">
                        ID  
                        <span class="sort-icon">
                            <c:choose>
                                <c:when test="${sortBy == 'userID' && sortOrder == 'asc'}">&#9650;</c:when>   <%-- M?i tên lên khi sort ASC --%>
                                <c:when test="${sortBy == 'userID' && sortOrder == 'desc'}">&#9660;</c:when>  <%-- M?i tên xu?ng khi sort DESC --%>
                                <c:otherwise>&#9674;</c:otherwise> <%-- Hình thoi r?ng cho tr?ng thái m?c ??nh --%>
                            </c:choose>
                        </span>
                    </a>
                </th>
                <th class="sortable-header">
                    <a href="userController?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=fullName&sortOrder=${sortBy == 'fullName' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                       class="${sortBy == 'fullName' ? 'active-sort' : ''}">
                        Name
                        <span class="sort-icon">
                            <c:choose>
                                <c:when test="${sortBy == 'fullName' && sortOrder == 'asc'}">&#9650;</c:when>
                                <c:when test="${sortBy == 'fullName' && sortOrder == 'desc'}">&#9660;</c:when>
                                <c:otherwise>&#9674;</c:otherwise>
                            </c:choose>
                        </span>
                    </a>
                </th>
                <th class="sortable-header">
                    <a href="userController?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=gender&sortOrder=${sortBy == 'gender' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                       class="${sortBy == 'gender' ? 'active-sort' : ''}">
                        Sex
                        <span class="sort-icon">
                            <c:choose>
                                <c:when test="${sortBy == 'gender' && sortOrder == 'asc'}">&#9650;</c:when>
                                <c:when test="${sortBy == 'gender' && sortOrder == 'desc'}">&#9660;</c:when>
                                <c:otherwise>&#9674;</c:otherwise>
                            </c:choose>
                        </span>
                    </a>
                </th>
                <th class="sortable-header">
                    <a href="userController?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=email&sortOrder=${sortBy == 'email' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                       class="${sortBy == 'email' ? 'active-sort' : ''}">
                        Email
                        <span class="sort-icon">
                            <c:choose>
                                <c:when test="${sortBy == 'email' && sortOrder == 'asc'}">&#9650;</c:when>
                                <c:when test="${sortBy == 'email' && sortOrder == 'desc'}">&#9660;</c:when>
                                <c:otherwise>&#9674;</c:otherwise>
                            </c:choose>
                        </span>
                    </a>
                </th>
                <th class="sortable-header">
                    <a href="userController?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=mobile&sortOrder=${sortBy == 'mobile' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                       class="${sortBy == 'mobile' ? 'active-sort' : ''}">
                        Mobile
                        <span class="sort-icon">
                            <c:choose>
                                <c:when test="${sortBy == 'mobile' && sortOrder == 'asc'}">&#9650;</c:when>
                                <c:when test="${sortBy == 'mobile' && sortOrder == 'desc'}">&#9660;</c:when>
                                <c:otherwise>&#9674;</c:otherwise>
                            </c:choose>
                        </span>
                    </a>
                </th>
                <th class="sortable-header">
                    <a href="userController?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=roleID&sortOrder=${sortBy == 'roleID' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                       class="${sortBy == 'roleID' ? 'active-sort' : ''}">
                        Role
                        <span class="sort-icon">
                            <c:choose>
                                <c:when test="${sortBy == 'roleID' && sortOrder == 'asc'}">&#9650;</c:when>
                                <c:when test="${sortBy == 'roleID' && sortOrder == 'desc'}">&#9660;</c:when>
                                <c:otherwise>&#9674;</c:otherwise>
                            </c:choose>
                        </span>
                    </a>
                </th>
                <th class="sortable-header">
                    <a href="userController?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=status&sortOrder=${sortBy == 'status' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                       class="${sortBy == 'status' ? 'active-sort' : ''}">
                        Status
                        <span class="sort-icon">
                            <c:choose>
                                <c:when test="${sortBy == 'status' && sortOrder == 'asc'}">&#9650;</c:when>
                                <c:when test="${sortBy == 'status' && sortOrder == 'desc'}">&#9660;</c:when>
                                <c:otherwise>&#9674;</c:otherwise>
                            </c:choose>
                        </span>
                    </a>
                </th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${userList}">
                <tr>
                    <td>${user.userID}</td>
                    <td>${user.fullName}</td>
                    <td>${user.gender}</td>
                    <td>${user.email}</td>
                    <td>${user.mobile}</td>
                    <td>${user.role.roleName}</td>
                    <td>${user.status}</td>
                    <td>
                        <a href="viewUser?id=${user.userID}">View</a> 
                        <%-- Add other actions like Edit/Delete here if needed --%>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty userList}">
                <tr>
                    <td colspan="8">No users found.</td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="userController?page=${currentPage - 1}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=${sortBy != null ? sortBy : ''}&sortOrder=${sortOrder != null ? sortOrder : ''}">Previous</a>
        </c:if>
        <c:forEach begin="1" end="${totalPage}" var="i">
            <a class="${i == currentPage ? 'active' : ''}"
               href="userController?page=${i}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=${sortBy != null ? sortBy : ''}&sortOrder=${sortOrder != null ? sortOrder : ''}">
                ${i}
            </a>
        </c:forEach>
        <c:if test="${currentPage < totalPage}">
            <a href="userController?page=${currentPage + 1}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=${sortBy != null ? sortBy : ''}&sortOrder=${sortOrder != null ? sortOrder : ''}">Next</a>
        </c:if>
    </div>

</body>
</html>
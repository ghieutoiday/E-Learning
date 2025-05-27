<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                flex-wrap: wrap; /* Cho phép các ph?n t? xu?ng dòng n?u không ?? ch? */
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
            .sortable-header a {
                text-decoration: none;
                color: black;
                display: inline-block;
                width: 100%;
            }
            .sort-icon {
                margin-left: 5px;
                font-size: 0.8em;
                vertical-align: middle;
            }

            /* CSS cho phân trang */
            .pagination {
                margin-top: 30px; /* T?ng kho?ng cách v?i b?ng */
                text-align: center;
                font-family: Arial, sans-serif; /* Ch?n font d? ??c h?n */
                display: flex; /* Dùng flexbox ?? c?n gi?a và t?o kho?ng cách t? ??ng */
                justify-content: center; /* C?n các nút ra gi?a */
                align-items: center;
                gap: 8px; /* Kho?ng cách gi?a các nút */
            }

            .pagination a {
                margin: 0; /* B? margin c? ?? flexbox qu?n lý gap */
                padding: 10px 18px; /* T?ng padding ?? nút l?n h?n và d? ?n h?n */
                text-decoration: none;
                color: #333; /* Màu ch? t?i h?n cho d? ??c */
                background-color: #f8f9fa; /* N?n sáng */
                border: 1px solid #ced4da; /* Vi?n m?ng */
                border-radius: 6px; /* Bo góc nh? nhàng */
                transition: all 0.3s ease; /* Hi?u ?ng chuy?n ??ng m??t mà khi hover */
                min-width: 40px; /* ??m b?o chi?u r?ng t?i thi?u cho các s? trang */
                display: flex; /* Dùng flexbox ?? c?n gi?a n?i dung trong nút */
                justify-content: center;
                align-items: center;
            }

            .pagination a:hover:not(.active) {
                background-color: #e2e6ea; /* N?n t?i h?n khi di chu?t qua */
                color: #000; /* Ch? t?i h?n khi di chu?t qua */
                border-color: #dae0e5; /* Vi?n thay ??i màu */
                transform: translateY(-2px); /* Hi?u ?ng nh?c nh? nút lên */
                box-shadow: 0 2px 5px rgba(0,0,0,0.1); /* Thêm ?? bóng nh? */
            }

            .pagination a.active {
                background-color: #007bff; /* Màu n?n xanh d??ng n?i b?t cho trang hi?n t?i */
                color: white; /* Ch? tr?ng */
                border: 1px solid #007bff; /* Vi?n cùng màu n?n */
                font-weight: bold; /* Ch? in ??m */
                cursor: default; /* Không hi?n con tr? nh?p chu?t */
                box-shadow: 0 2px 5px rgba(0, 123, 255, 0.2); /* ?? bóng cho nút active */
            }

            .pagination a.active:hover {
                background-color: #007bff; /* Gi? nguyên màu khi hover trên nút active */
                color: white;
                transform: none; /* B? hi?u ?ng nh?c lên khi hover trên nút active */
                box-shadow: 0 2px 5px rgba(0, 123, 255, 0.2);
            }

            /* Các nút Previous/Next có th? r?ng h?n m?t chút n?u mu?n */
            .pagination a:first-child,
            .pagination a:last-child {
                padding: 10px 20px; /* Padding r?ng h?n cho Previous/Next */
            }
        </style>
    </head>
    <body>
        <h1>All Users</h1>

        <form action="userDAO" method="GET" class="filter-form">
            <input type="text" name="search" placeholder="Search by name, email, mobile"
                   value="${searchValue != null ? searchValue : ''}">

            <select name="gender">
                <option value="all" ${genderFilter == null || genderFilter == 'all' ? 'selected' : ''}>All Genders</option>
                <option value="Male" ${genderFilter == 'Male' ? 'selected' : ''}>Male</option>
                <option value="Female" ${genderFilter == 'Female' ? 'selected' : ''}>Female</option>
            </select>

            <select name="roleID">
                <option value="" ${roleIDFilter == null ? 'selected' : ''}>All Roles</option>
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
                        <a href="userDAO?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=userID&sortOrder=${sortBy == 'userID' && sortOrder == 'asc' ? 'desc' : 'asc'}">
                            ID
                            <c:if test="${sortBy == 'userID'}">
                                <span class="sort-icon">${sortOrder == 'asc' ? '&#9650;' : '&#9660;'}</span>
                            </c:if>
                        </a>
                    </th>
                    <th class="sortable-header">
                        <a href="userDAO?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=fullName&sortOrder=${sortBy == 'fullName' && sortOrder == 'asc' ? 'desc' : 'asc'}">
                            Name
                            <c:if test="${sortBy == 'fullName'}">
                                <span class="sort-icon">${sortOrder == 'asc' ? '&#9650;' : '&#9660;'}</span>
                            </c:if>
                        </a>
                    </th>
                    <th class="sortable-header">
                        <a href="userDAO?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=gender&sortOrder=${sortBy == 'gender' && sortOrder == 'asc' ? 'desc' : 'asc'}">
                            Sex
                            <c:if test="${sortBy == 'gender'}">
                                <span class="sort-icon">${sortOrder == 'asc' ? '&#9650;' : '&#9660;'}</span>
                            </c:if>
                        </a>
                    </th>
                    <th>Email</th>
                    <th>Mobile</th>
                    <th class="sortable-header">
                        <a href="userDAO?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=roleID&sortOrder=${sortBy == 'roleID' && sortOrder == 'asc' ? 'desc' : 'asc'}">
                            Role
                            <c:if test="${sortBy == 'roleID'}">
                                <span class="sort-icon">${sortOrder == 'asc' ? '&#9650;' : '&#9660;'}</span>
                            </c:if>
                        </a>
                    </th>
                    <th class="sortable-header">
                        <a href="userDAO?page=${currentPage}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=status&sortOrder=${sortBy == 'status' && sortOrder == 'asc' ? 'desc' : 'asc'}">
                            Status
                            <c:if test="${sortBy == 'status'}">
                                <span class="sort-icon">${sortOrder == 'asc' ? '&#9650;' : '&#9660;'}</span>
                            </c:if>
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
                            <a href="viewUser?id=${user.userID}">View</a> |
                            <a href="editUser?id=${user.userID}">Edit</a>
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
                <a href="userDAO?page=${currentPage - 1}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=${sortBy != null ? sortBy : ''}&sortOrder=${sortOrder != null ? sortOrder : ''}">Previous</a>
            </c:if>
            <c:forEach begin="1" end="${totalPage}" var="i">
                <a class="${i == currentPage ? 'active' : ''}"
                   href="userDAO?page=${i}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=${sortBy != null ? sortBy : ''}&sortOrder=${sortOrder != null ? sortOrder : ''}">
                    ${i}
                </a>
            </c:forEach>
            <c:if test="${currentPage < totalPage}">
                <a href="userDAO?page=${currentPage + 1}&search=${searchValue != null ? searchValue : ''}&gender=${genderFilter != null ? genderFilter : 'all'}&roleID=${roleIDFilter != null ? roleIDFilter : ''}&status=${statusFilter != null ? statusFilter : 'all'}&sortBy=${sortBy != null ? sortBy : ''}&sortOrder=${sortOrder != null ? sortOrder : ''}">Next</a>
            </c:if>
        </div>

    </body>
</html>
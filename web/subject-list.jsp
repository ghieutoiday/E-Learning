<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Subject List</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f9;
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 20px;
                background-color: #fff;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                height: 60px;
            }
            .header img {
                height: 40px;
            }
            .nav a {
                margin: 0 15px;
                text-decoration: none;
                color: #333;
                font-weight: bold;
            }
            .nav a:hover {
                color: #007bff;
            }
            .nav {
                margin-right: 90px;
            }
            .banner {
                background-color: #66b0ff;
                padding: 30px 30px;
                height: 80px;
                text-align: center;
                color: #fff;
                font-size: 32px;
                font-weight: bold;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .container {
                width: 90%;
                margin: 20px auto;
            }
            .filters {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }
            .filters select, .filters input[type="text"], .filters button {
                padding: 8px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .filters button {
                background-color: #007bff;
                color: #fff;
                border: none;
                cursor: pointer;
            }
            .filters button:hover {
                background-color: #0056b3;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                border: 1px solid #ddd;
            }
            th, td {
                padding: 12px;
                text-align: left;
                border: 1px solid #ddd;
            }
            th {
                background-color: #d9eaff;
                font-weight: bold;
            }
            .action a {
                color: #007bff;
                text-decoration: none;
            }
            .action a:hover {
                text-decoration: underline;
            }
            .pagination {
                text-align: center;
                margin-top: 20px;
            }
            .pagination a {
                padding: 8px 12px;
                margin: 0 5px;
                text-decoration: none;
                color: #007bff;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .pagination a.active {
                background-color: #007bff;
                color: #fff;
                border: none;
            }
            .pagination a:hover {
                background-color: #e9ecef;
            }
            .user-icon {
                width: 30px;
                height: 30px;
                color: #000;
            }
            .user-icon svg {
                width: 100%;
                height: 100%;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="logo">
                <img src="path_to_your_logo.png" alt="F5 EDU Logo">
            </div>
            <div class="nav">
                <a href="#">Home</a>
                <a href="#">Page</a>
                <a href="#">Our Course</a>
                <a href="#">Blog</a>
            </div>
            <div class="user">
                <div class="user-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                    <circle cx="12" cy="7" r="4"></circle>
                    </svg>
                </div>
            </div>
        </div>

        <div class="banner">
            Subject List
        </div>

        <div class="container">
            <form action="coursecontroller" method="get"> 
                <input type="hidden" name="action" value="filter">
                <div class="filters">
                    <div>
                        <select name="category" onchange="this.form.submit()">
                            <option value="allCategory">All Categories</option>
                            <c:forEach var="i" items="${sessionScope.courseCategoryList}">
                                <option value="${i.courseCategoryName}" 
                                        <c:if test="${param.category == i.courseCategoryName}">selected</c:if> >
                                    ${i.courseCategoryName}
                                </option>
                            </c:forEach>
                        </select>

                        <select name="status" onchange="this.form.submit()">
                            <option value="allStatus">All Status</option>
                            <option value="active" <c:if test="${param.status == 'active'}">selected</c:if>>Active</option>
                            <option value="inactive" <c:if test="${param.status == 'inactive'}">selected</c:if>>Inactive</option>
                        </select>

                            <button type="button" onclick="window.location.href = 'createSubject.jsp'">Create</button>
                        </div>

                        <div>
                            <input type="text" name="search" placeholder="Search" value="${param.search}" onkeypress="if (event.key === 'Enter')
                        this.form.submit();">
                    </div>
                </div>
            </form>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Number of Lesson</th>
                        <th>Owner</th>
                        <th>Status</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>

                    <c:forEach var="i" items="${sessionScope.courseList}" >
                        <tr>
                            <td>${i.courseID}</td>
                            <td>${i.courseName}</td>
                            <td>${i.courseCategory}</td>
                            <td>${i.numberOfLesson}</td>
                            <td>${i.owner}</td>
                            <td>${i.status}</td>
                            <td class="action"><a href="#">Edit</a></td>
                        </tr> 
                    </c:forEach>



                </tbody>
            </table>

            <div class="pagination">
                <a href="#">Prev</a>
                <a href="#" class="active">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">Next</a>
            </div>
        </div>
    </body>
</html>
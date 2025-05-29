<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp : Education HTML Template" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>EduChamp : Education HTML Template</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                padding: 0;
            }
            .page-banner {
                background-image: url('assets/images/banner/banner2.jpg');
                background-size: cover;
                background-position: center;
                padding: 60px 0;
                position: relative;
                overflow: hidden;
            }
            .page-banner::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
            }
            .page-banner-entry {
                position: relative;
                z-index: 1;
                text-align: center;
                color: #fff;
            }
            .action-bar {
                display: flex;
                justify-content: flex-end;
                margin: 20px 20px 0;
            }
            .add-new-btn {
                padding: 10px 20px;
                font-size: 16px;
                font-weight: 500;
                background-color: #28a745;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.1s ease;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .add-new-btn:hover {
                background-color: #218838;
                transform: translateY(-2px);
            }
            .add-new-btn:active {
                transform: translateY(0);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px;
                background-color: #fff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            th, td {
                border: 1px solid #e0e0e0;
                padding: 12px 15px;
                text-align: center;
                font-size: 14px;
            }
            th {
                background-color: #f8f9fa;
                color: #333;
                font-weight: 600;
                position: relative;
                cursor: pointer;
                user-select: none;
                transition: background-color 0.3s ease;
            }
            th:hover {
                background-color: #e9ecef;
            }
            tr {
                transition: background-color 0.3s ease;
            }
            tr:hover {
                background-color: #f1f3f5;
            }
            .action-link {
                color: #007bff;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s ease;
            }
            .action-link:hover {
                color: #0056b3;
                text-decoration: underline;
            }
            .pagination {
                text-align: center;
                margin: 20px 0;
                padding: 10px;
            }
            .pagination button {
                padding: 8px 15px;
                margin: 0 5px;
                font-weight: 500;
                border: 1px solid #ddd;
                border-radius: 5px;
                background-color: #fff;
                cursor: pointer;
                transition: background-color 0.3s ease, color 0.3s ease;
            }
            .pagination button:hover {
                background-color: #007bff;
                color: #fff;
                border-color: #007bff;
            }
            .pagination .active {
                background-color: #007bff;
                color: #fff;
                border: none;
            }
            /* CSS cho biểu tượng sort */
            .sort-icon {
                display: inline-flex;
                flex-direction: column;
                margin-left: 5px;
                vertical-align: middle;
            }
            .sort-icon::before,
            .sort-icon::after {
                content: '';
                display: block;
                width: 0;
                height: 0;
                border-left: 5px solid transparent;
                border-right: 5px solid transparent;
            }
            .sort-icon::before {
                border-bottom: 5px solid #999;
                opacity: 0.5;
            }
            .sort-icon::after {
                border-top: 5px solid #999;
                opacity: 0.5;
                margin-top: 2px;
            }
            /* Khi cột đang được sắp xếp */
            .sort-asc .sort-icon::before {
                opacity: 1;
                border-bottom: 5px solid #007bff;
            }
            .sort-desc .sort-icon::after {
                opacity: 1;
                border-top: 5px solid #007bff;
            }
            .header-label {
                display: inline-flex;
                align-items: center;
                gap: 4px; /* khoảng cách giữa chữ và icon */
            }
            .sort-icon {
                font-size: 12px;
            }
            .filter-form {
                margin-bottom: 20px;
                padding: 15px;
                border: 1px solid #eee;
                border-radius: 5px;
                background-color: #f9f9f9;

                display: flex;
                gap: 10px;
                align-items: center;

                /* Bỏ flex-wrap để các phần tử nằm trên 1 hàng */
                flex-wrap: nowrap;

                /* Không cho xuống dòng */
                white-space: nowrap;

                /* Để dropdown có thể hiển thị ra bên ngoài */
                overflow: visible;
                position: relative; /* nếu dropdown cần định vị */
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





        </style>

    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>

            <!-- Header Top ==== -->
            <header class="header rs-nav">
                <div class="top-bar">
                    <div class="container">
                        <div class="row d-flex justify-content-between">
                            <div class="topbar-left">
                                <ul>
                                    <li><a href="faq-1.jsp"><i class="fa fa-question-circle"></i>Ask a Question</a></li>
                                    <li><a href="javascript:;"><i class="fa fa-envelope-o"></i>Support@website.com</a></li>
                                </ul>
                            </div>
                            <div class="topbar-right">
                                <ul>
                                    <li>
                                        <select class="header-lang-bx">
                                            <option data-icon="flag flag-uk">English UK</option>
                                            <option data-icon="flag flag-us">English US</option>
                                        </select>
                                    </li>
                                    <li><a href="login.jsp">Login</a></li>
                                    <li><a href="register.jsp">Register</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="sticky-header navbar-expand-lg">
                    <div class="menu-bar clearfix">
                        <div class="container clearfix">
                            <!-- Header Logo ==== -->
                            <div class="menu-logo">
                                <a href="index.jsp"><img src="assets/images/logo.png" alt=""></a>
                            </div>
                            <!-- Mobile Nav Button ==== -->
                            <button class="navbar-toggler collapsed menuicon justify-content-end" type="button" data-toggle="collapse" data-target="#menuDropdown" aria-controls="menuDropdown" aria-expanded="false" aria-label="Toggle navigation">
                                <span></span>
                                <span></span>
                                <span></span>
                            </button>
                            <!-- Author Nav ==== -->
                            <div class="secondary-menu">
                                <div class="secondary-inner">
                                    <ul>
                                        <li><a href="javascript:;" class="btn-link"><i class="fa fa-facebook"></i></a></li>
                                        <li><a href="javascript:;" class="btn-link"><i class="fa fa-google-plus"></i></a></li>
                                        <li><a href="javascript:;" class="btn-link"><i class="fa fa-linkedin"></i></a></li>
                                        <!-- Search Button ==== -->
                                        <li class="search-btn"><button id="quik-search-btn" type="button" class="btn-link"><i class="fa fa-search"></i></button></li>
                                    </ul>
                                </div>
                            </div>
                            <!-- Search Box ==== -->
                            <div class="nav-search-bar">
                                <form action="#">
                                    <input name="search" value="" type="text" class="form-control" placeholder="Type to search">
                                    <span><i class="ti-search"></i></span>
                                </form>
                                <span id="search-remove"><i class="ti-close"></i></span>
                            </div>
                            <!-- Navigation Menu ==== -->
                            <div class="menu-links navbar-collapse collapse justify-content-start" id="menuDropdown">
                                <div class="menu-logo">
                                    <a href="index.jsp"><img src="assets/images/logo.png" alt=""></a>
                                </div>
                                <ul class="nav navbar-nav">	
                                    <li class="active"><a href="javascript:;">Home <i class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="index.jsp">Home 1</a></li>
                                            <li><a href="index-2.jsp">Home 2</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="javascript:;">Pages <i class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="javascript:;">About<i class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="about-1.jsp">About 1</a></li>
                                                    <li><a href="about-2.jsp">About 2</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="javascript:;">Event<i class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="event.jsp">Event</a></li>
                                                    <li><a href="events-details.jsp">Events Details</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="javascript:;">FAQ's<i class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="faq-1.jsp">FAQ's 1</a></li>
                                                    <li><a href="faq-2.jsp">FAQ's 2</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="javascript:;">Contact Us<i class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="contact-1.jsp">Contact Us 1</a></li>
                                                    <li><a href="contact-2.jsp">Contact Us 2</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="portfolio.jsp">Portfolio</a></li>
                                            <li><a href="profile.jsp">Profile</a></li>
                                            <li><a href="membership.jsp">Membership</a></li>
                                            <li><a href="error-404.jsp">404 Page</a></li>
                                        </ul>
                                    </li>
                                    <li class="add-mega-menu"><a href="javascript:;">Our Courses <i class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu add-menu">
                                            <li class="add-menu-left">
                                                <h5 class="menu-adv-title">Our Courses</h5>
                                                <ul>
                                                    <li><a href="courses.jsp">Courses </a></li>
                                                    <li><a href="courses-details.jsp">Courses Details</a></li>
                                                    <li><a href="profile.jsp">Instructor Profile</a></li>
                                                    <li><a href="event.jsp">Upcoming Event</a></li>
                                                    <li><a href="membership.jsp">Membership</a></li>
                                                </ul>
                                            </li>
                                            <li class="add-menu-right">
                                                <img src="assets/images/adv/adv.jpg" alt=""/>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><a href="javascript:;">Blog <i class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="blog-classic-grid.jsp">Blog Classic</a></li>
                                            <li><a href="blog-classic-sidebar.jsp">Blog Classic Sidebar</a></li>
                                            <li><a href="postcontroller?pageforward=bloglist">Blog List Sidebar</a></li>
                                            <li><a href="blog-standard-sidebar.jsp">Blog Standard Sidebar</a></li>
                                            <li><a href="postcontroller?pageforward=blogdetail">Blog Details</a></li>
                                        </ul>
                                    </li>
                                    <li class="nav-dashboard"><a href="javascript:;">Dashboard <i class="fa fa-chevron-down"></i></a>
                                        <ul class="sub-menu">
                                            <li><a href="admin/index.jsp">Dashboard</a></li>
                                            <li><a href="admin/add-listing.jsp">Add Listing</a></li>
                                            <li><a href="admin/bookmark.jsp">Bookmark</a></li>
                                            <li><a href="admin/courses.jsp">Courses</a></li>
                                            <li><a href="admin/review.jsp">Review</a></li>
                                            <li><a href="admin/teacher-profile.jsp">Teacher Profile</a></li>
                                            <li><a href="admin/user-profile.jsp">User Profile</a></li>
                                            <li><a href="javascript:;">Calendar<i class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="admin/basic-calendar.jsp">Basic Calendar</a></li>
                                                    <li><a href="admin/list-view-calendar.jsp">List View Calendar</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="javascript:;">Mailbox<i class="fa fa-angle-right"></i></a>
                                                <ul class="sub-menu">
                                                    <li><a href="admin/mailbox.jsp">Mailbox</a></li>
                                                    <li><a href="admin/mailbox-compose.jsp">Compose</a></li>
                                                    <li><a href="admin/mailbox-read.jsp">Mail Read</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <div class="nav-social-link">
                                    <a href="javascript:;"><i class="fa fa-facebook"></i></a>
                                    <a href="javascript:;"><i class="fa fa-google-plus"></i></a>
                                    <a href="javascript:;"><i class="fa fa-linkedin"></i></a>
                                </div>
                            </div>
                            <!-- Navigation Menu END ==== -->
                        </div>
                    </div>
                </div>
            </header>
            <!-- header END ==== -->
            <!-- Content -->
            <div class="page-content bg-white">
                <!-- inner page banner -->
                <div class="page-banner ovbl-dark">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Registration List</h1>
                        </div>
                    </div>
                </div>
                <!-- Breadcrumb row -->
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="#">Home</a></li>
                            <li>Registration List</li>
                        </ul>
                    </div>
                </div>
                <!-- contact area -->
                <div class="content-block">
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="action-bar">
                                <button class="add-new-btn">Add New</button>
                            </div>
                            <div class="filter-bar">
                                <form action="registrationsalercontroller" method="GET" class="filter-form">
                                    <input type="text" name="emailSearch" placeholder="Search Email"
                                           value="${param.emailSearch != null ? param.emailSearch : ''}"/>

                                    <select name="courseName">
                                        <option value="">All Courses</option>
                                        <c:forEach var="course" items="${courseList}">
                                            <option value="${course.courseName}" 
                                                    ${param.courseName != null && param.courseName == course.courseName ? 'selected' : ''}>
                                                ${course.courseName}
                                            </option>
                                        </c:forEach>
                                    </select>

                                    <select name="name">
                                        <option value="">All Packages</option>
                                        <c:forEach var="pkg" items="${packageList}">
                                            <option value="${pkg.name}" ${name != null && name.equals(pkg.name) ? 'selected' : ''}>
                                                ${pkg.name}
                                            </option>
                                        </c:forEach>
                                    </select>


                                    <select name="validFrom">
                                        <option value="">From</option>
                                        <c:forEach var="fromDate" items="${fromDateList}">
                                            <option value="${fromDate}" ${param.validFrom == fromDate ? 'selected' : ''}>${fromDate}</option>
                                        </c:forEach>
                                    </select>

                                    <select name="validTo">
                                        <option value="">To</option>
                                        <c:forEach var="fromDate" items="${fromDateList}">
                                            <option value="${fromDate}" ${param.validFrom == fromDate ? 'selected' : ''}>${fromDate}</option>
                                        </c:forEach>
                                    </select>


                                    <select name="status">
                                        <option value="">All Status</option>
                                        <option value="Submitted" ${param.status == 'Submitted' ? 'selected' : ''}>Submitted</option>
                                        <option value="Paid" ${param.status == 'Paid' ? 'selected' : ''}>Paid</option>
                                        <option value="Cancelled" ${param.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                    </select>

                                    <button type="submit">Apply Filter</button>
                                </form>

                            </div>

                            <table>
                                <thead>
                                    <tr>
                                        <th class="sortable-header">
                                            <a href="registrationsalercontroller?sortBy=userID&sortOrder=${sortBy == 'userID' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                                               class="${sortBy == 'userID' ? 'active-sort' : ''}">
                                                <span class="header-label">
                                                    ID
                                                    <span class="sort-icon">
                                                        <c:choose>
                                                            <c:when test="${sortBy == 'userID' && sortOrder == 'asc'}">&#9650;</c:when>
                                                            <c:when test="${sortBy == 'userID' && sortOrder == 'desc'}">&#9660;</c:when>
                                                        </c:choose>
                                                    </span>
                                                </span>
                                            </a>
                                        </th>
                                        <th class="sortable-header">
                                            <a href="registrationsalercontroller?sortBy=email&sortOrder=${sortBy == 'email' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                                               class="${sortBy == 'email' ? 'active-sort' : ''}">
                                                <span class="header-label">
                                                    Email
                                                    <span class="sort-icon">
                                                        <c:choose>
                                                            <c:when test="${sortBy == 'email' && sortOrder == 'asc'}">&#9650;</c:when>
                                                            <c:when test="${sortBy == 'email' && sortOrder == 'desc'}">&#9660;</c:when>
                                                        </c:choose>
                                                    </span>
                                                </span>
                                            </a>
                                        </th>
                                        <th class="sortable-header">
                                            <a href="registrationsalercontroller?sortBy=registrationTime&sortOrder=${sortBy == 'registrationTime' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                                               class="${sortBy == 'registrationTime' ? 'active-sort' : ''}">
                                                <span class="header-label">
                                                    Registration Time
                                                    <span class="sort-icon">
                                                        <c:choose>
                                                            <c:when test="${sortBy == 'registrationTime' && sortOrder == 'asc'}">&#9650;</c:when>
                                                            <c:when test="${sortBy == 'registrationTime' && sortOrder == 'desc'}">&#9660;</c:when>
                                                        </c:choose>
                                                    </span>
                                                </span>
                                            </a>
                                        </th>
                                        <th class="sortable-header">
                                            <a href="registrationsalercontroller?sortBy=courseName&sortOrder=${sortBy == 'courseName' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                                               class="${sortBy == 'courseName' ? 'active-sort' : ''}">
                                                <span class="header-label">
                                                    Subject
                                                    <span class="sort-icon">
                                                        <c:choose>
                                                            <c:when test="${sortBy == 'courseName' && sortOrder == 'asc'}">&#9650;</c:when>
                                                            <c:when test="${sortBy == 'courseName' && sortOrder == 'desc'}">&#9660;</c:when>
                                                        </c:choose>
                                                    </span>
                                                </span>
                                            </a>
                                        </th>
                                        <th class="sortable-header">
                                            <a href="registrationsalercontroller?sortBy=name&sortOrder=${sortBy == 'name' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                                               class="${sortBy == 'name' ? 'active-sort' : ''}">
                                                <span class="header-label">
                                                    Package
                                                    <span class="sort-icon">
                                                        <c:choose>
                                                            <c:when test="${sortBy == 'name' && sortOrder == 'asc'}">&#9650;</c:when>
                                                            <c:when test="${sortBy == 'name' && sortOrder == 'desc'}">&#9660;</c:when>
                                                        </c:choose>
                                                    </span>
                                                </span>
                                            </a>
                                        </th>
                                        <th class="sortable-header">
                                            <a href="registrationsalercontroller?sortBy=totalCost&sortOrder=${sortBy == 'totalCost' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                                               class="${sortBy == 'totalCost' ? 'active-sort' : ''}">
                                                <span class="header-label">
                                                    Total Cost
                                                    <span class="sort-icon">
                                                        <c:choose>
                                                            <c:when test="${sortBy == 'totalCost' && sortOrder == 'asc'}">&#9650;</c:when>
                                                            <c:when test="${sortBy == 'totalCost' && sortOrder == 'desc'}">&#9660;</c:when>
                                                        </c:choose>
                                                    </span>
                                                </span>
                                            </a>
                                        </th>
                                        <th class="sortable-header">
                                            <a href="registrationsalercontroller?sortBy=status&sortOrder=${sortBy == 'status' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                                               class="${sortBy == 'status' ? 'active-sort' : ''}">
                                                <span class="header-label">
                                                    Status
                                                    <span class="sort-icon">
                                                        <c:choose>
                                                            <c:when test="${sortBy == 'status' && sortOrder == 'asc'}">&#9650;</c:when>
                                                            <c:when test="${sortBy == 'status' && sortOrder == 'desc'}">&#9660;</c:when>
                                                        </c:choose>
                                                    </span>
                                                </span>
                                            </a>
                                        </th>
                                        <th class="sortable-header">
                                            <a href="registrationsalercontroller?sortBy=validFrom&sortOrder=${sortBy == 'validFrom' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                                               class="${sortBy == 'validFrom' ? 'active-sort' : ''}">
                                                <span class="header-label">
                                                    Valid From
                                                    <span class="sort-icon">
                                                        <c:choose>
                                                            <c:when test="${sortBy == 'validFrom' && sortOrder == 'asc'}">&#9650;</c:when>
                                                            <c:when test="${sortBy == 'validFrom' && sortOrder == 'desc'}">&#9660;</c:when>
                                                        </c:choose>
                                                    </span>
                                                </span>
                                            </a>
                                        </th>
                                        <th class="sortable-header">
                                            <a href="registrationsalercontroller?sortBy=validTo&sortOrder=${sortBy == 'validTo' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                                               class="${sortBy == 'validTo' ? 'active-sort' : ''}">
                                                <span class="header-label">
                                                    Valid To
                                                    <span class="sort-icon">
                                                        <c:choose>
                                                            <c:when test="${sortBy == 'validTo' && sortOrder == 'asc'}">&#9650;</c:when>
                                                            <c:when test="${sortBy == 'validTo' && sortOrder == 'desc'}">&#9660;</c:when>
                                                        </c:choose>
                                                    </span>
                                                </span>
                                            </a>
                                        </th>
                                        <th class="sortable-header">
                                            <a href="registrationsalercontroller?sortBy=fullName&sortOrder=${sortBy == 'fullName' && sortOrder == 'asc' ? 'desc' : 'asc'}"
                                               class="${sortBy == 'fullName' ? 'active-sort' : ''}">
                                                <span class="header-label">
                                                    Last Update By
                                                    <span class="sort-icon">
                                                        <c:choose>
                                                            <c:when test="${sortBy == 'fullName' && sortOrder == 'asc'}">&#9650;</c:when>
                                                            <c:when test="${sortBy == 'fullName' && sortOrder == 'desc'}">&#9660;</c:when>
                                                        </c:choose>
                                                    </span>
                                                </span>
                                            </a>
                                        </th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <!-- Example data rows -->
                                    <c:forEach items="${listRegistrationBySaler}" var="Saler">
                                        <tr>
                                            <td>${Saler.user.userID}</td>
                                            <td>${Saler.user.email}</td>
                                            <td><fmt:formatDate value="${Saler.registrationTime}" pattern="dd-MM-yyyy"/></td>
                                            <td>${Saler.course.courseName}</td>
                                            <td>${Saler.pricePackage.name}</td>
                                            <td>${Saler.totalCost}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${Saler.status == 'Submitted'}">
                                                        <span class="status-submitted">Submitted</span>
                                                    </c:when>
                                                    <c:when test="${Saler.status == 'Paid'}">
                                                        <span class="status-paid">Paid</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-cancelled">Cancelled</span>
                                                    </c:otherwise>
                                                </c:choose>

                                            </td>
                                            <td><fmt:formatDate value="${Saler.validFrom}" pattern="dd-MM-yyyy"/></td>
                                            <td><fmt:formatDate value="${Saler.validTo}" pattern="dd-MM-yyyy"/></td>
                                            <td>${Saler.lastUpdateBy.fullName}</td>
                                            <td>
                                                <span class="action-link">
                                                    <a href="${pageContext.request.contextPath}/your-edit-url?id=${item.id}">Edit</a> 
                                                    <a href="${pageContext.request.contextPath}/your-detail-url?id=${item.id}">Detail</a>
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <!-- More rows can be populated dynamically -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Content END-->
            <!-- Footer ==== -->
            <footer>
                <div class="footer-top">
                    <div class="pt-exebar">
                        <div class="container">
                            <div class="d-flex align-items-stretch">
                                <div class="pt-logo mr-auto">
                                    <a href="index.jsp"><img src="assets/images/logo-white.png" alt=""/></a>
                                </div>
                                <div class="pt-social-link">
                                    <ul class="list-inline m-a0">
                                        <li><a href="#" class="btn-link"><i class="fa fa-facebook"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-twitter"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-linkedin"></i></a></li>
                                        <li><a href="#" class="btn-link"><i class="fa fa-google-plus"></i></a></li>
                                    </ul>
                                </div>
                                <div class="pt-btn-join">
                                    <a href="#" class="btn ">Join Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-4 col-md-12 col-sm-12 footer-col-4">
                                <div class="widget">
                                    <h5 class="footer-title">Sign Up For A Newsletter</h5>
                                    <p class="text-capitalize m-b20">Weekly Breaking news analysis and cutting edge advices on job searching.</p>
                                    <div class="subscribe-form m-b20">
                                        <form class="subscription-form" action="http://educhamp.themetrades.com/demo/assets/script/mailchamp.php" method="post">
                                            <div class="ajax-message"></div>
                                            <div class="input-group">
                                                <input name="email" required="required"  class="form-control" placeholder="Your Email Address" type="email">
                                                <span class="input-group-btn">
                                                    <button name="submit" value="Submit" type="submit" class="btn"><i class="fa fa-arrow-right"></i></button>
                                                </span> 
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-lg-5 col-md-7 col-sm-12">
                                <div class="row">
                                    <div class="col-4 col-lg-4 col-md-4 col-sm-4">
                                        <div class="widget footer_widget">
                                            <h5 class="footer-title">Company</h5>
                                            <ul>
                                                <li><a href="index.jsp">Home</a></li>
                                                <li><a href="about-1.jsp">About</a></li>
                                                <li><a href="faq-1.jsp">FAQs</a></li>
                                                <li><a href="contact-1.jsp">Contact</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-4 col-lg-4 col-md-4 col-sm-4">
                                        <div class="widget footer_widget">
                                            <h5 class="footer-title">Get In Touch</h5>
                                            <ul>
                                                <li><a href="http://educhamp.themetrades.com/admin/index.jsp">Dashboard</a></li>
                                                <li><a href="blog-classic-grid.jsp">Blog</a></li>
                                                <li><a href="portfolio.jsp">Portfolio</a></li>
                                                <li><a href="event.jsp">Event</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-4 col-lg-4 col-md-4 col-sm-4">
                                        <div class="widget footer_widget">
                                            <h5 class="footer-title">Courses</h5>
                                            <ul>
                                                <li><a href="courses.jsp">Courses</a></li>
                                                <li><a href="courses-details.jsp">Details</a></li>
                                                <li><a href="membership.jsp">Membership</a></li>
                                                <li><a href="profile.jsp">Profile</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-lg-3 col-md-5 col-sm-12 footer-col-4">
                                <div class="widget widget_gallery gallery-grid-4">
                                    <h5 class="footer-title">Our Gallery</h5>
                                    <ul class="magnific-image">
                                        <li><a href="assets/images/gallery/pic1.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic1.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic2.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic2.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic3.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic3.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic4.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic4.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic5.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic5.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic6.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic6.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic7.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic7.jpg" alt=""></a></li>
                                        <li><a href="assets/images/gallery/pic8.jpg" class="magnific-anchor"><img src="assets/images/gallery/pic8.jpg" alt=""></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-12 col-md-12 col-sm-12 text-center"> <a target="_blank" href="https://www.templateshub.net">Templates Hub</a></div>
                            </div>
                        </div>
                        </footer>
                        <!-- Footer END ==== -->
                        <!-- scroll top button -->
                        <button class="back-to-top fa fa-chevron-up" ></button>
                    </div>
                    <!-- External JavaScripts -->
                    <script src="assets/js/jquery.min.js"></script>
                    <script src="assets/vendors/bootstrap/js/popper.min.js"></script>
                    <script src="assets/vendors/bootstrap/js/bootstrap.min.js"></script>
                    <script src="assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
                    <script src="assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
                    <script src="assets/vendors/magnific-popup/magnific-popup.js"></script>
                    <script src="assets/vendors/counter/waypoints-min.js"></script>
                    <script src="assets/vendors/counter/counterup.min.js"></script>
                    <script src="assets/vendors/imagesloaded/imagesloaded.js"></script>
                    <script src="assets/vendors/masonry/masonry.js"></script>
                    <script src="assets/vendors/masonry/filter.js"></script>
                    <script src="assets/vendors/owl-carousel/owl.carousel.js"></script>
                    <script src="assets/js/functions.js"></script>
                    <script src="assets/js/contact.js"></script>
                    <script src='assets/vendors/switcher/switcher.js'></script>
                    </body>
                    </html>

<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


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
        <link rel="icon" href="../error-404.jsp" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/admin/assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Posts List</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/assets/vendors/calendar/fullcalendar.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/assets/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/assets/css/color/color-1.css">


        <style>
            /* CSS */
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 0;
            }

            /* Container ch?nh */
            .container-fluid {
                padding: 20px;
            }

            .widget-box {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-top: -10px
            }
            .top-bar {
                display: flex;
                align-items: center;
                justify-content: flex-start;
                gap: 10px;
                flex-wrap: nowrap;
                margin-bottom: 15px;
                padding-top: 0px;
            }

            .search-input {
                flex: 1;
                min-width: 365%; /* ? Search d?i ra */
                padding: 6px 12px;
                font-size: 14px;
            }

            .btn-warning {
                white-space: nowrap;
                padding: 8px 19px;
                font-size: 14px;
                background-color: #f8c61b;
                margin-left: 20px;



            }

            .sort-select {
                width: 100px;
                padding: 6px 14px;
                font-size: 14px;


            }

            .sort-by-select {
                width: 100px;
                text-align: center;
            }


            /* B? l?c */
            .filters {
                display: flex;
                gap: 70px;

            }

            .filters select {
                padding: 8px 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                background-color: #fff;
                cursor: pointer;
                font-size: 14px;
                color: #555;
                text-align: center;
                margin-left: 10px;
                width: 150px;

            }
            .filters select option {
                text-align: left;

            }





            .filters button {
                white-space: nowrap;
                padding: 8px 8px;
                font-size: 14px;
                background-color: #f8c61b;
                margin-left: 15px;
                gap: 20px;

            }



            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
                border: 1px solid #ddd;
            }

            table th, table td {
                padding: 12px;
                text-align: center;
                border: 1px solid #ddd;
                font-size: 14px;
            }

            table th {
                background-color: #f0f0f0;
                font-weight: bold;
                color: #555;
            }

            table td {
                vertical-align: middle;
            }

            table td img {
                width: 50px;
                height: 50px;
                object-fit: cover;
                border-radius: 4px;
            }

            /* Tr?ng th?i Active/Inactive */
            .status {
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }

            .status .dot {
                width: 10px;
                height: 10px;
                border-radius: 50%;
                display: inline-block;
            }

            .status .dot.active {
                background-color: #28a745;
            }

            .status .dot.inactive {
                background-color: #dc3545;
            }

            /* N?t h?nh ??ng */
            .action-buttons a {

                text-decoration: none;
                color: #007bff;
                font-size: 14px;
                margin-left: 5px;
            }

            .action-buttons a:hover {
                text-decoration: underline;
            }

            /* Ph?n trang */
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
                margin-top: 20px;
            }

            .pagination a, .pagination span {
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                text-decoration: none;
                font-size: 14px;
            }

            .pagination a {
                color: #007bff;
                background-color: #fff;
            }

            .pagination span {
                background-color: #007bff;
                color: #fff;
                border-color: #007bff;
            }

            .pagination a:hover {
                background-color: #f0f0f0;
            }
            .select  {
                display: block;
            }
            .option{
                display: block;
            }
            .add-post-btn{
                margin-left: 915px;
            }
            .reset{
                padding-left: 7px;
                padding-right: 8px;

            }
            .search{
                padding-left: 25px;
                padding-right: 20px;
                margin-left: 20px;
            }
            .action{

            }
            .search-container {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 20px;
            }

            .search-input {
                flex: 1;
                min-width: 300px;
                padding: 8px;
            }

            .filters {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
            }

            .filters select {
                padding: 8px;
                min-width: 150px;
            }

            .btn-add-post {
                white-space: nowrap;
                margin-right: 10px;
            }
           

        </style>
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- Header -->
        <header class="ttr-header">
            <div class="ttr-header-wrapper">
                <!--sidebar menu toggler start -->
                <div class="ttr-toggle-sidebar ttr-material-button">
                    <i class="ti-close ttr-open-icon"></i>
                    <i class="ti-menu ttr-close-icon"></i>
                </div>
                <!--sidebar menu toggler end -->
                <!--logo start -->
                <div class="ttr-logo-box">
                    <div>
                        <a href="index.jsp" class="ttr-logo">
                            <img alt="" class="ttr-logo-mobile"
                                src="assets/images/logo-mobile.png" width="30" height="30">
                            <img alt="" class="ttr-logo-desktop"
                                src="assets/images/logo-white.png" width="160" height="27">
                        </a>
                    </div>
                </div>
                <!--logo end -->
                <div class="ttr-header-menu">
                    <!-- header left menu start -->
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="home"
                                class="ttr-material-button ttr-submenu-toggle">HOME</a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle">QUICK
                                MENU <i class="fa fa-angle-down"></i></a>
                            <div class="ttr-header-submenu">
                                <ul>
                                    <li><a href="home">Our Posts List</a></li>
                                    <li><a href="event.jsp">New Event</a></li>
                                    <li><a href="membership.jsp">Membership</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <!-- header left menu end -->
                </div>
                <div class="ttr-header-right ttr-with-seperator">
                    <!-- header right menu start -->
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="#" class="ttr-material-button ttr-search-toggle"><i
                                    class="fa fa-search"></i></a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle"><i
                                    class="fa fa-bell"></i></a>
                            <div class="ttr-header-submenu noti-menu">
                                <div class="ttr-notify-header">
                                    <span class="ttr-notify-text-top">9 New</span>
                                    <span class="ttr-notify-text">User Notifications</span>
                                </div>
                                <div class="noti-box-list">
                                    <ul>
                                        <li>
                                            <span class="notification-icon dashbg-gray">
                                                <i class="fa fa-check"></i>
                                            </span>
                                            <span class="notification-text">
                                                <span>Sneha Jogi</span> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 02:14</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-yellow">
                                                <i class="fa fa-shopping-cart"></i>
                                            </span>
                                            <span class="notification-text">
                                                <a href="#">Your order is placed</a> sent you a
                                                message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 7 Min</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-red">
                                                <i class="fa fa-bullhorn"></i>
                                            </span>
                                            <span class="notification-text">
                                                <span>Your item is shipped</span> sent you a
                                                message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 2 May</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-green">
                                                <i class="fa fa-comments-o"></i>
                                            </span>
                                            <span class="notification-text">
                                                <a href="#">Sneha Jogi</a> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 14 July</span>
                                            </span>
                                        </li>
                                        <li>
                                            <span class="notification-icon dashbg-primary">
                                                <i class="fa fa-file-word-o"></i>
                                            </span>
                                            <span class="notification-text">
                                                <span>Sneha Jogi</span> sent you a message.
                                            </span>
                                            <span class="notification-time">
                                                <a href="#" class="fa fa-close"></a>
                                                <span> 15 Min</span>
                                            </span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle"><span
                                    class="ttr-user-avatar"><img alt=""
                                        src="assets/images/testimonials/pic3.jpg" width="32"
                                        height="32"></span></a>
                            <div class="ttr-header-submenu">
                                <ul>
                                    <li><a href="user-profile.jsp">My profile</a></li>
                                    <li><a href="list-view-calendar.jsp">Activity</a></li>
                                    <li><a href="mailbox.jsp">Messages</a></li>
                                    <li><a href="../login.jsp">Logout</a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="ttr-hide-on-mobile">
                            <a href="#" class="ttr-material-button"><i
                                    class="ti-layout-grid3-alt"></i></a>
                            <div class="ttr-header-submenu ttr-extra-menu">
                                <a href="#">
                                    <i class="fa fa-music"></i>
                                    <span>Musics</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-youtube-play"></i>
                                    <span>Videos</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-envelope"></i>
                                    <span>Emails</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-book"></i>
                                    <span>Reports</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-smile-o"></i>
                                    <span>Persons</span>
                                </a>
                                <a href="#">
                                    <i class="fa fa-picture-o"></i>
                                    <span>Pictures</span>
                                </a>
                            </div>
                        </li>
                    </ul>
                    <!-- header right menu end -->
                </div>
                <!--header search panel start -->
                <div class="ttr-search-bar">
                    <form class="ttr-search-form">
                        <div class="ttr-search-input-wrapper">
                            <input type="text" name="qq" placeholder="search something..."
                                class="ttr-search-input">
                            <button type="submit" name="search" class="ttr-search-submit"><i
                                    class="ti-arrow-right"></i></button>
                        </div>
                        <span class="ttr-search-close ttr-search-toggle">
                            <i class="ti-close"></i>
                        </span>
                    </form>
                </div>
                <!--header search panel end -->
            </div>
        </header>
        <!-- header end -->
        <!-- Left sidebar menu start -->
        <div class="ttr-sidebar">
            <div class="ttr-sidebar-wrapper content-scroll">
                <!-- side menu logo start -->
                <div class="ttr-sidebar-logo">
                    <a href="#"><img alt="" src="assets/images/logo.png" width="122" height="27"></a>
                    <!-- <div class="ttr-sidebar-pin-button" title="Pin/Unpin Menu">
                            <i class="material-icons ttr-fixed-icon">gps_fixed</i>
                            <i class="material-icons ttr-not-fixed-icon">gps_not_fixed</i>
                    </div> -->
                    <div class="ttr-sidebar-toggle-button">
                        <i class="ti-arrow-left"></i>
                    </div>
                </div>
                <!-- side menu logo end -->
                <!-- sidebar menu start -->
                <nav class="ttr-sidebar-navi">
                    <ul>
                        <li>
                            <a href="admin/index.jsp" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-home"></i></span>
                                <span class="ttr-label">Dashboard</span>
                            </a>
                        </li>
                        <li>
                            <a href="postcontroller" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-book"></i></span>
                                <span class="ttr-label">Posts List</span>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-email"></i></span>
                                <span class="ttr-label">Mailbox</span>
                                <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                            </a>
                            <ul>
                                <li>
                                    <a href="mailbox.jsp" class="ttr-material-button"><span class="ttr-label">Mail Box</span></a>
                                </li>
                                <li>
                                    <a href="mailbox-compose.jsp" class="ttr-material-button"><span class="ttr-label">Compose</span></a>
                                </li>
                                <li>
                                    <a href="mailbox-read.jsp" class="ttr-material-button"><span class="ttr-label">Mail Read</span></a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-calendar"></i></span>
                                <span class="ttr-label">Calendar</span>
                                <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                            </a>
                            <ul>
                                <li>
                                    <a href="basic-calendar.jsp" class="ttr-material-button"><span class="ttr-label">Basic Calendar</span></a>
                                </li>
                                <li>
                                    <a href="list-view-calendar.jsp" class="ttr-material-button"><span class="ttr-label">List View</span></a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="bookmark.jsp" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-bookmark-alt"></i></span>
                                <span class="ttr-label">Bookmarks</span>
                            </a>
                        </li>
                        <li>
                            <a href="review.jsp" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-comments"></i></span>
                                <span class="ttr-label">Review</span>
                            </a>
                        </li>
                        <li>
                            <a href="add-listing.jsp" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-layout-accordion-list"></i></span>
                                <span class="ttr-label">Add listing</span>
                            </a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-user"></i></span>
                                <span class="ttr-label">My Profile</span>
                                <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                            </a>
                            <ul>
                                <li>
                                    <a href="user-profile.jsp" class="ttr-material-button"><span class="ttr-label">User Profile</span></a>
                                </li>
                                <li>
                                    <a href="teacher-profile.jsp" class="ttr-material-button"><span class="ttr-label">Teacher Profile</span></a>
                                </li>
                            </ul>
                        </li>
                        <li class="ttr-seperate"></li>
                    </ul>
                    <!-- sidebar menu end -->
                </nav>
                <!-- sidebar menu end -->
            </div>
        </div>

        <!-- Main container -->
        <main class="ttr-wrapper">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12 m-b30">
                    <div class="widget-box">
                        <div class="wc-title">
                            <div class="db-breadcrumb">
                                <h4 class="breadcrumb-title" style="font-size: 24px;">Posts List</h4>
                                <ul class="db-breadcrumb-list">
                                    <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                                    <li>Posts List</li>
                                </ul>
                            </div>
                            <div class="top-bar">
                                <div class="search-container">
                                    <form action="postcontroller" method="GET" class="d-flex">
                                        <input type="text" name="search" value="${param.search}" placeholder="Search by title..." class="search-input" />
                                        <input type="hidden" name="page" value="1" />
                                        <button type="submit" class="btn btn-warning search">Search</button>
                                    </form>
                                    <a href="postcontroller?action=showAddForm" class="btn btn-warning btn-add-post">Add Post</a>
                                </div>
                            </div>

                            <!-- Filters -->
                            <div class="filters">
                                <form action="postcontroller" method="GET" class="d-flex align-items-center text-black" style="color: black;">
                                    <select name="sortBy" class="sort-select">
                                        <option value="" disabled selected hidden>Sort by</option>
                                        <option style="color: black;" value="title" ${param.sortBy eq 'title' ? 'selected' : ''}>Title</option>
                                        <option value="category" ${param.sortBy eq 'category' ? 'selected' : ''}>Category</option>
                                        <option value="author" ${param.sortBy eq 'author' ? 'selected' : ''}>Author</option>
                                        <option value="date" ${param.sortBy eq 'date' ? 'selected' : ''}>Date</option>
                                        <option value="status" ${param.sortBy eq 'status' ? 'selected' : ''}>Status</option>
                                        <option value="feature" ${param.sortBy eq 'feature' ? 'selected' : ''}>Feature</option>
                                    </select>

                                    <select name="category" class="sort-select">
                                        <option value="" disabled selected hidden>Category</option>
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.postCategoryID}" ${param.category eq category.postCategoryID ? 'selected' : ''}>
                                                ${category.postCategoryName}
                                            </option>
                                        </c:forEach>
                                    </select>

                                    <select name="author" class="sort-select">
                                        <option value="" disabled selected hidden>Author</option>
                                        <c:forEach var="author" items="${authors}">
                                            <option value="${author.userID}" ${param.author eq author.userID ? 'selected' : ''}>
                                                ${author.fullName}
                                            </option>
                                        </c:forEach>
                                    </select>

                                    <select name="status" class="sort-select">
                                        <option value="" disabled selected hidden>Status</option>
                                        <option value="active" ${param.status eq 'active' ? 'selected' : ''}>Active</option>
                                        <option value="inactive" ${param.status eq 'inactive' ? 'selected' : ''}>Inactive</option>
                                    </select>

                                    <select name="feature" class="sort-select">
                                        <option value="" disabled selected hidden>Feature</option>
                                        <option value="true" ${param.feature eq 'true' ? 'selected' : ''}>Yes</option>
                                        <option value="false" ${param.feature eq 'false' ? 'selected' : ''}>No</option>
                                    </select>

                                    <input type="hidden" name="page" value="1" />
                                    <input type="hidden" name="search" value="${param.search}" />
                                    <button type="submit" class="btn btn-warning">Apply Filters</button>
                                    <a href="postcontroller" class="btn btn-warning reset">Reset Filters</a>
                                </form>
                            </div>
                        </div>

                        <div class="widget-inner">
                            <div class="card-courses-list admin-courses">
                                <table border="1">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Thumbnail</th>
                                            <th>Title</th>
                                            <th>Category</th>
                                            <th>Owner</th>
                                            <th>Create Date</th> 
                                            <th>Status</th>
                                            <th>Feature</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="post" items="${posts}" varStatus="loop">
                                            <tr> 
                                                <td>${post.postID}</td>
                                                <td><img src="${post.thumbnail}" alt="Thumbnail" style="width: 50px; height: 50px; object-fit: cover;"></td>
                                                <td>${post.title}</td>
                                                <td>${post.postCategory.postCategoryName}</td>
                                                <td>${post.owner.fullName}</td>
                                                <td><fmt:formatDate value="${post.createDate}" pattern="dd/MM/yyyy"/></td> 
                                                <td>
                                                    <span class="status">
                                                        <span class="dot ${post.status eq 'Active' ? 'active' : 'inactive'}"></span>
                                                        ${post.status}
                                                    </span>
                                                </td>
                                                <td>${post.feature ? 'Yes' : 'No'}</td>
                                                <td class="action-buttons">
                                                    <a href="postcontroller?action=view&id=${post.postID}">View</a>
                                                    <a href="postcontroller?action=showEditForm&id=${post.postID}">Edit</a>
                                                    <a href="postcontroller?action=delete&id=${post.postID}" onclick="return confirm('Are you sure you want to delete this post?')">Delete</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Pagination -->
                            <div class="pagination-bx rounded-sm gray clearfix">
                                <ul class="pagination">
                                    <c:if test="${currentPage > 1}">
                                        <li class="previous">
                                            <a href="postcontroller?page=${currentPage - 1}${not empty param.search ? '&search='.concat(param.search) : ''}${not empty param.sortBy ? '&sortBy='.concat(param.sortBy) : ''}${not empty param.category ? '&category='.concat(param.category) : ''}${not empty param.author ? '&author='.concat(param.author) : ''}${not empty param.status ? '&status='.concat(param.status) : ''}${not empty param.feature ? '&feature='.concat(param.feature) : ''}">
                                                <i class="ti-arrow-left"></i> Prev
                                            </a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="${currentPage == i ? 'active' : ''}">
                                            <a href="postcontroller?page=${i}${not empty param.search ? '&search='.concat(param.search) : ''}${not empty param.sortBy ? '&sortBy='.concat(param.sortBy) : ''}${not empty param.category ? '&category='.concat(param.category) : ''}${not empty param.author ? '&author='.concat(param.author) : ''}${not empty param.status ? '&status='.concat(param.status) : ''}${not empty param.feature ? '&feature='.concat(param.feature) : ''}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${currentPage < totalPages}">
                                        <li class="next">
                                            <a href="postcontroller?page=${currentPage + 1}${not empty param.search ? '&search='.concat(param.search) : ''}${not empty param.sortBy ? '&sortBy='.concat(param.sortBy) : ''}${not empty param.category ? '&category='.concat(param.category) : ''}${not empty param.author ? '&author='.concat(param.author) : ''}${not empty param.status ? '&status='.concat(param.status) : ''}${not empty param.feature ? '&feature='.concat(param.feature) : ''}">
                                                Next <i class="ti-arrow-right"></i>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </main>
        <div class="ttr-overlay"></div>

        <!-- External JavaScripts -->
         <script src="<%=request.getContextPath()%>/admin/assets/js/jquery.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/counter/waypoints-min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/counter/counterup.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/masonry/masonry.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/masonry/filter.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src='<%=request.getContextPath()%>/admin/assets/vendors/scroll/scrollbar.min.js'></script>
        <script src="<%=request.getContextPath()%>/admin/assets/js/functions.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/chart/chart.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/js/admin.js"></script>

    </body>
</html>
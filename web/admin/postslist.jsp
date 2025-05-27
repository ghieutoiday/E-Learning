<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Post"%>
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
        <title>EduChamp : Education HTML Template </title>

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
                width: 150px;
                padding: 6px 14px;
                font-size: 14px;


            }

            .sort-by-select {
                width: 150px;
                text-align: center;
            }


            /* B? l?c */
            .filters {
                display: flex;
                gap: 60px;

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
                width: 211px;

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
                margin-left: 924px;
            }
            .reset{
                padding-left: 7px;
                padding-right: 8px;

            }
            .search{
                padding-left: 25px;
                padding-right: 20px;
                margin-left: 12px;
            }
            .action{

            }



        </style>
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">


        <c:if test="${  requestScope.checkNull == null}">
            <c:redirect url="/PostController?page=1"/>
        </c:if> 
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
                            <img class="ttr-logo-mobile" alt="" src="assets/images/logo-mobile.png" width="30" height="30">
                            <img class="ttr-logo-desktop" alt="" src="assets/images/logo-white.png" width="160" height="27">
                        </a>
                    </div>
                </div>
                <!--logo end -->
                <div class="ttr-header-menu">
                    <!-- header left menu start -->
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="<%=request.getContextPath()%>/index.jsp" class="ttr-material-button ttr-submenu-toggle">HOME</a>
                        </li>

                    </ul>
                    <!-- header left menu end -->
                </div>
                <div class="ttr-header-right ttr-with-seperator">
                    <!-- header right menu start -->
                    <ul class="ttr-header-navigation">
                        <li>
                            <a href="#" class="ttr-material-button ttr-search-toggle"><i class="fa fa-search"></i></a>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle"><i class="fa fa-bell"></i></a>
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
                                                <a href="#">Your order is placed</a> sent you a message.
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
                                                <span>Your item is shipped</span> sent you a message.
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
                            <a href="#" class="ttr-material-button ttr-submenu-toggle"><span class="ttr-user-avatar"><img alt="" src="assets/images/testimonials/pic3.jpg" width="32" height="32"></span></a>
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
                            <a href="#" class="ttr-material-button"><i class="ti-layout-grid3-alt"></i></a>
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
                            <input type="text" name="qq" placeholder="search something..." class="ttr-search-input">
                            <button type="submit" name="search" class="ttr-search-submit"><i class="ti-arrow-right"></i></button>
                        </div>
                        <span class="ttr-search-close ttr-search-toggle">
                            <i class="ti-close"></i>
                        </span>
                    </form>
                </div>
                <!--header search panel end -->
            </div>
        </header> 
        <!-- Left sidebar menu start -->


        <!-- Main container -->
        <!<!--<main class="ttr-wrapper">-->
        <div class="container-fluid">

            <div class="row">
                <!-- Your Profile Views Chart -->
                <div class="col-lg-12 m-b30">
                    <div class="widget-box">
                        <div class="wc-title">
                            <div class="db-breadcrumb">
                                <h4 class="breadcrumb-title">Posts List</h4>
                                <ul class="db-breadcrumb-list">
                                    <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                                    <li>Posts List</li>
                                </ul>
                            </div>
                            <div class="top-bar">

                                <form action="PostController" method="GET" class="d-flex">
                                    <input type="text" name="search" value="${param.search}" placeholder="Search by title..." class="search-input" />
                                    <input type="hidden" name="page" value="1" />
                                    <button type="submit" class="btn btn-warning search">Search</button>
                                </form>
                                <a href="PostController?action=showAddPost" class="btn btn-warning add-post-btn">Add Post</a>
                            </div>

                            <!-- Bộ lọc -->
                            <div class="filters">
                                <form action="PostController" method="GET" class="d-flex align-items-center text-black" style="color: black;">
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
                                        <c:forEach var="category" items="${requestScope.categories}">
                                            <option value="${category.postCategoryID}" ${param.category eq category.postCategoryID ? 'selected' : ''}>
                                                ${category.postCategoryName}
                                            </option>
                                        </c:forEach>
                                    </select>

                                    <select name="author" class="sort-select">
                                        <option value="" disabled selected hidden>Author</option>
                                        <c:forEach var="author" items="${requestScope.authors}">
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
                                    <a href="PostController" class="btn btn-warning reset">Reset Filters</a>
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
                                        <c:forEach var="post" items="${requestScope.posts}" varStatus="loop">
                                            <tr> 
                                                <td>${post.postID}</td>
                                                <td><img src="${post.thumbnail}" alt="Thumbnail" style="width: 50px; height: 50px; object-fit: cover;"></td>
                                                <td>${post.title}</td>
                                                <td>${post.postCategory.postCategoryName}</td>
                                                <td>${post.owner.fullName}</td>
                                                <td><fmt:formatDate value="${post.createDate}" pattern="dd/MM/yyyy"/></td>
                                                <td>
                                                    <span class="status">
                                                        <span class="dot ${post.status eq 'active' ? 'active' : 'inactive'}"></span>
                                                        ${post.status}
                                                    </span>
                                                </td>
                                                <td>${post.feature ? 'Yes' : 'No'}</td>
                                                <td>
                                                    <a href="PostController?action=view&id=${post.postID}" class="btn btn-info btn-sm">
                                                        View
                                                    </a>
                                                    <a href="PostController?action=edit&id=${post.postID}" class="btn btn-primary btn-sm">
                                                        </i> Edit
                                                    </a>
                                                    <a href="PostController?action=delete&id=${post.postID}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this post?')">
                                                        </i> Delete
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                            </div>
                            <!-- Pagination start -->
                            <div class="pagination-bx rounded-sm gray clearfix">
                                <ul class="pagination">
                                    <c:if test="${requestScope.currentPage > 1}">
                                        <li class="previous">
                                            <a href="PostController?page=${requestScope.currentPage - 1}${requestScope.search != null ? '&search='.concat(requestScope.search) : ''}${requestScope.sortBy != null ? '&sortBy='.concat(requestScope.sortBy) : ''}${requestScope.category != null ? '&category='.concat(requestScope.category) : ''}${requestScope.author != null ? '&author='.concat(requestScope.author) : ''}${requestScope.status != null ? '&status='.concat(requestScope.status) : ''}${requestScope.feature != null ? '&feature='.concat(requestScope.feature) : ''}">
                                                <i class="ti-arrow-left"></i> Prev
                                            </a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="1" end="${requestScope.totalPages}" var="i">
                                        <li class="${requestScope.currentPage == i ? 'active' : ''}">
                                            <a href="PostController?page=${i}${requestScope.search != null ? '&search='.concat(requestScope.search) : ''}${requestScope.sortBy != null ? '&sortBy='.concat(requestScope.sortBy) : ''}${requestScope.category != null ? '&category='.concat(requestScope.category) : ''}${requestScope.author != null ? '&author='.concat(requestScope.author) : ''}${requestScope.status != null ? '&status='.concat(requestScope.status) : ''}${requestScope.feature != null ? '&feature='.concat(requestScope.feature) : ''}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${requestScope.currentPage < requestScope.totalPages}">
                                        <li class="next">
                                            <a href="PostController?page=${requestScope.currentPage + 1}${requestScope.search != null ? '&search='.concat(requestScope.search) : ''}${requestScope.sortBy != null ? '&sortBy='.concat(requestScope.sortBy) : ''}${requestScope.category != null ? '&category='.concat(requestScope.category) : ''}${requestScope.author != null ? '&author='.concat(requestScope.author) : ''}${requestScope.status != null ? '&status='.concat(requestScope.status) : ''}${requestScope.feature != null ? '&feature='.concat(requestScope.feature) : ''}">
                                                Next <i class="ti-arrow-right"></i>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                            <!-- Pagination END -->
                        </div>
                    </div>
                </div>
                <!-- Your Profile Views Chart END-->
            </div>
        </div>
        <!--</main>-->
        <div class="ttr-overlay"></div>

        <!-- External JavaScripts -->

        <!-- External JavaScripts -->
        <script src="<%=request.getContextPath()%>/admin/assets/js/jquery.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <!--<script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>  -->
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
        <script src='<%=request.getContextPath()%>/admin/assets/vendors/calendar/moment.min.js'></script>
        <script src='<%=request.getContextPath()%>/admin/assets/vendors/calendar/fullcalendar.js'></script>
        <!--  <script src='<%=request.getContextPath()%>/admin/assets/vendors/switcher/switcher.js'></script>-->
        <script>
                                                        $(document).ready(function () {

                                                            $('#calendar').fullCalendar({
                                                                header: {
                                                                    left: 'prev,next today',
                                                                    center: 'title',
                                                                    right: 'month,agendaWeek,agendaDay,listWeek'
                                                                },
                                                                defaultDate: '2019-03-12',
                                                                navLinks: true, // can click day/week names to navigate views

                                                                weekNumbers: true,
                                                                weekNumbersWithinDays: true,
                                                                weekNumberCalculation: 'ISO',

                                                                editable: true,
                                                                eventLimit: true, // allow "more" link when too many events
                                                                events: [
                                                                    {
                                                                        title: 'All Day Event',
                                                                        start: '2019-03-01'
                                                                    },
                                                                    {
                                                                        title: 'Long Event',
                                                                        start: '2019-03-07',
                                                                        end: '2019-03-10'
                                                                    },
                                                                    {
                                                                        id: 999,
                                                                        title: 'Repeating Event',
                                                                        start: '2019-03-09T16:00:00'
                                                                    },
                                                                    {
                                                                        id: 999,
                                                                        title: 'Repeating Event',
                                                                        start: '2019-03-16T16:00:00'
                                                                    },
                                                                    {
                                                                        title: 'Conference',
                                                                        start: '2019-03-11',
                                                                        end: '2019-03-13'
                                                                    },
                                                                    {
                                                                        title: 'Meeting',
                                                                        start: '2019-03-12T10:30:00',
                                                                        end: '2019-03-12T12:30:00'
                                                                    },
                                                                    {
                                                                        title: 'Lunch',
                                                                        start: '2019-03-12T12:00:00'
                                                                    },
                                                                    {
                                                                        title: 'Meeting',
                                                                        start: '2019-03-12T14:30:00'
                                                                    },
                                                                    {
                                                                        title: 'Happy Hour',
                                                                        start: '2019-03-12T17:30:00'
                                                                    },
                                                                    {
                                                                        title: 'Dinner',
                                                                        start: '2019-03-12T20:00:00'
                                                                    },
                                                                    {
                                                                        title: 'Birthday Party',
                                                                        start: '2019-03-13T07:00:00'
                                                                    },
                                                                    {
                                                                        title: 'Click for Google',
                                                                        url: 'http://google.com/',
                                                                        start: '2019-03-28'
                                                                    }
                                                                ]
                                                            });

                                                        });

        </script>
    </body>
</html>
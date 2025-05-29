<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="model.Post"%>
<%@page import="dal.PostDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="postDAO" class="dal.PostDAO" scope="request" />

<c:set var="postId" value="${param.id}" />
<c:if test="${not empty postId}">
    <c:set var="post" value="${postDAO.getPostByID(postId)}" scope="request" />
</c:if>

<!DOCTYPE html>
<html>
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
                min-width: 70%; /* ? Search d?i ra */
                padding: 6px 12px;
                font-size: 14px;
            }

            .btn-warning {
                white-space: nowrap;
                padding: 8px 19px;
                font-size: 14px;
                background-color: #f8c61b; /* M?u v?ng nh? h?nh */
                margin-left: 15px;


            }

            .sort-select {
                width: 150px; /* ? Sort by b?ng v?i chi?u r?ng c?a n?t Add Post */
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
                color: #555;  /* Ch? x?m ??m */
                text-align: center;
            }
            .filters select option {
                text-align: left;

            }





            .filters button {
                white-space: nowrap;
                padding: 8px 8px;
                font-size: 14px;
                background-color: #f8c61b; /* M?u v?ng nh? h?nh */
                margin-left: 15px;

            }


            /* B?ng danh s?ch b?i vi?t */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
                border: 1px solid #ddd; /* Vi?n b?ng */
            }

            table th, table td {
                padding: 12px;
                text-align: center;
                border: 1px solid #ddd; /* Vi?n t?ng ? */
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
                background-color: #28a745; /* M?u xanh l? cho Active */
            }

            .status .dot.inactive {
                background-color: #dc3545; /* M?u ?? cho Inactive */
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
            .edit{
                margin-left: 5px;
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
            .row{
                margin-left: -34px;
                margin-right: -34px;
                margin-top: -14px;
            }
            .widget-box{
                padding-bottom: 60px;
            }
            


        </style>
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <!-- Header -->
        <header class="ttr-header">
            <div class="ttr-header-wrapper">
                <!-- Sidebar menu toggler -->
                <div class="ttr-toggle-sidebar ttr-material-button">
                    <i class="ti-close ttr-open-icon"></i>
                    <i class="ti-menu ttr-close-icon"></i>
                </div>
                <!-- Logo --> 
                <div class="ttr-logo-box">
                    <div>
                        <a href="index.jsp" class="ttr-logo">
                            <img alt="" class="ttr-logo-mobile" src="assets/images/logo-mobile.png" width="30" height="30">
                            <img alt="" class="ttr-logo-desktop" src="assets/images/logo-white.png" width="160" height="27">
                        </a>
                    </div>
                </div>
                <!-- Header menu -->
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
                    <ul class="ttr-header-navigation">
                       


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

                    </ul>
                </div>
                <!-- Header search panel -->
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
            </div>
        </header>

        <!-- Left sidebar menu -->



        <!-- Main container -->

        <div class="container-fluid">
            <div class="db-breadcrumb">
                <h4 class="breadcrumb-title" style="font-size: 24;">Post Details</h4>
                <ul class="db-breadcrumb-list">
                    <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                    <li>Post Details</li>
                </ul>
            </div>
            <div class="row">
                <div class="col-lg-12 m-b30">
                    <div class="widget-box">
                        <div class="db-breadcrumb">
                            <h4 class="breadcrumb-title" style="font-size: 24px;">Post Details</h4>
                            <ul class="db-breadcrumb-list">
                                <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                                <li>Post Details</li>
                            </ul>
                        </div>
                        <div class="post-detail" style="margin-left: 5px;">
                            <div class="post-header">
                                <h1>${post.title}</h1>
                                <div class="post-meta">
                                    <p>
                                        <i class="fa fa-user"></i> Author: ${post.owner.fullName} |
                                        <i class="fa fa-folder"></i> Category: ${post.postCategory.postCategoryName} |
                                        <i class="fa fa-calendar"></i> Created: <fmt:formatDate value="${post.createDate}" pattern="dd/MM/yyyy"/> |
                                        <i class="fa fa-calendar"></i> Updated: <fmt:formatDate value="${post.updateDate}" pattern="dd/MM/yyyy"/>
                                    </p>
                                    <p>
                                        <span class="status">
                                            <span class="dot ${post.status eq 'Active' ? 'active' : 'inactive'}"></span>
                                            ${post.status}
                                        </span>

                                        <c:if test="${post.feature}">
                                            <span class="feature-badge">|| Featured</span>
                                        </c:if>
                                    </p>
                                </div>
                            </div>

                            <c:if test="${not empty post.thumbnail}">
                                <img src="${post.thumbnail}" alt="${post.title}" class="post-thumbnail">
                            </c:if>

                            <div class="post-content">
                                <h3>Brief Info</h3>
                                <p>${post.briefInfo}</p>

                                <h3>Description</h3>
                                <p>${post.description}</p>
                            </div>

                            <div class="mt-4">
                                <a href="postslist.jsp" class="btn btn-secondary">Back to Posts List
                                </a>
                                <a href="editpost.jsp?id=${post.postID}" class="btn btn-primary edit">Edit Post
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

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
        <script src='<%=request.getContextPath()%>/admin/assets/vendors/calendar/moment.min.js'></script>
        <script src='<%=request.getContextPath()%>/admin/assets/vendors/calendar/fullcalendar.js'></script>


    </body>
</html> 
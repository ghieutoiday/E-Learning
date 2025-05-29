<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="model.Post"%>
<%@page import="model.PostCategory"%>
<%@page import="model.User"%>
<%@page import="dal.PostDAO"%>
<%@page import="dal.PostCategoryDAO"%>
<%@page import="dal.UserDAO"%>
<%@page import="java.util.List"%>

<jsp:useBean id="postDAO" class="dal.PostDAO" scope="request" />
<jsp:useBean id="categoryDAO" class="dal.PostCategoryDAO" scope="request" />
<jsp:useBean id="userDAO" class="dal.UserDAO" scope="request" />

<c:if test="${pageContext.request.method == 'POST'}">
    <c:set var="title" value="${param.title}" />
    <c:set var="briefInfo" value="${param.briefInfo}" />
    <c:set var="description" value="${param.description}" />
    <c:set var="thumbnail" value="${param.thumbnail}" />
    <c:set var="categoryId" value="${param.categoryId}" />
    <c:set var="status" value="${param.status}" />
    <c:set var="feature" value="${param.feature != null}" />

    <jsp:useBean id="post" class="model.Post" scope="page" />
    <jsp:setProperty name="post" property="title" value="${title}" />
    <jsp:setProperty name="post" property="briefInfo" value="${briefInfo}" />
    <jsp:setProperty name="post" property="description" value="${description}" />
    <jsp:setProperty name="post" property="thumbnail" value="${thumbnail}" />
    <jsp:setProperty name="post" property="postCategory" value="${categoryDAO.getPostCategoryByID(categoryId)}" />
    <jsp:setProperty name="post" property="status" value="${status}" />
    <jsp:setProperty name="post" property="feature" value="${feature}" />
    <jsp:setProperty name="post" property="owner" value="${userDAO.getUserByEmail('nguyenthihoa@gmail.com')}" />
    <jsp:setProperty name="post" property="createDate" value="<%= new java.util.Date() %>" />

    <c:set var="result" value="${postDAO.addPost(post)}" />
    <c:redirect url="postslist.jsp" />
</c:if>

<c:set var="categories" value="${categoryDAO.getAllPostCategories()}" scope="request" />
<c:set var="marketingUser" value="${userDAO.getUserByEmail('nguyenthihoa@gmail.com')}" scope="request" />

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
            .post-form{
                margin-left: 25px;
            }
            .db-breadcrumb{

                margin-top: 10px;
            }
        </style>

    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
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
        <div class="db-breadcrumb">
            <h4 class="breadcrumb-title" style="font-size: 24px;">Add New Post</h4>
            <ul class="db-breadcrumb-list">
                <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                <li>Add New Post</li>
            </ul>
        </div>

        <div class="row">
            <div class="col-lg-12 m-b30">
                <div class="widget-box">
                    <form method="POST" class="post-form">
                        <div class="db-breadcrumb">
                            <h4 class="breadcrumb-title" style="font-size: 24px;">Add New Post</h4>
                            <ul class="db-breadcrumb-list">
                                <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                                <li>Add New Post</li>
                            </ul>
                        </div>
                        <div class="form-group">
                            <label for="title">Title</label>
                            <input type="text" class="form-control" id="title" name="title" required>
                        </div>

                        <div class="form-group">
                            <label for="briefInfo">Brief Info</label>
                            <textarea class="form-control" id="briefInfo" name="briefInfo" rows="3" required></textarea>
                        </div>

                        <div class="form-group">
                            <label for="description">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="5" required></textarea>
                        </div>

                        <div class="form-group">
                            <label for="thumbnail">Thumbnail URL</label>
                            <input type="url" class="form-control" id="thumbnail" name="thumbnail" required>
                        </div>

                        <div class="form-group">
                            <label for="categoryId">Category</label>
                            <select class="form-control" id="categoryId" name="categoryId" required>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.postCategoryID}">
                                        ${category.postCategoryName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="status">Status</label>
                            <select class="form-control" id="status" name="status" required>
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" id="feature" name="feature">
                                <label class="custom-control-label" for="feature">Feature this post</label>
                            </div>
                        </div>

                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">Add Post</button>
                            <a href="postslist.jsp" class="btn btn-secondary">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/admin/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/assets/vendors/bootstrap/js/popper.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/assets/vendors/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/assets/js/functions.js"></script>
</body>
</html> 
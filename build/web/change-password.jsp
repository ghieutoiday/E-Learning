<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Change Password</title>
    
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
    
    <!-- Custom Styles for Change Password Form -->
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }
        .change-password-container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 0 30px;
        }
        .change-password {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            margin: 0 auto;
            text-align: left;
        }
        .change-password h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
            text-align: left;
        }
        .change-password input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            box-sizing: border-box;
            background-color: #f5faff;
        }
        .change-password input:focus {
            border-color: #00c4cc;
            outline: none;
        }
        .change-password input::placeholder {
            color: #666;
        }
        .change-password button {
            background-color: #00c4cc;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
            margin-top: 10px;
            display: block;
            margin-left: auto;
        }
        .change-password button:hover {
            background-color: #0097a7;
        }
        .change-password .notification {
            color: #d63031;
            font-size: 14px;
            margin-bottom: 10px;
            text-align: left;
        }
        .change-password form {
            display: flex;
            flex-direction: column;
            align-items: stretch;
        }
        .change-password .button-row {
            display: flex;
            align-items: center;
            margin-top: 15px;
            justify-content: flex-end;
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
                                    <li><a href="blog-list-sidebar.jsp">Blog List Sidebar</a></li>
                                    <li><a href="blog-standard-sidebar.jsp">Blog Standard Sidebar</a></li>
                                    <li><a href="blog-details.jsp">Blog Details</a></li>
                                </ul>
                            </li>
                            <li class="nav-dashboard"><a href="javascript:;">Dashboard <i class="fa fa-chevron-down"></i></a>
                                <ul class="sub-menu">
                                    <li><a href="admin/index.jsp">Dashboard</a></li>
                                    <li><a href="admin/add-listing.jsp">Add Listing</a></li>
                                    <li><a href="admin/bookmark.jsp">Bookmark</a></li>
                                    <li><a href="admin/postslist.jsp">Posts List</a></li>
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
    <!-- Header Top END ==== -->

    <!-- Content -->
    <div class="page-content bg-white">
        <!-- Inner page banner -->
        <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner1.jpg);">
            <div class="container">
                <div class="page-banner-entry">
                    <h1 class="text-white">Change Password</h1>
                </div>
            </div>
        </div>
        <!-- Breadcrumb row -->
        <div class="breadcrumb-row">
            <div class="container">
                <ul class="list-inline">
                    <li><a href="index.jsp">Home</a></li>
                    <li>Change Password</li>
                </ul>
            </div>
        </div>
        <!-- Breadcrumb row END -->
        <div class="content-block">
            <div class="section-area section-sp1">
                <div class="change-password-container">
                    <div class="change-password">
                        <h2>Change Password</h2>
                        <form method="get" action="usercontroller">
                            <input type="hidden" name="action" value="changePassword">
                            <input type="email" name="email" value="dangkhuong28062004@gmail.com" placeholder="Email" required>
                            <input type="password" name="password" value="" placeholder="Old Password" required>
                            <input type="password" name="newPassword" value="" placeholder="New Password" required>
                            <input type="password" name="confirmPassword" value="" placeholder="Password Confirm" required>
                            <div class="button-row">
                                <c:if test="${not empty requestScope.mess}">
                                    <div class="notification">${requestScope.mess}</div>
                                </c:if>
                                <button type="submit">Save</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Content END -->

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
</div>
</body>
</html>
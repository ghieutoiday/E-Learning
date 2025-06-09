<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <title>EduChamp : Education HTML Template </title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">



        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

        <!-- REVOLUTION SLIDER CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/layers.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/settings.css">
        <link rel="stylesheet" type="text/css" href="assets/vendors/revolution/css/navigation.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
        <!-- REVOLUTION SLIDER END -->
        <style>
            .container-fluid {
                margin-top: 145px;
            }

            .sidebar {
                margin-top: 40px;
            }

            .menu-bar {
                background-color: black;
            }

            .top-bar {
                background-color: black;
            }

            .swiper-container {
                width: 100%;
                height: 270px;
                /* Chiều cao cố định của slider */
                position: relative;
            }

            .swiper-wrapper {
                display: flex;
            }

            .swiper-slide {
                display: flex;
                justify-content: space-between;
                align-items: center;
                /* padding: 20px; */
                background: linear-gradient(45deg, #59b1d4, #2797ff);
                color: white;
                height: 100%;
                border-radius: 10px;
                box-sizing: border-box;
                overflow: hidden;
            }

            .swiper-slide .content {
                max-width: 500px;
                z-index: 10;
                /* Đảm bảo nội dung không bị che khuất bởi ảnh */
                margin-left: 30px;
            }

            .swiper-slide h2 {
                font-size: 1.8rem;
                margin-bottom: 10px;
            }

            .swiper-slide p {
                font-size: 1.1rem;
                margin-bottom: 20px;
            }

            .swiper-slide .subscribe-button {
                background-color: white;
                color: #FF1F3E;
                padding: 10px 20px;
                text-decoration: none;
                font-weight: bold;
                border-radius: 5px;
            }

            .swiper-slide .image {
                flex: 1;
                /* Hình ảnh sẽ chiếm không gian còn lại */
                display: flex;
                justify-content: center;
                align-items: center;
                position: relative;
                max-width: 666px;
            }

            .swiper-slide .image img {
                width: 100%;
                /* Chiếm toàn bộ chiều rộng của phần tử chứa */
                height: 270px;
                /* Chiều cao ảnh cố định bằng chiều cao của slider */
                object-fit: cover;
                /* Đảm bảo ảnh không bị méo và không bị kéo dãn */
                /* border-radius: 10px; */
            }


            .swiper-button-next:after,
            .swiper-button-prev:after {

                font-size: 26px;
            }

            /* Nút Next và Prev sử dụng SVG */
            .swiper-button-next,
            .swiper-button-prev {
                color: white;
                background-color: rgba(0, 0, 0, 0.7);
                padding: 22px;
                border-radius: 50%;
                position: absolute;
                top: 50%;
                /* transform: translateY(-50%); */
                z-index: 20;
                transition: background-color 0.3s ease, transform 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
            }

            .swiper-button-next:hover,
            .swiper-button-prev:hover {
                background-color: rgba(0, 0, 0, 0.9);
                /* transform: translateY(-50%) scale(1.1); */
                /* Tăng kích thước khi hover */
            }


            /* Pagination */
            .swiper-pagination-bullet {
                background-color: rgba(255, 255, 255, 0.5);
            }

            .swiper-pagination-bullet-active {
                background-color: white;
            }

            /* Ẩn phần ảnh khi thu nhỏ màn hình */
            @media (max-width: 768px) {
                .swiper-slide .image img {
                    display: none;
                    /* Ẩn ảnh khi màn hình nhỏ */
                }

                .swiper-slide .content {
                    max-width: 100%;
                    margin-left: 0;
                }
            }

            /* Custom CSS for sidebar */
            .sidebar {
                width: 150px;
                position: fixed;
                top: 90px;
                left: 0;
                height: 100%;
                background-color: #ffffff;
                padding-top: 20px;
                color: #fff;
                z-index: 999;
            }

            .sidebar ul {
                list-style: none;
                padding: 0;
            }

            .sidebar ul li a {
                color: #000000;
                text-decoration: none;
                padding: 10px 20px;
                display: block;
            }

            .sidebar ul li a:hover {
                background-color: #555;
            }

            .content-wrapper {
                margin-left: 150px;
                padding: 20px;
            }

            @media (max-width: 768px) {
                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                }

                .content-wrapper {
                    margin-left: 0;
                }
            }
        </style>

    </head>

    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            <!-- Sidebar -->
            <div class="sidebar">
                <ul>
                    <li><a style="display: flex; flex-direction: column; align-items: center;"
                           href="index.jsp"><i class="fa fa-home"></i> Home</a></li>
                    <li><a style="display: flex; flex-direction: column; align-items: center;"
                           href="blogcontroller?pageforward=bloglist"><i class="fa fa-newspaper-o"></i> Latest
                            Post</a></li>
                    <li><a style="display: flex; flex-direction: column; align-items: center;"
                           href="contact-1.jsp"><i class="fa fa-envelope-o"></i> Contact</a></li>
                </ul>
            </div>

            <div class="content-wrapper">
                <!-- Header Top ==== -->
                <header class="ttr-header rs-nav ">

                    <div class=" navbar-expand-lg is-fixed">
                        <div class="menu-bar clearfix" style="z-index: 9999;">
                            <div class="container clearfix">
                                <!-- Header Logo ==== -->
                                <div class="top-bar">
                                    <div class="container">
                                        <div class="row d-flex justify-content-between">
                                            <div class="topbar-left">
                                                <ul>
                                                    <li><a href="faq-1.jsp" style="color:white"><i
                                                                class="fa fa-question-circle"></i>Ask a
                                                            Question</a></li>
                                                    <li><a href="javascript:;" style="color:white"><i
                                                                class="fa fa-envelope-o"></i>Support@website.com</a>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="topbar-right">
                                                <ul>

                                                    <li><a href="login.jsp" style="color:white">Login</a></li>
                                                    <li><a href="register.jsp" style="color:white">Register</a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="menu-logo">
                                    <a href="home"><img src="assets/images/logo-white.png" alt=""></a>
                                </div>
                                <!-- Mobile Nav Button ==== -->
                                <button class="navbar-toggler collapsed menuicon justify-content-end"
                                        type="button" data-toggle="collapse" data-target="#menuDropdown"
                                        aria-controls="menuDropdown" aria-expanded="false"
                                        aria-label="Toggle navigation">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </button>
                                <!-- Author Nav ==== -->
                                <div class="secondary-menu">
                                    <div class="secondary-inner">
                                        <ul>

                                            <li><a href="javascript:;" class="btn-link" style="color:white"><i
                                                        class="fa fa-google-plus"></i></a></li>
                                            <li></li>
                                            <li  style="color:white">||</li>
                                            <!-- Search Button ==== -->


                                            <!--My Course / My Registration-->
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <li><a href="mycoursecontroller" class="btn-link customer-course"
                                                   style="color:white">
                                                    <p>My Courses</p>
                                                </a></li>
                                            &nbsp;&nbsp;&nbsp;
                                            <li><a href="registrationcontroller"
                                                   class="btn-link customer-registration" style="color:white">
                                                    <p>My Registrations</p>
                                                </a></li>
                                        </ul>
                                    </div>
                                </div>
                                <!-- Search Box ==== -->

                                <!-- Navigation Menu ==== -->
                                <div class="menu-links navbar-collapse collapse justify-content-start"
                                     id="menuDropdown">
                                    <div class="menu-logo">
                                        <a href="home"><img src="assets/images/logo.png" alt=""></a>
                                    </div>
                                    <ul class="nav navbar-nav">
                                        <li class="active"><a href="javascript:;" style="color:white;">Home <i
                                                    class="fa fa-chevron-down"></i></a>
                                            <ul class="sub-menu">
                                                <li><a href="home">Home 1</a></li>
                                                <li><a href="index-2.jsp">Home 2</a></li>
                                            </ul>
                                        </li>
                                        <li><a href="javascript:;" style="color:white;">Pages <i
                                                    class="fa fa-chevron-down"></i></a>
                                            <ul class="sub-menu">
                                                <li><a href="javascript:;">About<i
                                                            class="fa fa-angle-right"></i></a>
                                                    <ul class="sub-menu">
                                                        <li><a href="about-1.jsp">About 1</a></li>
                                                        <li><a href="about-2.jsp">About 2</a></li>
                                                    </ul>
                                                </li>
                                                <li><a href="javascript:;">Event<i
                                                            class="fa fa-angle-right"></i></a>
                                                    <ul class="sub-menu">
                                                        <li><a href="event.jsp">Event</a></li>
                                                        <li><a href="events-details.jsp">Events Details</a></li>
                                                    </ul>
                                                </li>
                                                <li><a href="javascript:;">FAQ's<i
                                                            class="fa fa-angle-right"></i></a>
                                                    <ul class="sub-menu">
                                                        <li><a href="faq-1.jsp">FAQ's 1</a></li>
                                                        <li><a href="faq-2.jsp">FAQ's 2</a></li>
                                                    </ul>
                                                </li>
                                                <li><a href="javascript:;">Contact Us<i
                                                            class="fa fa-angle-right"></i></a>
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
                                        <li class="add-mega-menu"><a href="javascript:;"
                                                                     style="color:white;">Our Courses <i
                                                    class="fa fa-chevron-down"></i></a>
                                            <ul class="sub-menu add-menu">
                                                <li class="add-menu-left">
                                                    <h5 class="menu-adv-title">Our Courses</h5>
                                                    <ul>
                                                        <li><a href="courses.jsp">Courses </a></li>
                                                        <li><a href="courses-details.jsp">Courses Details</a>
                                                        </li>
                                                        <li><a href="profile.jsp">Instructor Profile</a></li>
                                                        <li><a href="event.jsp">Upcoming Event</a></li>
                                                        <li><a href="membership.jsp">Membership</a></li>
                                                    </ul>
                                                </li>
                                                <li class="add-menu-right">
                                                    <img src="assets/images/adv/adv.jpg" alt="" />
                                                </li>
                                            </ul>
                                        </li>
                                        <li><a href="javascript:;" style="color:white;">Blog <i
                                                    class="fa fa-chevron-down"></i></a>
                                            <ul class="sub-menu">
                                                <li><a href="blog-classic-grid.jsp">Blog Classic</a></li>
                                                <li><a href="blog-classic-sidebar.jsp">Blog Classic Sidebar</a>
                                                </li>
                                                <li><a href="blogcontroller?pageforward=bloglist">Blog List
                                                        Sidebar</a></li>
                                                <li><a href="blog-standard-sidebar.jsp">Blog Standard
                                                        Sidebar</a>
                                                </li>
                                                <li><a href="blogcontroller?pageforward=blogdetail">Blog
                                                        Details</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li class="nav-dashboard"><a href="javascript:;"
                                                                     style="color:white;">Dashboard <i
                                                    class="fa fa-chevron-down"></i></a>
                                            <ul class="sub-menu">
                                                <li><a href="admin/index.jsp">Dashboard</a></li>
                                                <li><a href="slidercontroller">Sliders List</a></li>
                                                <li><a href="admin/bookmark.jsp">Bookmark</a></li>
                                                <li><a href="postcontroller">Posts List</a></li>
                                                <li><a href="admin/review.jsp">Review</a></li>
                                                <li><a href="admin/teacher-profile.jsp">Teacher Profile</a></li>
                                                <li><a href="admin/user-profile.jsp">User Profile</a></li>
                                                <li><a href="coursecontroller">Subject List</a></li>
                                                <li><a href="change-password.jsp">Change Password</a></li>
                                                <li><a href="javascript:;">Calendar<i
                                                            class="fa fa-angle-right"></i></a>
                                                    <ul class="sub-menu">
                                                        <li><a href="admin/basic-calendar.jsp">Basic
                                                                Calendar</a>
                                                        </li>
                                                        <li><a href="admin/list-view-calendar.jsp">List View
                                                                Calendar</a></li>
                                                    </ul>
                                                </li>
                                                <li><a href="javascript:;" style="color:white;">Mailbox<i
                                                            class="fa fa-angle-right"></i></a>
                                                    <ul class="sub-menu">
                                                        <li><a href="admin/mailbox.jsp">Mailbox</a></li>
                                                        <li><a href="admin/mailbox-compose.jsp">Compose</a></li>
                                                        <li><a href="admin/mailbox-read.jsp">Mail Read</a></li>
                                                    </ul>
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>


                                </div>
                                <!-- Navigation Menu END ==== -->
                            </div>
                        </div>
                    </div>
                </header>
                <!-- Header Top END ==== -->
                <!-- Content -->
                <div class="ttr-wrapper" style="margin-top: 50px;">
                    <!-- Left sidebar menu start -->

                    <!-- Left sidebar menu end -->
                    <!-- Main container -->
                    <div class="container-fluid">
                        ${param.content}
                        <!-- Content after sidebar goes here -->

                        <!-- Swiper Slider -->
                        <div class="swiper-container mt-10">
                            <div class="swiper-wrapper">
                                <c:forEach var="slider" items="${sliders}">
                                    <div class="swiper-slide">
                                        <div class="content">
                                            <h2 style="color: #fff;">${slider.title}</h2>
                                            <p>${slider.notes}</p>
                                            <a href="${slider.backlink}" class="subscribe-button">Read More </a>
                                        </div>
                                        <div class="image">
                                            <img src="${slider.image}" alt="${slider.title}">
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Pagination and Navigation -->
                            <div class="swiper-pagination"></div>
                            <div class="swiper-button-next"></div>
                            <div class="swiper-button-prev"></div>
                        </div>
                        <!-- Our Services END -->


                        <!-- Popular Post-->
                        <div class="section-area section-sp2 popular-courses-bx">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-12 heading-bx left">
                                        <h2 class="title-head">HOT POSTS</h2>
                                        <p>It is a long established fact that a reader will be distracted by
                                            the readable content of a page</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="courses-carousel owl-carousel owl-btn-1 col-12 p-lr0">
                                        <c:forEach var="post" items="${posts}">
                                            <div class="item">
                                                <div class="cours-bx" style="  height: 300px; /* Fixed height for all cards */
                                                     display: flex;
                                                     flex-direction: column;">
                                                    <div class="action-box" style="  height: 200px; /* Fixed height for image container */
                                                         overflow: hidden;">
                                                        <img src="${post.thumbnail}" alt="" style="width: 100%;
                                                             height: 200px;
                                                             object-fit: cover;">
                                                        <a href="blogcontroller?postID=${post.postID}&pageforward=blogdetail" class="btn">Read More</a>
                                                    </div>
                                                    <div class="info-bx text-center">
                                                        <h5><a href="blogcontroller?postID=${post.postID}&pageforward=blogdetail">${post.title}</a>
                                                        </h5>
                                                        <span>
                                                            <fmt:formatDate value="${post.createDate}"
                                                                            pattern="dd/MM/yyyy" />
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="section-area section-sp2 popular-courses-bx">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-12 heading-bx left">
                                        <h2 class="title-head">Popular <span>Courses</span></h2>
                                        <p>It is a long established fact that a reader will be distracted by
                                            the readable content of a page </p>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="courses-carousel owl-carousel owl-btn-1 col-12 p-lr0">
                                        <c:forEach var="i" items="${sessionScope.courseList}">
                                            <div class="item">
                                                <div class="cours-bx" style="  height: 300px; /* Fixed height for all cards */
                                                     display: flex;
                                                     flex-direction: column;">
                                                    <div class="action-box" style="  height: 200px; /* Fixed height for image container */
                                                         overflow: hidden;">
                                                        <img src="${i.thumbnail}" alt="" style="width: 100%;
                                                             height: 200px;
                                                             object-fit: cover;">

                                                        <a href="course/${i.courseID}" class="btn">Read More</a>
                                                    </div>
                                                    <div class="info-bx text-center">
                                                        <h5><a href="course/${i.courseID}">${i.courseName}</a>
                                                        </h5>
                                                        <span>${i.courseCategory}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
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
                                <a href="home"><img src="assets/images/logo-white.png" alt="" /></a>
                            </div>
                            <div class="pt-social-link">
                                <ul class="list-inline m-a0">

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
                                <p class="text-capitalize m-b20">Weekly Breaking news analysis and cutting edge
                                    advices on job searching.</p>
                                <div class="subscribe-form m-b20">
                                    <form class="subscription-form"
                                          action="http://educhamp.themetrades.com/demo/assets/script/mailchamp.php"
                                          method="post">
                                        <div class="ajax-message"></div>
                                        <div class="input-group">
                                            <input name="email" required="required" class="form-control"
                                                   placeholder="Your Email Address" type="email">
                                            <span class="input-group-btn">
                                                <button name="submit" value="Submit" type="submit"
                                                        class="btn"><i class="fa fa-arrow-right"></i></button>
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
                                            <li><a
                                                    href="http://educhamp.themetrades.com/admin/index.jsp">Dashboard</a>
                                            </li>
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
                                    <li><a href="assets/images/gallery/pic1.jpg" class="magnific-anchor"><img
                                                src="assets/images/gallery/pic1.jpg" alt=""></a></li>
                                    <li><a href="assets/images/gallery/pic2.jpg" class="magnific-anchor"><img
                                                src="assets/images/gallery/pic2.jpg" alt=""></a></li>
                                    <li><a href="assets/images/gallery/pic3.jpg" class="magnific-anchor"><img
                                                src="assets/images/gallery/pic3.jpg" alt=""></a></li>
                                    <li><a href="assets/images/gallery/pic4.jpg" class="magnific-anchor"><img
                                                src="assets/images/gallery/pic4.jpg" alt=""></a></li>
                                    <li><a href="assets/images/gallery/pic5.jpg" class="magnific-anchor"><img
                                                src="assets/images/gallery/pic5.jpg" alt=""></a></li>
                                    <li><a href="assets/images/gallery/pic6.jpg" class="magnific-anchor"><img
                                                src="assets/images/gallery/pic6.jpg" alt=""></a></li>
                                    <li><a href="assets/images/gallery/pic7.jpg" class="magnific-anchor"><img
                                                src="assets/images/gallery/pic7.jpg" alt=""></a></li>
                                    <li><a href="assets/images/gallery/pic8.jpg" class="magnific-anchor"><img
                                                src="assets/images/gallery/pic8.jpg" alt=""></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 text-center"> <a target="_blank"
                                                                                   href="https://www.templateshub.net">Templates Hub</a></div>
                    </div>
                </div>
            </div>
        </footer>
        <!-- Footer END ==== -->
        <button class="back-to-top fa fa-chevron-up"></button>
    </div>
    <script>
        window.onload = function () {
            var currentPath = window.location.pathname;
            var contextPath = '${pageContext.request.contextPath}';
            if (currentPath === contextPath ||
                    currentPath === contextPath + '/' ||
                    currentPath === contextPath + '/index.jsp') {
                window.location.href = contextPath + '/home';
            }
        };
    </script>

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
    <!-- Revolution JavaScripts Files -->
    <script src="assets/vendors/revolution/js/jquery.themepunch.tools.min.js"></script>
    <script src="assets/vendors/revolution/js/jquery.themepunch.revolution.min.js"></script>
    <!-- Slider revolution 5.0 Extensions  (Load Extensions only on Local File Systems !  The following part can be removed on Server for On Demand Loading) -->
    <script src="assets/vendors/revolution/js/extensions/revolution.extension.actions.min.js"></script>
    <script src="assets/vendors/revolution/js/extensions/revolution.extension.carousel.min.js"></script>
    <script src="assets/vendors/revolution/js/extensions/revolution.extension.kenburn.min.js"></script>
    <script
    src="assets/vendors/revolution/js/extensions/revolution.extension.layeranimation.min.js"></script>
    <script src="assets/vendors/revolution/js/extensions/revolution.extension.migration.min.js"></script>
    <script src="assets/vendors/revolution/js/extensions/revolution.extension.navigation.min.js"></script>
    <script src="assets/vendors/revolution/js/extensions/revolution.extension.parallax.min.js"></script>
    <script src="assets/vendors/revolution/js/extensions/revolution.extension.slideanims.min.js"></script>
    <script src="assets/vendors/revolution/js/extensions/revolution.extension.video.min.js"></script>
    <script>
        jQuery(document).ready(function () {
            var ttrevapi;
            var tpj = jQuery;
            if (tpj("#rev_slider_486_1").revolution == undefined) {
                revslider_showDoubleJqueryError("#rev_slider_486_1");
            } else {
                ttrevapi = tpj("#rev_slider_486_1").show().revolution({
                    sliderType: "standard",
                    jsFileLocation: "assets/vendors/revolution/js/",
                    sliderLayout: "fullwidth",
                    dottedOverlay: "none",
                    delay: 9000,
                    navigation: {
                        keyboardNavigation: "on",
                        keyboard_direction: "horizontal",
                        mouseScrollNavigation: "off",
                        mouseScrollReverse: "default",
                        onHoverStop: "on",
                        touch: {
                            touchenabled: "on",
                            swipe_threshold: 75,
                            swipe_min_touches: 1,
                            swipe_direction: "horizontal",
                            drag_block_vertical: false
                        }
                        ,
                        arrows: {
                            style: "uranus",
                            enable: true,
                            hide_onmobile: false,
                            hide_onleave: false,
                            tmp: '',
                            left: {
                                h_align: "left",
                                v_align: "center",
                                h_offset: 10,
                                v_offset: 0
                            },
                            right: {
                                h_align: "right",
                                v_align: "center",
                                h_offset: 10,
                                v_offset: 0
                            }
                        },

                    },
                    viewPort: {
                        enable: true,
                        outof: "pause",
                        visible_area: "80%",
                        presize: false
                    },
                    responsiveLevels: [1240, 1024, 778, 480],
                    visibilityLevels: [1240, 1024, 778, 480],
                    gridwidth: [1240, 1024, 778, 480],
                    gridheight: [768, 600, 600, 600],
                    lazyType: "none",
                    parallax: {
                        type: "scroll",
                        origo: "enterpoint",
                        speed: 400,
                        levels: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 46, 47, 48, 49, 50, 55],
                        type: "scroll",
                    },
                    shadow: 0,
                    spinner: "off",
                    stopLoop: "off",
                    stopAfterLoops: -1,
                    stopAtSlide: -1,
                    shuffle: "off",
                    autoHeight: "off",
                    hideThumbsOnMobile: "off",
                    hideSliderAtLimit: 0,
                    hideCaptionAtLimit: 0,
                    hideAllCaptionAtLilmit: 0,
                    debugMode: false,
                    fallbacks: {
                        simplifyAll: "off",
                        nextSlideOnWindowFocus: "off",
                        disableFocusListener: false,
                    }
                });
            }
        });
    </script>

    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <script>
        const swiper = new Swiper('.swiper-container', {
            loop: true,
            slidesPerView: 1,
            spaceBetween: 50,
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
            pagination: {
                el: '.swiper-pagination',
                clickable: true,
            },
            autoplay: {
                delay: 5000, // Chuyển slide tự động sau 5 giây
            },
        });
    </script>
</body>

</html>
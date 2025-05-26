<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                        <li>
                            <a href="#" class="ttr-material-button ttr-submenu-toggle">QUICK MENU <i class="fa fa-angle-down"></i></a>
                            <div class="ttr-header-submenu">
                                <ul>
                                    <li><a href="<%=request.getContextPath()%>/courses.jsp">Our Posts List</a></li>
                                    <li><a href="<%=request.getContextPath()%>/event.jsp">New Event</a></li>
                                    <li><a href="<%=request.getContextPath()%>/membership.jsp">Membership</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <!-- header left menu end -->
                </div>
                <div class="ttr-header-right ttr-with-seperator">
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
                                            <span class="notification-icon_dashbg-gray">
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
                                <a href="#"><i class="fa fa-music"></i><span>Musics</span></a>
                                <a href="#"><i class="fa fa-youtube-play"></i><span>Videos</span></a>
                                <a href="#"><i class="fa fa-envelope"></i><span>Emails</span></a>
                                <a href="#"><i class="fa fa-book"></i><span>Reports</span></a>
                                <a href="#"><i class="fa fa-smile-o"></i><span>Persons</span></a>
                                <a href="#"><i class="fa fa-picture-o"></i><span>Pictures</span></a>
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
        <div class="ttr-sidebar">
            <div class="ttr-sidebar-wrapper content-scroll">
                <div class="ttr-sidebar-logo">
                    <a href="#"><img alt="" src="assets/images/logo.png" width="122" height="27"></a>
                    <div class="ttr-sidebar-toggle-button">
                        <i class="ti-arrow-left"></i>
                    </div>
                </div>
                <nav class="ttr-sidebar-navi">
                    <ul>
                        <li>
                            <a href="index.jsp" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-home"></i></span>
                                <span class="ttr-label">Dashboard</span>
                            </a>
                        </li>
                        <li>
                            <a href="./admin/postslist.jsp" class="ttr-material-button">
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
                                <li><a href="mailbox.jsp" class="ttr-material-button"><span class="ttr-label">Mail Box</span></a></li>
                                <li><a href="mailbox-compose.jsp" class="ttr-material-button"><span class="ttr-label">Compose</span></a></li>
                                <li><a href="mailbox-read.jsp" class="ttr-material-button"><span class="ttr-label">Mail Read</span></a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="#" class="ttr-material-button">
                                <span class="ttr-icon"><i class="ti-calendar"></i></span>
                                <span class="ttr-label">Calendar</span>
                                <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                            </a>
                            <ul>
                                <li><a href="basic-calendar.jsp" class="ttr-material-button"><span class="ttr-label">Basic Calendar</span></a></li>
                                <li><a href="list-view-calendar.jsp" class="ttr-material-button"><span class="ttr-label">List View</span></a></li>
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
                                <li><a href="user-profile.jsp" class="ttr-material-button"><span class="ttr-label">User Profile</span></a></li>
                                <li><a href="teacher-profile.jsp" class="ttr-material-button"><span class="ttr-label">Teacher Profile</span></a></li>
                            </ul>
                        </li>
                        <li class="ttr-seperate"></li>
                    </ul>
                </nav>
            </div>
        </div>

        <!-- Main container -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Post Details</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Post Details</li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="post-detail">
                                <div class="post-header">
                                    <h1>${post.title}</h1>
                                    <div class="post-meta">
                                        <p>
                                            <i class="fas fa-user"></i> Author: ${post.owner.fullName} |
                                            <i class="fas fa-folder"></i> Category: ${post.postCategory.postCategoryName} |
                                            <i class="fas fa-calendar"></i> Created: <fmt:formatDate value="${post.createDate}" pattern="dd/MM/yyyy HH:mm"/> |
                                            <i class="fas fa-clock"></i> Updated: <fmt:formatDate value="${post.updateDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </p>
                                        <p>
                                            <span class="post-status ${post.status eq 'published' ? 'status-published' : 'status-draft'}">
                                                ${post.status}
                                            </span>
                                            <c:if test="${post.feature}">
                                                <span class="feature-badge">Featured</span>
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
                                    <a href="PostController" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left"></i> Back to Posts List
                                    </a>
                                    <a href="PostController?action=edit&id=${post.postID}" class="btn btn-primary">
                                        <i class="fas fa-edit"></i> Edit Post
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
<!-- External JavaScripts -->
<script src="<%=request.getContextPath()%>/admin/assets/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap/js/popper.min.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/admin/assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
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
<script src='<%=request.getContextPath()%>/admin/assets/vendors/switcher/switcher.js'></script>
<script>
  $(document).ready(function() {

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
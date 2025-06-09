<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />
        <meta name="description" content="EduChamp : Education HTML Template" />
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">
        <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/images/favicon.png" />
        <title>EduChamp : Education HTML Template</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
        <style>
            input[type="text"], textarea, select {
                width: 100%;
                font-size: inherit;
                font-family: inherit;
                border: 1px solid #ccc;
                padding: 8px;
                margin: 0;
                color: inherit;
                line-height: inherit;
                vertical-align: baseline;
                resize: none;
            }
            textarea {
                min-height: 100px;
            }
            input[type="text"]:focus, textarea:focus, select:focus {
                outline: none;
                border-color: #007bff;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .tabs {
                display: flex;
                border-bottom: 2px solid #ccc;
                margin-bottom: 20px;
            }
            .tab {
                padding: 10px 20px;
                cursor: pointer;
                background: #f1f1f1;
                margin-right: 5px;
                border-radius: 5px 5px 0 0;
            }
            .tab.active {
                background: #007bff;
                color: white;
            }
            .tab-content {
                display: none;
            }
            .tab-content.active {
                display: block;
            }
            .overview-section {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }
            .overview-left {
                width: 48%;
            }
            .overview-right {
                width: 48%;
            }
            .overview-right img {
                width: 100%;
                height: auto;
            }
            .description-section {
                margin-bottom: 20px;
            }
            .save-btn {
                background: #007bff;
                color: white;
                padding: 8px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            th, td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: left;
            }
            th {
                background: #007bff;
                color: white;
            }
            .filter-section {
                margin-bottom: 20px;
            }
            .filter-section label {
                margin-right: 15px;
            }
            .apply-btn {
                background: #007bff;
                color: white;
                padding: 5px 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
        </style>
    </head>
    <body id="bg">
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
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
                            <div class="menu-logo">
                                <a href="index.jsp"><img src="assets/images/logo.png" alt=""></a>
                            </div>
                            <button class="navbar-toggler collapsed menuicon justify-content-end" type="button" data-toggle="collapse" data-target="#menuDropdown" aria-controls="menuDropdown" aria-expanded="false" aria-label="Toggle navigation">
                                <span></span>
                                <span></span>
                                <span></span>
                            </button>
                            <div class="secondary-menu">
                                <div class="secondary-inner">
                                    <ul>
                                        <li><a href="javascript:;" class="btn-link"><i class="fa fa-facebook"></i></a></li>
                                        <li><a href="javascript:;" class="btn-link"><i class="fa fa-google-plus"></i></a></li>
                                        <li><a href="javascript:;" class="btn-link"><i class="fa fa-linkedin"></i></a></li>
                                        <li class="search-btn"><button id="quik-search-btn" type="button" class="btn-link"><i class="fa fa-search"></i></button></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="nav-search-bar">
                                <form action="#">
                                    <input name="search" value="" type="text" class="form-control" placeholder="Type to search">
                                    <span><i class="ti-search"></i></span>
                                </form>
                                <span id="search-remove"><i class="ti-close"></i></span>
                            </div>
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
                                            <li><a href="coursecontroller">Subject List</a></li>
                                            <li><a href="change-password.jsp">Change Password</a></li>
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
                        </div>
                    </div>
            </header>
            <div class="page-content bg-white">
                <div class="page-banner ovbl-dark" style="background-image:url(assets/images/banner/banner2.jpg);">
                    <div class="container">
                        <div class="page-banner-entry">
                            <h1 class="text-white">Subject / Course Details</h1>
                        </div>
                    </div>
                </div>
                <div class="breadcrumb-row">
                    <div class="container">
                        <ul class="list-inline">
                            <li><a href="#">Home</a></li>
                            <li>Courses Details</li>
                        </ul>
                    </div>
                </div>
                <div class="content-block">
                    <div class="section-area section-sp1">
                        <div class="container">
                            <div class="tabs">
                                <div class="tab active" data-tab="overview">Overview</div>
                                <div class="tab" data-tab="dimension">Dimension</div>
                                <div class="tab" data-tab="price-package">Price Package</div>
                            </div>
                            <div id="overview" class="tab-content active">
                                <div class="overview-section">
                                    <div class="overview-left">
                                        <div class="form-group">
                                            <label>Subject Name</label>
                                            <input type="text" name="subjectName" placeholder="Subject Name">
                                        </div>
                                        <div class="form-group">
                                            <label>Category Name</label>
                                            <select name="category">
                                                <option value="Frontend">Frontend</option>
                                                <option value="Backend">Backend</option>
                                                <option value="Design">Design</option>
                                                <option value="Data Science">Data Science</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>
                                                <input type="checkbox" name="featuredSubject"> Featured Subject
                                            </label>
                                        </div>
                                        <div class="form-group">
                                            <label>Status</label>
                                            <select name="status">
                                                <option value="Active">Active</option>
                                                <option value="Inactive">Inactive</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="overview-right">
                                        <img src="assets/images/blog/default/thum1.jpg" alt="Course Thumbnail">
                                    </div>
                                </div>
                                <div class="description-section">
                                    <div class="form-group">
                                        <label>Description</label>
                                        <textarea name="description" rows="5" placeholder="Enter course description..."></textarea>
                                    </div>
                                    <button type="submit" class="save-btn">Save</button>
                                </div>
                            </div>
                            <div id="dimension" class="tab-content">
                                <div class="filter-section">
                                    <label><input type="checkbox" class="dimension-filter" value="id" checked> ID</label>
                                    <label><input type="checkbox" class="dimension-filter" value="type" checked> Type</label>
                                    <label><input type="checkbox" class="dimension-filter" value="dimension" checked> Dimension</label>
                                    <label><input type="checkbox" class="dimension-filter" value="action" checked> Action</label>
                                    <button class="apply-btn" onclick="applyDimensionFilters()">Apply</button>
                                </div>
                                <table id="dimension-table">
                                    <thead>
                                        <tr>
                                            <th class="col-id">ID</th>
                                            <th class="col-type">Type</th>
                                            <th class="col-dimension">Dimension</th>
                                            <th class="col-action">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="col-id">1</td>
                                            <td class="col-type">Lecture</td>
                                            <td class="col-dimension">120 minutes</td>
                                            <td class="col-action">Edit</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div id="price-package" class="tab-content">
                                <div class="filter-section">
                                    <label><input type="checkbox" class="price-filter" value="id" checked> ID</label>
                                    <label><input type="checkbox" class="price-filter" value="package" checked> Package</label>
                                    <label><input type="checkbox" class="price-filter" value="duration" checked> Duration</label>
                                    <label><input type="checkbox" class="price-filter" value="list-price" checked> List Price</label>
                                    <label><input type="checkbox" class="price-filter" value="sale-price" checked> Sale Price</label>
                                    <label><input type="checkbox" class="price-filter" value="action" checked> Action</label>
                                    <button class="apply-btn" onclick="applyPriceFilters()">Apply</button>
                                </div>
                                <table id="price-table">
                                    <thead>
                                        <tr>
                                            <th class="col-id">ID</th>
                                            <th class="col-package">Package</th>
                                            <th class="col-duration">Duration</th>
                                            <th class="col-list-price">List Price</th>
                                            <th class="col-sale-price">Sale Price</th>
                                            <th class="col-action">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="col-id">1</td>
                                            <td class="col-package">Basic</td>
                                            <td class="col-duration">60 hours</td>
                                            <td class="col-list-price">$190</td>
                                            <td class="col-sale-price">$120</td>
                                            <td class="col-action">Edit</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
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
                                    <a href="#" class="btn">Join Now</a>
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
                                        <div class="ajax-message"></div>
                                        <div class="input-group">
                                            <input name="email" required="required" class="form-control" placeholder="Your Email Address" type="email">
                                            <span class="input-group-btn">
                                                <button name="submit" value="Submit" type="submit" class="btn"><i class="fa fa-arrow-right"></i></button>
                                            </span> 
                                        </div>
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
                </div>
                <div class="footer-bottom">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 text-center"><a target="_blank" href="https://www.templateshub.net">Templates Hub</a></div>
                        </div>
                    </div>
                </div>
            </footer>
            <button class="back-to-top fa fa-chevron-up"></button>
        </div>
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
        <script src="assets/js/jquery.scroller.js"></script>
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>
        <script src="assets/vendors/switcher/switcher.js"></script>
        <script>
            // Tab switching functionality
            document.querySelectorAll('.tab').forEach(tab => {
                tab.addEventListener('click', () => {
                    document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
                    document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
                    tab.classList.add('active');
                    document.getElementById(tab.getAttribute('data-tab')).classList.add('active');
                });
            });

            // Dimension table filter
            function applyDimensionFilters() {
                const filters = Array.from(document.querySelectorAll('.dimension-filter:checked')).map(filter => filter.value);
                const columns = ['id', 'type', 'dimension', 'action'];
                columns.forEach(col => {
                    const elements = document.querySelectorAll(`.col-${col}`);
                    elements.forEach(el => {
                        el.style.display = filters.includes(col) ? '' : 'none';
                    });
                });
            }

            // Price Package table filter
            function applyPriceFilters() {
                const filters = Array.from(document.querySelectorAll('.price-filter:checked')).map(filter => filter.value);
                const columns = ['id', 'package', 'duration', 'list-price', 'sale-price', 'action'];
                columns.forEach(col => {
                    const elements = document.querySelectorAll(`.col-${col}`);
                    elements.forEach(el => {
                        el.style.display = filters.includes(col) ? '' : 'none';
                    });
                });
            }
        </script>
    </body>
</html>
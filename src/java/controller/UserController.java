package controller;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // Import HttpSession để quản lý session
import java.util.List;
import model.Role;
import model.User;

@WebServlet(name = "UserController", urlPatterns = {"/userController", "/usercontroller"})
public class UserController extends HttpServlet {

    // Khởi tạo DAO một lần khi servlet được tạo
    UserDAO userDAO = new UserDAO(); 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8"); // Đảm bảo request được đọc với encoding UTF-8

        String action = request.getParameter("action");

        // Xử lý action "changePassword" của Hiếu
        if ("changePassword".equals(action)) {
            String mess = "";
            String email = request.getParameter("email");
            User user = userDAO.getUserByEmail(email); // Sử dụng userDAO đã khởi tạo
            String password = request.getParameter("password");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (user == null) {
                mess = "Email not exist!";
                request.setAttribute("mess", mess);
            } else {
                if (!password.equals(user.getPassword())) {
                    mess = "Password is fail!";
                    request.setAttribute("mess", mess);
                } else if (newPassword.equals(user.getPassword()) || newPassword.equals(password)) {
                    mess = "New password is same old password!";
                    request.setAttribute("mess", mess);
                } else if (!newPassword.equals(confirmPassword)) {
                    mess = "New password is different Confirm password!";
                    request.setAttribute("mess", mess);
                } else {
                    userDAO.UpdatePassword(newPassword, email);
                    mess = "Change Password Success";
                    request.setAttribute("mess", mess);
                }
            }
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return; // Quan trọng: dừng xử lý doGet nếu đã xử lý changePassword
        }
        
        // Xử lý logic hiển thị danh sách người dùng 
        // Lấy các tham số filter từ request
        String gender = request.getParameter("gender");
        String roleIDStr = request.getParameter("roleID");
        String status = request.getParameter("status");
        String search = request.getParameter("search");

        // Lấy các tham số sắp xếp từ request
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder"); 

        // Lấy tham số trang hiện tại từ request
        String pageStr = request.getParameter("page");
        int pageIndex = 1; // Mặc định là trang đầu tiên
        int pageSize = 10; // Số lượng user trên mỗi trang, có thể cấu hình

        // Parse số trang (pageIndex) một cách an toàn
        if (pageStr != null && !pageStr.trim().isEmpty() && !pageStr.equalsIgnoreCase("null")) {
            try {
                pageIndex = Integer.parseInt(pageStr);
                if (pageIndex < 1) {
                    pageIndex = 1; 
                }
            } catch (NumberFormatException e) {
                pageIndex = 1; 
            }
        }

        // Parse roleID một cách an toàn
        Integer roleID = null; 
        if (roleIDStr != null && !roleIDStr.trim().isEmpty() && !roleIDStr.equalsIgnoreCase("null") && !roleIDStr.equals("")) { 
            try {
                roleID = Integer.parseInt(roleIDStr);
            } catch (NumberFormatException e) {
                roleID = null; 
            }
        }

        // CUNG CẤP GIÁ TRỊ MẶC ĐỊNH CHO SORTBY VÀ SORTORDER NẾU CHÚNG LÀ NULL HOẶC RỖNG TỪ REQUEST
        if (sortBy == null || sortBy.trim().isEmpty()) {
            sortBy = "userID"; 
        }
        if (sortOrder == null || sortOrder.trim().isEmpty()) {
            sortOrder = "asc"; 
        }

        // Lấy tổng số người dùng dựa trên các bộ lọc hiện tại để tính toán phân trang
        int totalUsers = userDAO.getTotalUsers(search, gender, roleID, status);
        int totalPage = 0; 
        if (totalUsers > 0) {
            totalPage = (int) Math.ceil((double) totalUsers / pageSize);
        }

        // ĐIỀU CHỈNH pageIndex NẾU NÓ VƯỢT QUÁ totalPage (khi totalPage > 0)
        if (pageIndex > totalPage && totalPage > 0) {
            pageIndex = totalPage; 
        } else if (totalPage == 0 && pageIndex > 1) {
            pageIndex = 1; 
        }

        // Lấy danh sách người dùng cho trang hiện tại (pageIndex) với các filter và sort
        List<User> userList = userDAO.getListUser(search, gender, roleID, status, sortBy, sortOrder, pageIndex, pageSize);
        
        // Lấy danh sách tất cả các Role để hiển thị trong bộ lọc và form thêm mới trên JSP
        List<Role> rolesList = userDAO.getAllRoles();

        // Đặt các thuộc tính vào request để JSP có thể truy cập và hiển thị
        request.setAttribute("userList", userList);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("currentPage", pageIndex); 

        // Gửi lại các giá trị filter hiện tại để JSP có thể hiển thị chúng trên form lọc
        request.setAttribute("genderFilter", gender);
        request.setAttribute("roleIDFilter", roleIDStr); 
        request.setAttribute("statusFilter", status);
        request.setAttribute("searchValue", search);    
        
        // Gửi lại các giá trị sort hiện tại để JSP biết cột nào đang được sort và theo chiều nào
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);
        
        request.setAttribute("rolesList", rolesList); // Danh sách roles cho dropdown

        // XỬ LÝ THÔNG BÁO TỪ SESSION (ví dụ, sau khi thêm user thành công từ doPost và redirect về đây)
        HttpSession session = request.getSession(false); 
        if (session != null) {
            String successMessage = (String) session.getAttribute("successMessage");
            if (successMessage != null) {
                request.setAttribute("pageSuccessMessage", successMessage); 
                session.removeAttribute("successMessage"); 
            }
            String errorMessage = (String) session.getAttribute("errorMessage");
            if (errorMessage != null) {
                request.setAttribute("pageErrorMessage", errorMessage);
                session.removeAttribute("errorMessage");
            }
            // Xử lý cờ hiển thị form thêm user (nếu có lỗi từ lần submit trước)
            Boolean showAddForm = (Boolean) session.getAttribute("showAddUserFormOnError");
            if (showAddForm != null && showAddForm) {
                request.setAttribute("showAddUserFormOnErrorForJSP", true); 
                session.removeAttribute("showAddUserFormOnError"); 
            }
        }

        // Chuyển tiếp yêu cầu và phản hồi tới userList.jsp để hiển thị
        request.getRequestDispatcher("/userList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");  
        HttpSession session = request.getSession();  

        String action = request.getParameter("formAction");  

        if ("addUser".equals(action)) {
            String fullName = request.getParameter("newUser_fullName");
            String email = request.getParameter("newUser_email");
            String password = request.getParameter("newUser_password");  
            String gender = request.getParameter("newUser_gender");
            String mobile = request.getParameter("newUser_mobile");
            String address = request.getParameter("newUser_address");
            String roleIDStr = request.getParameter("newUser_roleID");
            String avatar = request.getParameter("newUser_avatar");  
            String status = request.getParameter("newUser_status");

            session.setAttribute("input_newUser_fullName", fullName);
            session.setAttribute("input_newUser_email", email);
            session.setAttribute("input_newUser_gender", gender);
            session.setAttribute("input_newUser_mobile", mobile);
            session.setAttribute("input_newUser_address", address);
            session.setAttribute("input_newUser_roleID", roleIDStr);
            session.setAttribute("input_newUser_avatar", avatar); 
            session.setAttribute("input_newUser_status", status);

            boolean proceedToAdd = true; 

            // 1. VALIDATION DỮ LIỆU ĐẦU VÀO (các trường bắt buộc)
            if (fullName == null || fullName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||  
                roleIDStr == null || roleIDStr.trim().isEmpty()) {
                
                session.setAttribute("errorMessage", "Required fields are missing (Full Name, Email, Password, Role).");
                session.setAttribute("showAddUserFormOnError", true);  
                proceedToAdd = false;
            }

            // 2. KIỂM TRA EMAIL ĐÃ TỒN TẠI CHƯA (nếu các trường bắt buộc đã hợp lệ)
            if (proceedToAdd && userDAO.emailExists(email)) { 
                session.setAttribute("errorMessage", "Email '" + email + "' already exists. Please use a different email.");
                session.setAttribute("showAddUserFormOnError", true);
                proceedToAdd = false;
            }

            // 3. KIỂM TRA SỐ ĐIỆN THOẠI ĐÃ TỒN TẠI CHƯA (nếu email hợp lệ và mobile được cung cấp)
            if (proceedToAdd && mobile != null && !mobile.trim().isEmpty() && userDAO.mobileExists(mobile)) { 
                session.setAttribute("errorMessage", "Mobile number '" + mobile + "' already exists. Please use a different mobile number.");
                session.setAttribute("showAddUserFormOnError", true);
                proceedToAdd = false;
            }
            
            // 4. TIẾN HÀNH THÊM USER NẾU TẤT CẢ VALIDATION THÀNH CÔNG
            if (proceedToAdd) {
                try {
                    int roleID = Integer.parseInt(roleIDStr);  
                    Role role = new Role();  
                    role.setRoleID(roleID);
                    
                    String finalAvatar = (avatar != null && !avatar.trim().isEmpty()) ? avatar : null; 

                    User newUser = new User(0, fullName, email, password, gender, mobile, address, role, finalAvatar, status);
                    
                    boolean success = userDAO.addUser(newUser); 

                    if (success) {  
                        session.setAttribute("successMessage", "User '" + fullName + "' added successfully!");
                        session.removeAttribute("input_newUser_fullName");
                        session.removeAttribute("input_newUser_email");
                        session.removeAttribute("input_newUser_gender");
                        session.removeAttribute("input_newUser_mobile");
                        session.removeAttribute("input_newUser_address");
                        session.removeAttribute("input_newUser_roleID");
                        session.removeAttribute("input_newUser_avatar");
                        session.removeAttribute("input_newUser_status");
                        session.removeAttribute("showAddUserFormOnError"); 
                    } else {  
                        session.setAttribute("errorMessage", "Failed to add user '" + fullName + "'. Please check data or database error.");
                        session.setAttribute("showAddUserFormOnError", true);  
                    }
                } catch (NumberFormatException e) {  
                    session.setAttribute("errorMessage", "Invalid Role ID format for new user: " + roleIDStr);
                    session.setAttribute("showAddUserFormOnError", true);
                } catch (Exception e) {  
                    session.setAttribute("errorMessage", "Error adding user: " + e.getMessage());
                    session.setAttribute("showAddUserFormOnError", true);
                    e.printStackTrace();  
                }
            }
            
        } else {  
            // Nếu không phải action "addUser", có thể có các action POST khác ở đây trong tương lai
            session.setAttribute("errorMessage", "Unknown POST action: " + action);
        }

        // Chuyển hướng về trang danh sách user, giữ lại các tham số truy vấn
        String queryString = request.getParameter("currentQueryString");  
        if (queryString == null) {
            queryString = "";  
        }
        // Xóa tham số formAction để tránh lặp lại hành động khi reload trang
        queryString = queryString.replaceAll("&?formAction=addUser", "");
        queryString = queryString.replaceAll("formAction=addUser&?", "");

        if (!queryString.isEmpty() && !queryString.startsWith("?")) {
            queryString = "?" + queryString;
        }
        
        response.sendRedirect(request.getContextPath() + "/userController" + queryString);
    }

    @Override
    public String getServletInfo() {
        return "Combined UserController for managing users: listing, adding, filtering, sorting, and changing password.";
    }
}
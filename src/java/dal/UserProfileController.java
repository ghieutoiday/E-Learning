package dal;

import dal.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "UserProfileController", urlPatterns = {"/userProfileController"})
public class UserProfileController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        int currentUserID = 1; // Tạm thời cố định userID = 1

        User userProfile = userDAO.getUserByID(currentUserID);

        if (userProfile != null) {
            request.setAttribute("userProfileData", userProfile);
        } else {
            request.setAttribute("profileErrorMessage", "User profile (ID: " + currentUserID + ") not found.");
        }
        
        request.getRequestDispatcher("/userProfile.jsp").forward(request, response); 
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        int currentUserID = 1; // Tạm thời cố định userID = 1
        
        String fullName = request.getParameter("fullName");
        String gender = request.getParameter("gender");
        String mobile = request.getParameter("mobile"); // Lấy mobile mới
        String address = request.getParameter("address");
        String avatarUrl = request.getParameter("avatarUrl");
        
        User userBeforeUpdate = userDAO.getUserByID(currentUserID); 
        if (userBeforeUpdate == null) {
            request.setAttribute("profileErrorMessage", "User not found, cannot update profile.");
            request.getRequestDispatcher("/userProfile.jsp").forward(request, response);
            return;
        }
        // Luôn đặt userProfileData để form có thể điền lại giá trị ban đầu hoặc giá trị đã submit
        request.setAttribute("userProfileData", userBeforeUpdate);


        // ----- KIỂM TRA VALIDATION VÀ TRÙNG LẶP -----
        String errorMessage = null;

        if (fullName == null || fullName.trim().isEmpty()) {
            errorMessage = "Full name cannot be empty.";
        }
        
        // Kiểm tra trùng Mobile NẾU mobile được nhập và nó KHÁC mobile hiện tại của user
        if (errorMessage == null && mobile != null && !mobile.trim().isEmpty() && 
            (userBeforeUpdate.getMobile() == null || !mobile.equals(userBeforeUpdate.getMobile())) ) {
            if (userDAO.mobileExistsForOtherUser(mobile, currentUserID)) { // Giả sử có hàm này trong DAO
                errorMessage = "Mobile number '" + mobile + "' is already in use by another account.";
            }
        }
        // Bạn có thể thêm các kiểm tra trùng lặp khác ở đây cho các trường UNIQUE (nếu có)

        // Nếu có lỗi validation hoặc trùng lặp
        if (errorMessage != null) {
            request.setAttribute("profileErrorMessage", errorMessage);
            // Tạo đối tượng User với dữ liệu đã submit để điền lại form
            User submittedData = new User();
            submittedData.setUserID(currentUserID);
            submittedData.setFullName(fullName);
            submittedData.setGender(gender);
            submittedData.setMobile(mobile);
            submittedData.setAddress(address);
            submittedData.setAvatar(avatarUrl);
            submittedData.setEmail(userBeforeUpdate.getEmail()); // Giữ lại email không đổi
            // Các trường khác như Role, Status có thể lấy từ userBeforeUpdate nếu cần
            if(userBeforeUpdate.getRole() != null) submittedData.setRole(userBeforeUpdate.getRole());
            submittedData.setStatus(userBeforeUpdate.getStatus());


            request.setAttribute("userProfileData", submittedData); // Gửi dữ liệu người dùng đã nhập (kể cả lỗi)
            request.setAttribute("validationErrorOccurred", true); // Cờ báo có lỗi để JSP biết bật edit mode
            request.getRequestDispatcher("/userProfile.jsp").forward(request, response);
            return;
        }

        // Nếu không có lỗi, tiến hành cập nhật
        boolean success = userDAO.updateUserProfile(currentUserID, fullName, gender, mobile, address, avatarUrl);

        if (success) {
            request.setAttribute("profileSuccessMessage", "Profile updated successfully!");
            request.setAttribute("userProfileData", userDAO.getUserByID(currentUserID)); // Lấy lại thông tin mới nhất
        } else {
            request.setAttribute("profileErrorMessage", "Failed to update profile. Please try again (Database error or no changes made).");
            // Điền lại form với dữ liệu người dùng vừa submit
            User submittedDataOnError = new User();
            submittedDataOnError.setUserID(currentUserID);
            submittedDataOnError.setFullName(fullName);
            submittedDataOnError.setGender(gender);
            submittedDataOnError.setMobile(mobile);
            submittedDataOnError.setAddress(address);
            submittedDataOnError.setAvatar(avatarUrl);
            submittedDataOnError.setEmail(userBeforeUpdate.getEmail());
            if(userBeforeUpdate.getRole() != null) submittedDataOnError.setRole(userBeforeUpdate.getRole());
            submittedDataOnError.setStatus(userBeforeUpdate.getStatus());
            request.setAttribute("userProfileData", submittedDataOnError);
            // Không đặt validationErrorOccurred để quay về view mode với thông báo lỗi
        }
        
        request.getRequestDispatcher("/userProfile.jsp").forward(request, response);
    }
}
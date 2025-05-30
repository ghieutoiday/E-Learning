package dal;

import dal.UserDAO; // Import UserDAO
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.User; // Import User model
import model.Role; // Import Role model (để có thể lấy role.roleName)

/**
 * Servlet để xem chi tiết thông tin người dùng
 */
@WebServlet(name = "ViewUserController", urlPatterns = {"/viewUser"})
public class ViewUserController extends HttpServlet {

    private UserDAO userDAO; // Khai báo UserDAO

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO(); // Khởi tạo UserDAO khi Servlet được tạo
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy userID từ tham số request (ví dụ: viewUser?id=123)
            String userIDParam = request.getParameter("id");

            // Kiểm tra xem ID có hợp lệ không
            if (userIDParam == null || userIDParam.trim().isEmpty()) {
                // Nếu không có ID hoặc ID rỗng, chuyển hướng về trang danh sách người dùng
                // SỬA LẠI: Sử dụng request.getContextPath() để đảm bảo đường dẫn đúng
                response.sendRedirect(request.getContextPath() + "/userDAO"); // Hoặc một trang lỗi khác
                return;
            }

            int userID = Integer.parseInt(userIDParam); // Chuyển đổi ID sang số nguyên

            // Gọi UserDAO để lấy thông tin người dùng từ database
            User user = userDAO.getUserByID(userID);

            // THÊM MỚI: Lấy danh sách tất cả các vai trò từ UserDAO
            List<Role> allRoles = userDAO.getAllRoles();

            // Kiểm tra xem người dùng có tồn tại không
            if (user != null) {
                // Đặt đối tượng User vào request để userDetail.jsp có thể truy cập
                request.setAttribute("user", user);
                // THÊM MỚI: Đặt danh sách allRoles vào request để userDetail.jsp có thể truy cập
                request.setAttribute("roles", allRoles);

                // Chuyển tiếp (forward) yêu cầu đến trang JSP để hiển thị chi tiết
                // SỬA LẠI: Thêm dấu / ở đầu cho đường dẫn JSP để đảm bảo tính tương đối từ gốc context
                request.getRequestDispatcher("/userDetails.jsp").forward(request, response);
            } else {
                // Nếu không tìm thấy người dùng, đặt thông báo lỗi và chuyển hướng về trang danh sách
                request.setAttribute("errorMessage", "User not found with ID: " + userID);
                request.getRequestDispatcher(request.getContextPath() + "/userDAO").forward(request, response);
            }
        } catch (NumberFormatException e) {
            // Xử lý lỗi nếu ID không phải là số hợp lệ
            request.setAttribute("errorMessage", "Invalid User ID format.");
            request.getRequestDispatcher(request.getContextPath() + "/userDAO").forward(request, response);
        } catch (Exception e) {
            // Xử lý các lỗi khác có thể xảy ra trong quá trình xử lý
            request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher(request.getContextPath() + "/userDAO").forward(request, response);
            System.err.println("Error in ViewUserController doGet: " + e.getMessage()); // Đổi tên class cho đúng
            e.printStackTrace(); // In stack trace để debug
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String userIDParam = request.getParameter("userID");
        String roleIDParam = request.getParameter("roleID");
        String statusParam = request.getParameter("status");

        // Luôn lấy lại danh sách roles để nếu có lỗi thì JSP vẫn hiển thị dropdown đúng
        List<Role> allRoles = userDAO.getAllRoles();
        request.setAttribute("roles", allRoles);

        User currentUser = null; // Dùng để lấy giá trị role/status hiện tại của user
        int userID = -1;

        // Kiểm tra và lấy thông tin user hiện tại
        if (userIDParam != null && !userIDParam.trim().isEmpty()) {
            try {
                userID = Integer.parseInt(userIDParam);
                currentUser = userDAO.getUserByID(userID); // Lấy user hiện tại để so sánh
                if (currentUser == null) {
                    request.setAttribute("errorMessage", "User not found with ID: " + userID + " for update.");
                    // Chuyển hướng đến trang danh sách người dùng hoặc trang lỗi phù hợp
                    request.getRequestDispatcher(request.getContextPath() + "/userDAO").forward(request, response);
                    return;
                }
                // Đặt lại user vào request để JSP có thể hiển thị lại thông tin nếu có lỗi
                request.setAttribute("user", currentUser);
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid User ID format: " + userIDParam);
                request.getRequestDispatcher(request.getContextPath() + "/userDAO").forward(request, response);
                return;
            }
        } else {
            request.setAttribute("errorMessage", "User ID is required for update.");
            request.getRequestDispatcher(request.getContextPath() + "/userDAO").forward(request, response);
            return;
        }

        if ("updateRoleStatus".equals(action)) {
            try {
                Integer roleIdToUpdate = null;
                if (roleIDParam != null && !roleIDParam.trim().isEmpty()) {
                    int selectedRoleId = Integer.parseInt(roleIDParam);
                    // Chỉ set để update nếu role được chọn khác với role hiện tại của user
                    if (currentUser.getRole() == null || selectedRoleId != currentUser.getRole().getRoleID()) {
                        roleIdToUpdate = selectedRoleId;
                    }
                }

                String statusToUpdate = null;
                if (statusParam != null && !statusParam.trim().isEmpty()) {
                    // Chỉ set để update nếu status được chọn khác với status hiện tại
                    if (!statusParam.equals(currentUser.getStatus())) {
                        statusToUpdate = statusParam;
                    }
                }

                // Chỉ gọi update nếu có ít nhất một trường cần thay đổi
                if (roleIdToUpdate != null || statusToUpdate != null) {
                    boolean success = userDAO.updateUserRoleAndStatusSelective(userID, roleIdToUpdate, statusToUpdate);
                    if (success) {
                        request.setAttribute("successMessage", "Updated successfully.");
                        // Tải lại thông tin user sau khi cập nhật
                        currentUser = userDAO.getUserByID(userID);
                        request.setAttribute("user", currentUser);
                    } else {
                        request.setAttribute("errorMessage", "Failed to update.");
                    }
                } else {
                    // Không có gì thay đổi
                    request.setAttribute("successMessage", "No changes were made to role or status.");
                }

                request.getRequestDispatcher("/userDetails.jsp").forward(request, response);

            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid Role ID format: " + roleIDParam);
                request.getRequestDispatcher("/userDetails.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("errorMessage", "An unexpected error occurred during update: " + e.getMessage());
                request.getRequestDispatcher("/userDetails.jsp").forward(request, response);
                System.err.println("Error in ViewUserController doPost (update): " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            // Nếu action không phải là "updateRoleStatus", có thể là lỗi hoặc action khác
            // Chuyển về doGet để hiển thị lại trang chi tiết user (hoặc xử lý lỗi)
            request.setAttribute("errorMessage", "Invalid action for update.");
            doGet(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for viewing user details";
    }
}

package dal;

import model.Role;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.User;

public class UserDAO extends DBContext {

    public UserDAO() {
        super();
    }

    public Role getRoleByID(int id) {
        Role role = null;
        try {
            String sql = "select * from Role where roleID = " + id;
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String roleName = rs.getString(2);
                role = new Role(id, roleName);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return role;
    }

    public User getUserByID(int id) {
        User user = null;
        try {
            String sql = "select * from [User] where userID = " + id;
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String fullName = rs.getString(2);
                String email = rs.getString(3);
                String password = rs.getString(4);
                String gender = rs.getString(5);
                String mobile = rs.getString(6);
                String address = rs.getString(7);
                Role role = getRoleByID(rs.getInt(8));
                String avatar = rs.getString(9);
                String status = rs.getString(10);
                user = new User(id, fullName, email, password, gender, mobile,address, role, avatar, status);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return user;
    }

    public List<Role> getAllRoles() {
        List<Role> roles = new ArrayList<>();
        try {
            String sql = "SELECT roleID, roleName FROM Role";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                roles.add(new Role(rs.getInt("roleID"), rs.getString("roleName")));
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllRoles: " + e.getMessage());
        }
        return roles;
    }

    public List<User> getListUser(String keyword, String gender, Integer roleId, String status,
                                  String sortBy, String sortOrder,
                                  int page, int pageSize) {
        List<User> list = new ArrayList<>();

        try {
            int offset = (page - 1) * pageSize;

            String sql = "SELECT * FROM [User] WHERE 1=1";

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql += " AND (fullName LIKE ? OR email LIKE ? OR mobile LIKE ?)";
            }
            if (gender != null && !gender.equalsIgnoreCase("all")) {
                sql += " AND gender = ?";
            }
            if (roleId != null) {
                sql += " AND roleID = ?";
            }
            if (status != null && !status.equalsIgnoreCase("all")) {
                sql += " AND status = ?";
            }

            // THÊM MỆNH ĐỀ ORDER BY DỰA TRÊN sortBy VÀ sortOrder
            if (sortBy != null && !sortBy.trim().isEmpty()) {
                String orderColumn = "";
                switch (sortBy) {
                    case "userID":
                        orderColumn = "userID";
                        break;
                    case "fullName":
                        orderColumn = "fullName";
                        break;
                    case "gender":
                        orderColumn = "gender";
                        break;
                    case "email": // Thêm cột email
                        orderColumn = "email";
                        break;
                    case "mobile": // Thêm cột mobile
                        orderColumn = "mobile";
                        break;
                    case "roleID":
                        orderColumn = "roleID";
                        break;
                    case "status":
                        orderColumn = "status";
                        break;
                    default:
                        orderColumn = "userID"; // Mặc định sắp xếp theo userID nếu không hợp lệ
                }
                sql += " ORDER BY " + orderColumn;
                if (sortOrder != null && sortOrder.equalsIgnoreCase("desc")) {
                    sql += " DESC";
                } else {
                    sql += " ASC"; // Mặc định là ASC
                }
            } else {
                sql += " ORDER BY userID ASC"; // Sắp xếp mặc định nếu không có sortBy
            }

            sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

            PreparedStatement ps = connection.prepareStatement(sql);

            int index = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                String kw = "%" + keyword.trim() + "%";
                ps.setString(index++, kw);
                ps.setString(index++, kw);
                ps.setString(index++, kw);
            }
            if (gender != null && !gender.equalsIgnoreCase("all")) {
                ps.setString(index++, gender);
            }
            if (roleId != null) {
                ps.setInt(index++, roleId);
            }
            if (status != null && !status.equalsIgnoreCase("all")) {
                ps.setString(index++, status);
            }

            ps.setInt(index++, offset);
            ps.setInt(index++, pageSize);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("userID");
                String fullName = rs.getString("fullName");
                String emailVal = rs.getString("email");
                String password = rs.getString("password");
                String genderVal = rs.getString("gender");
                String mobile = rs.getString("mobile");
                String address = rs.getString("address");
                Role role = getRoleByID(rs.getInt("roleID"));
                String avatar = rs.getString("avatar");
                String statusVal = rs.getString("status");

                User user = new User(id, fullName, emailVal, password, genderVal, mobile,address, role, avatar, statusVal);
                list.add(user);
            }
        } catch (SQLException e) {
            System.out.println("Error in getListUser: " + e.getMessage());
        }

        return list;
    }

    public int getTotalUsers(String keyword, String gender, Integer roleId, String status) {
        int total = 0;
        try {
            String sql = "SELECT COUNT(*) FROM [User] WHERE 1=1";

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql += " AND (fullName LIKE ? OR email LIKE ? OR mobile LIKE ?)";
            }
            if (gender != null && !gender.equalsIgnoreCase("all")) {
                sql += " AND gender = ?";
            }
            if (roleId != null) {
                sql += " AND roleID = ?";
            }
            if (status != null && !status.equalsIgnoreCase("all")) {
                sql += " AND status = ?";
            }

            PreparedStatement ps = connection.prepareStatement(sql);
            int index = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                String kw = "%" + keyword.trim() + "%";
                ps.setString(index++, kw);
                ps.setString(index++, kw);
                ps.setString(index++, kw);
            }
            if (gender != null && !gender.equalsIgnoreCase("all")) {
                ps.setString(index++, gender);
            }
            if (roleId != null) {
                ps.setInt(index++, roleId);
            }
            if (status != null && !status.equalsIgnoreCase("all")) {
                ps.setString(index++, status);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return total;
    }

    
    //Phương thức cập nhật Role và/hoặc Status một cách có chọn lọc

    public boolean updateUserRoleAndStatusSelective(int userId, Integer newRoleId, String newStatus) {
        StringBuilder sqlSetClause = new StringBuilder();

        if (newRoleId != null) {
            sqlSetClause.append("roleID = ?");
        }
        if (newStatus != null && !newStatus.trim().isEmpty()) {
            if (sqlSetClause.length() > 0) {
                sqlSetClause.append(", ");
            }
            sqlSetClause.append("status = ?");
        }

        if (sqlSetClause.length() == 0) {
            // Không có trường nào để cập nhật
            return true; // Coi như thành công vì không có yêu cầu thay đổi
        }

        String sql = "UPDATE [User] SET " + sqlSetClause.toString() + " WHERE userID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            if (newRoleId != null) {
                ps.setInt(paramIndex++, newRoleId);
            }
            if (newStatus != null && !newStatus.trim().isEmpty()) {
                ps.setString(paramIndex++, newStatus);
            }
            ps.setInt(paramIndex++, userId);

            int rowsAffected = ps.executeUpdate();
            // return rowsAffected > 0; // Nếu muốn chỉ true khi có dòng thực sự thay đổi
            return true; // Trả về true nếu không có lỗi SQL (kể cả khi không có dòng nào được cập nhật do giá trị giống hệt)
        } catch (SQLException e) {
            System.out.println("Lỗi trong updateUserRoleAndStatusSelective: " + e.getMessage());
            return false;
        }
    }
    // THÊM MỚI: Phương thức thêm người dùng mới
    public boolean addUser(User user) {
        // Mật khẩu nên được hash trước khi lưu vào DB. Ví dụ này bỏ qua bước hash để đơn giản.
        String sql = "INSERT INTO [User] (fullName, email, password, gender, mobile, address, roleID, avatar, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword()); // CẢNH BÁO: Nên hash mật khẩu!
            ps.setString(4, user.getGender());
            ps.setString(5, user.getMobile());
            ps.setString(6, user.getAddress());
            if (user.getRole() != null) {
                ps.setInt(7, user.getRole().getRoleID());
            } else {
                ps.setNull(7, java.sql.Types.INTEGER); // Hoặc gán một roleID mặc định nếu cần
            }
            ps.setString(8, user.getAvatar());
            ps.setString(9, user.getStatus());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi trong addUser: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    //Update Profile
    public boolean updateUserProfile(int userId, String fullName, String gender, String mobile, String address, String avatarUrl) {
    String sql = "UPDATE [User] SET fullName = ?, gender = ?, mobile = ?, address = ?, avatar = ? WHERE userID = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, fullName);
        ps.setString(2, gender);
        ps.setString(3, mobile);
        ps.setString(4, address); // Thêm address
        ps.setString(5, avatarUrl);
        ps.setInt(6, userId);
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        System.out.println("Lỗi trong updateUserProfile: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
    
    
}
    
    // Phương thức kiểm tra email đã tồn tại chưa
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM [User] WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Lỗi trong emailExists: " + e.getMessage());
            e.printStackTrace(); // Quan trọng: In lỗi ra để debug
        }
        return false; // Mặc định là false nếu có lỗi hoặc không tìm thấy
    }

    // Phương thức kiểm tra số điện thoại đã tồn tại chưa (chỉ kiểm tra nếu mobile không rỗng)
    public boolean mobileExists(String mobile) {
        if (mobile == null || mobile.trim().isEmpty()) {
            return false; // Không kiểm tra nếu mobile rỗng
        }
        String sql = "SELECT COUNT(*) FROM [User] WHERE mobile = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, mobile);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Lỗi trong mobileExists: " + e.getMessage());
            e.printStackTrace(); // Quan trọng: In lỗi ra để debug
        }
        return false; // Mặc định là false nếu có lỗi hoặc không tìm thấy
    }
    
    // THÊM MỚI: Kiểm tra số điện thoại đã tồn tại cho một User khác (khi CẬP NHẬT, nếu mobile là unique)
    public boolean mobileExistsForOtherUser(String mobile, int currentUserId) {
        if (mobile == null || mobile.trim().isEmpty()) {
            return false; // Không kiểm tra nếu mobile rỗng hoặc null
        }
        String sql = "SELECT COUNT(*) FROM [User] WHERE mobile = ? AND userID != ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, mobile);
            ps.setInt(2, currentUserId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi trong mobileExistsForOtherUser: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }


    
    public static void main(String[] args) {
        UserDAO dao = new UserDAO();
    }
}
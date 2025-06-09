<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>My Profile</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            /* CSS giữ nguyên như phiên bản bạn cung cấp và đã được chỉnh sửa phông chữ/căn lề */
            body {
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
                margin: 0;
                background-color: #f4f4f8;
                display: flex;
                justify-content: center;
                align-items: flex-start;
                min-height: 100vh;
                padding: 30px 15px;
                box-sizing: border-box;
                line-height: 1.6;
                color: #333;
            }
            .avatar-wrapper { /* Hoặc class của div bọc avatar của bạn */
                display: flex;
                justify-content: center; /* Căn giữa theo chiều ngang */
                align-items: center;    /* Căn giữa theo chiều dọc */
                width: 150px;           /* Đặt kích thước cố định cho vùng chứa */
                height: 150px;          /* (bằng kích thước avatar mong muốn) */
                border-radius: 50%;     /* Bo tròn nếu muốn vùng chứa cũng tròn */
                overflow: hidden;         /* Ẩn phần thừa của ảnh nếu ảnh to hơn */
                margin: 0 auto 10px auto; /* Căn giữa chính div này và tạo khoảng cách dưới */
                /* Thêm các style khác như border, background nếu cần */
            }
            .profile-avatar-img { /* Style cho chính thẻ img */
                width: 100%;
                height: 100%;
                object-fit: cover; /* Đảm bảo ảnh lấp đầy mà không bị méo, có thể cắt bớt */
                border-radius: 50%; /* Bo tròn ảnh */
            }
            .profile-container {
                background-color: #ffffff;
                padding: 30px 40px;
                border-radius: 10px;
                box-shadow: 0 8px 25px rgba(0,0,0,0.1);
                width: 100%;
                max-width: 700px;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            .profile-header {
                text-align: center;
                margin-bottom: 30px;
            }
            .profile-header h1 {
                color: #2c3e50;
                margin-bottom: 10px;
                font-size: 2.2em;
                font-weight: 600;
            }
            .profile-avatar-section {
                margin-bottom: 25px;
                text-align: center;
            }
            .profile-avatar {
                margin-left: auto;

margin-right: auto;
                width: 160px;
                height: 160px;
                border-radius: 50%;
                object-fit: cover;
                border: 4px solid #ffffff;
                box-shadow: 0 4px 15px rgba(0,0,0,0.15);
                margin-bottom: 15px;
            }
            .profile-avatar-default {
                font-size: 10em;
                color: #ced4da;
                width: 160px;
                height: 160px;
                display: flex;
                align-items: center;
                justify-content: center;
                border: 4px solid #ffffff;
                border-radius: 50%;
                background-color: #e9ecef;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                margin-bottom: 15px;
            }
            .profile-fullname-display {
                font-size: 1.5em;
                font-weight: 500;
                color: #34495e;
            }

            .profile-details {
                width: 100%;
                margin-top: 20px;
                border-top: 1px solid #e0e0e0;
                padding-top: 25px;
            }
            .profile-details .info-row {
                margin: 15px 0;
                font-size: 1rem;
                color: #555;
                display: flex;
                flex-wrap: wrap;
                line-height: 1.7;
                align-items: center;
            }
            .profile-details .label {
                font-weight: 600;
                color: #34495e;
                min-width: 120px;
                margin-right: 10px;
                flex-shrink: 0;
            }
            .profile-details .value,
            .profile-details input[type="text"],
            .profile-details input[type="email"],
            .profile-details select,
            .profile-details textarea {
                word-break: break-word;
                flex-grow: 1;
                padding: 8px;
                border: 1px solid transparent;
                border-radius: 4px;
                font-size: 1em;
                font-family: inherit;
                color: #555;
                box-sizing: border-box;
            }
            .profile-details.edit-mode .value {
                display: none;
            }
            .profile-details:not(.edit-mode) input,
            .profile-details:not(.edit-mode) select,
            .profile-details:not(.edit-mode) textarea {
                display: none;
            }

            .profile-details.edit-mode input[type="text"],
            .profile-details.edit-mode input[type="email"],
            .profile-details.edit-mode select,
            .profile-details.edit-mode textarea {
                border: 1px solid #ced4da;
                background-color: #fff;
            }
            .profile-details.edit-mode input[readonly] {
                background-color: #e9ecef;
                cursor: not-allowed;
                color: #6c757d;
            }
            .profile-details textarea {
                resize: vertical;
                min-height: 60px;
            }
            .profile-details .edit-mode-item { /* Class để ẩn/hiện input avatar */
                /* Sẽ được JS điều khiển style display */
            }

            .profile-actions {
                margin-top: 30px;
                text-align: center;
                width: 100%;
                display:flex;
                justify-content:center;
                gap:15px;
                flex-wrap: wrap;
            } /* Thêm flex-wrap */
            .profile-actions .button {
                display: inline-block;
                padding: 10px 25px;
                text-decoration: none;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                font-size: 1em;
                margin-bottom: 10px; /* Thêm margin-bottom cho wrap */
            }
            .button.back {
                background-color: #6c757d;
            }
            .button.back:hover {
                background-color: #5a6268;
            }
            .button.edit {
                background-color: #007bff;
            }
            .button.edit:hover {
                background-color: #0056b3;
            }
            .button.save {
                background-color: #28a745;
                display: none;
            } /* Ban đầu ẩn */
            .button.save:hover {
                background-color: #218838;
            }
            .button.cancel {
                background-color: #dc3545;
                display: none;
            } /* Ban đầu ẩn */
            .button.cancel:hover {
                background-color: #c82333;
            }

            .message-feedback {
                width: calc(100% - 20px);
                max-width: 660px;
                margin: 0 auto 20px auto;
                padding: 12px 15px;
                border-radius: 5px;
                box-sizing: border-box;
                font-size: 0.95rem;
                text-align:center;
            }
            .message-feedback.error {
                color: #721c24;
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
            }
            .message-feedback.success {
                color: #155724;
                background-color: #d4edda;
                border: 1px solid #c3e6cb;
            }

            /* Giữ nguyên Media Query của bạn */
            @media (max-width: 600px) {
                .profile-container {
                    width: 95%;
                    padding: 20px;
                }
                .profile-header h1 {
                    font-size: 1.8em;
                }
                .profile-avatar, .profile-avatar-default {
                    width: 120px;
                    height: 120px;
                }
                .profile-avatar-default {
                    font-size: 7em;
                }
                .profile-fullname-display {
                    font-size: 1.3em;
                }
                .profile-details p, .profile-details .info-row {
                    flex-direction: column;
                    align-items: flex-start;
                }
                .profile-details .label {
                    margin-bottom: 3px;
                    min-width: auto;
                }
                .profile-actions .button {
                    display: block;
                    width: calc(100% - 20px);
                    margin-left: auto;
                    margin-right: auto;
                }
            }
        </style>
    </head>
    <body>
        <div class="profile-container">
            <div class="profile-header">
                <h1>My Profile</h1>
            </div>

            <c:if test="${not empty requestScope.profileErrorMessage}">
                <p class="message-feedback error"><c:out value="${requestScope.profileErrorMessage}"/></p>
            </c:if>
            <c:if test="${not empty requestScope.profileSuccessMessage}">
                <p class="message-feedback success"><c:out value="${requestScope.profileSuccessMessage}"/></p>
            </c:if>

            <c:if test="${userProfileData != null}">
                <form id="userProfileForm" method="POST" action="${pageContext.request.contextPath}/userProfileController">
                    <input type="hidden" name="userID_for_update" value="<c:out value="${userProfileData.userID}"/>">

                    <div class="profile-avatar-section">
                        <c:choose>
                            <c:when test="${not empty userProfileData.avatar}">
                                <img src="<c:out value="${userProfileData.avatar}"/>" alt="User Avatar" class="profile-avatar" id="profileAvatarPreview">
                            </c:when>
                            <c:otherwise>
                                <div class="profile-avatar-default" id="profileAvatarDefault">
                                    <i class="fas fa-user-circle"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="profile-fullname-display"><c:out value="${userProfileData.fullName}"/></div>

                        <%-- Input để sửa Avatar URL, ban đầu ẩn, JS sẽ hiện khi ở edit mode --%>
                        <div class="edit-mode-item" style="display:none; margin-top:10px; width:100%; text-align:left;"> <%-- Sửa width và text-align --%>
                            <label for="avatarUrlInput" class="label" style="min-width:auto; margin-right:5px; display:inline-block;">Avatar URL:</label>
                            <input type="text" id="avatarUrlInput" name="avatarUrl" 
                                   value="<c:out value="${userProfileData.avatar}"/>" 
                                   placeholder="http://example.com/avatar.jpg" style="border:1px solid #ccc; padding:5px; width: calc(100% - 100px); display:inline-block;">
                        </div>
                    </div>

                    <div class="profile-details" id="profileDetailsSection">
                        <div class="info-row">
                            <span class="label">Full Name:</span>
                            <span class="value"><c:out value="${userProfileData.fullName}"/></span> 
                            <input type="text" name="fullName" value="<c:out value="${userProfileData.fullName}"/>" required>
                        </div>
                        <div class="info-row">
                            <span class="label">Email:</span>
                            <span class="value"><c:out value="${userProfileData.email}"/></span>
                            <input type="email" name="email_display_only" value="<c:out value="${userProfileData.email}"/>" readonly>
                        </div>
                        <div class="info-row">
                            <span class="label">Gender:</span>
                            <span class="value"><c:out value="${userProfileData.gender}"/></span>
                            <select name="gender">
                                <option value="Male" ${userProfileData.gender == 'Male' ? 'selected' : ''}>Male</option>
                                <option value="Female" ${userProfileData.gender == 'Female' ? 'selected' : ''}>Female</option>
                            </select>
                        </div>
                        <div class="info-row">
                            <span class="label">Mobile:</span>
                            <span class="value"><c:out value="${userProfileData.mobile}"/></span>
                            <input type="text" name="mobile" value="<c:out value="${userProfileData.mobile}"/>">
                        </div>
                        <div class="info-row">
                            <span class="label">Address:</span>
                            <span class="value"><c:out value="${userProfileData.address}"/></span>
                            <textarea name="address" rows="2"><c:out value="${userProfileData.address}"/></textarea>
                        </div>
                    </div>

                    <%-- KHU VỰC NÚT HÀNH ĐỘNG ĐÃ SỬA --%>
                    <div class="profile-actions">
                        <button type="button" class="button edit" id="editButton" onclick="toggleEditMode(true)">Edit Profile</button>
                        <a href="index.jsp" class="button back" id="backButton" style="display: inline-block;">Back to Home</a> 
                        <button type="submit" class="button save" id="saveButton" style="display: none;">Save Changes</button>
                        <button type="button" class="button cancel" id="cancelButton" style="display: none;">Cancel</button>
                    </div>
                </form>
            </c:if>

            <c:if test="${userProfileData == null && empty requestScope.profileErrorMessage && empty requestScope.profileSuccessMessage}">
                <p class="message-feedback error">User profile information is not available.</p>
                <div class="profile-actions">
                    <a href="${pageContext.request.contextPath}/userProfileController" class="button back">Back to User Profile</a>
                </div>
            </c:if>
        </div>

        <script>
            const profileDetailsSection = document.getElementById('profileDetailsSection');
            const editButton = document.getElementById('editButton');
            const saveButton = document.getElementById('saveButton');
            const cancelButton = document.getElementById('cancelButton');
            const backButton = document.getElementById('backButton');
            const avatarUrlInputDiv = document.querySelector('.profile-avatar-section .edit-mode-item'); // Selector cho div chứa input avatar

            let initialValues = {};

            function storeInitialValues() {
                if (!profileDetailsSection)
                    return;
                initialValues = {};
                profileDetailsSection.querySelectorAll('input[type="text"], input[type="email"][readonly], select, textarea').forEach(input => {
                    if (input.name && input.name !== 'userID_for_update') {
                        initialValues[input.name] = input.value;
                    }
                });
                const avatarInput = document.getElementById('avatarUrlInput');
                if (avatarInput) {
                    initialValues['avatarUrl'] = avatarInput.value;
                }
            }

            function restoreInitialValues() {
                if (!profileDetailsSection)
                    return;
                // Điền lại giá trị cho các input/select/textarea từ initialValues
                profileDetailsSection.querySelectorAll('input[type="text"]:not([readonly]), select, textarea').forEach(input => {
                    if (initialValues.hasOwnProperty(input.name)) {
                        input.value = initialValues[input.name];
                    }
                });
                const avatarInput = document.getElementById('avatarUrlInput');
                if (avatarInput && initialValues.hasOwnProperty('avatarUrl')) {
                    avatarInput.value = initialValues['avatarUrl'];
                }
                // Sau khi điền lại input, gọi updateViewModeDisplay để cập nhật các span và avatar/tên hiển thị
                updateViewModeDisplay(initialValues);
            }

            function updateViewModeDisplay(sourceData) {
                if (!profileDetailsSection)
                    return;
                profileDetailsSection.querySelectorAll('.info-row').forEach(row => {
                    const valueSpan = row.querySelector('.value');
                    const inputElement = row.querySelector('input, select, textarea');
                    if (valueSpan && inputElement && sourceData.hasOwnProperty(inputElement.name)) {
                        if (inputElement.tagName === 'SELECT') {
                            for (let i = 0; i < inputElement.options.length; i++) {
                                if (inputElement.options[i].value === sourceData[inputElement.name]) {
                                    valueSpan.textContent = inputElement.options[i].text;
                                    break;
                                }
                            }
                        } else {
                            valueSpan.textContent = sourceData[inputElement.name];
                        }
                    } else if (valueSpan && inputElement && inputElement.name === 'email_display_only' && sourceData.hasOwnProperty(inputElement.name)) {
                        valueSpan.textContent = sourceData[inputElement.name];
                    }
                });

                const fullNameToDisplay = sourceData['fullName'] || '<c:out value="${userProfileData.fullName}"/>';
                document.querySelector('.profile-fullname-display').textContent = fullNameToDisplay;

                const avatarPreview = document.getElementById('profileAvatarPreview');
                const defaultAvatarIcon = document.getElementById('profileAvatarDefault');
                const avatarToDisplay = sourceData.hasOwnProperty('avatarUrl') ? sourceData['avatarUrl'] : ('<c:out value="${userProfileData.avatar}"/>' === '' ? null : '<c:out value="${userProfileData.avatar}"/>');

                if (avatarToDisplay && avatarToDisplay.trim() !== "") {
                    if (avatarPreview)
                        avatarPreview.src = avatarToDisplay;
                    if (avatarPreview)
                        avatarPreview.style.display = 'block';
                    if (defaultAvatarIcon)
                        defaultAvatarIcon.style.display = 'none';
                } else {
                    if (avatarPreview)
                        avatarPreview.src = '';
                    if (avatarPreview)
                        avatarPreview.style.display = 'none';
                    if (defaultAvatarIcon)
                        defaultAvatarIcon.style.display = 'block';
                }
            }

            function toggleEditMode(isEditing) {
                if (!profileDetailsSection || !editButton || !saveButton || !cancelButton || !backButton || !avatarUrlInputDiv) {
                    return;
                }

                if (isEditing) {
                    storeInitialValues();
                    profileDetailsSection.classList.add('edit-mode');
                    if (editButton)
                        editButton.style.display = 'none';
                    if (backButton)
                        backButton.style.display = 'none';
                    if (saveButton)
                        saveButton.style.display = 'inline-block';
                    if (cancelButton)
                        cancelButton.style.display = 'inline-block';
                    if (avatarUrlInputDiv)
                        avatarUrlInputDiv.style.display = 'flex'; // Đổi thành flex để label và input cùng hàng
                    const avatarLabel = avatarUrlInputDiv.querySelector('.label');
                    if (avatarLabel)
                        avatarLabel.style.display = 'inline-block'; // Hiện label của avatar
                } else { // Chuyển về chế độ xem
                    profileDetailsSection.classList.remove('edit-mode');
                    if (editButton)
                        editButton.style.display = 'inline-block';
                    if (backButton)
                        backButton.style.display = 'inline-block';
                    if (saveButton)
                        saveButton.style.display = 'none';
                    if (cancelButton)
                        cancelButton.style.display = 'none';
                    if (avatarUrlInputDiv)
                        avatarUrlInputDiv.style.display = 'none';
                    updateViewModeDisplayFromInputs(); // Cập nhật hiển thị từ giá trị input hiện tại (đã được JSTL cập nhật)
                }
            }

            // Hàm này dùng để cập nhật span.value từ input khi chuyển từ edit mode về view mode
            // (sau khi save thành công và trang reload, hoặc khi DOMContentLoaded mà không có lỗi validation)
            function updateViewModeDisplayFromInputs() {
                if (!profileDetailsSection)
                    return;
                const currentFormValues = {};
                profileDetailsSection.querySelectorAll('input[type="text"], input[type="email"][readonly], select, textarea').forEach(input => {
                    if (input.name && input.name !== 'userID_for_update') {
                        currentFormValues[input.name] = input.value; // Lấy giá trị từ input
                    }
                });
                const avatarInput = document.getElementById('avatarUrlInput');
                if (avatarInput) {
                    currentFormValues['avatarUrl'] = avatarInput.value;
                }
                updateViewModeDisplay(currentFormValues); // Gọi hàm chính để cập nhật hiển thị
            }

            document.addEventListener('DOMContentLoaded', function () {
                const validationErrorOccurred = "<c:out value='${requestScope.validationErrorOccurred == true}'/>";

                if (validationErrorOccurred === 'true') {
                    toggleEditMode(true);
                } else {
                    toggleEditMode(false); // Mặc định là chế độ xem
                }

                if (cancelButton) {
                    cancelButton.addEventListener('click', function () {
                        restoreInitialValues();
                        toggleEditMode(false);
                    });
                }
            });
        </script>
    </body>
</html>
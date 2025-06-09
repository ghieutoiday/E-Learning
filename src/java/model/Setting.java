package model;

public class Setting {
    private int settingID;
    private String type;         // Nhóm cài đặt (VD: General, Security)
    private String settingKey;   // Tên cài đặt (VD: Site Name, Session Timeout)
    private String value;        // Giá trị của cài đặt
    private String description;  // Mô tả chi tiết
    private int orderNum;
    private String status;

    public Setting() {
    }

    public Setting(int settingID, String type, String settingKey, String value, String description, int orderNum, String status) {
        this.settingID = settingID;
        this.type = type;
        this.settingKey = settingKey;
        this.value = value;
        this.description = description;
        this.orderNum = orderNum;
        this.status = status;
    }

    // --- Getters and Setters for all fields ---

    public int getSettingID() {
        return settingID;
    }

    public void setSettingID(int settingID) {
        this.settingID = settingID;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSettingKey() {
        return settingKey;
    }

    public void setSettingKey(String settingKey) {
        this.settingKey = settingKey;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
    
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(int orderNum) {
        this.orderNum = orderNum;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Setting{" + "settingID=" + settingID + ", type=" + type + ", settingKey=" + settingKey + ", value=" + value + ", description=" + description + ", orderNum=" + orderNum + ", status=" + status + '}';
    }
}

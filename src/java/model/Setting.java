/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class Setting {
    private int settingID;
    private String type, value;
    private int orderNum;
    private String status;

    public Setting() {
    }

    public Setting(int settingID, String type, String value, int orderNum, String status) {
        this.settingID = settingID;
        this.type = type;
        this.value = value;
        this.orderNum = orderNum;
        this.status = status;
    }

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

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
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
        return "Setting{" + "settingID=" + settingID + ", type=" + type + ", value=" + value + ", orderNum=" + orderNum + ", status=" + status + '}';
    }

    
}

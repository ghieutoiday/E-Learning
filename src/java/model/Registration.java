/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class Registration {
    private int registrationID;
    private User user;
    private User lastUpdateBy;
    private Course course;
    private PricePackage pricePackage;
    private double totalCost;
    private String status;
    private Date registrationTime, validFrom, validTo;

    public Registration() {
    }

    public Registration(int registrationID, User user, User lastUpdateBy, Course course, PricePackage pricePackage, double totalCost, String status, Date registrationTime, Date validFrom, Date validTo) {
        this.registrationID = registrationID;
        this.user = user;
        this.lastUpdateBy = lastUpdateBy;
        this.course = course;
        this.pricePackage = pricePackage;
        this.totalCost = totalCost;
        this.status = status;
        this.registrationTime = registrationTime;
        this.validFrom = validFrom;
        this.validTo = validTo;
    }

    public int getRegistrationID() {
        return registrationID;
    }

    public void setRegistrationID(int registrationID) {
        this.registrationID = registrationID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getLastUpdateBy() {
        return lastUpdateBy;
    }

    public void setLastUpdateBy(User lastUpdateBy) {
        this.lastUpdateBy = lastUpdateBy;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public PricePackage getPricePackage() {
        return pricePackage;
    }

    public void setPricePackage(PricePackage pricePackage) {
        this.pricePackage = pricePackage;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getRegistrationTime() {
        return registrationTime;
    }

    public void setRegistrationTime(Date registrationTime) {
        this.registrationTime = registrationTime;
    }

    public Date getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(Date validFrom) {
        this.validFrom = validFrom;
    }

    public Date getValidTo() {
        return validTo;
    }

    public void setValidTo(Date validTo) {
        this.validTo = validTo;
    }
    
    
}

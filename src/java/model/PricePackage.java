/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class PricePackage {
    private int pricePackageID;
    private Course course;
    private String name;
    private int accessDuration;
    private double listPrice, salePrice;
    private String description, status;

    public PricePackage() {
    }

    public PricePackage(int pricePackageID, Course course, String name, int accessDuration, double listPrice, double salePrice, String description, String status) {
        this.pricePackageID = pricePackageID;
        this.course = course;
        this.name = name;
        this.accessDuration = accessDuration;
        this.listPrice = listPrice;
        this.salePrice = salePrice;
        this.description = description;
        this.status = status;
    }

    public int getPricePackageID() {
        return pricePackageID;
    }

    public void setPricePackageID(int pricePackageID) {
        this.pricePackageID = pricePackageID;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAccessDuration() {
        return accessDuration;
    }

    public void setAccessDuration(int accessDuration) {
        this.accessDuration = accessDuration;
    }

    public double getListPrice() {
        return listPrice;
    }

    public void setListPrice(double listPrice) {
        this.listPrice = listPrice;
    }

    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    @Override
public String toString() {
    return "PricePackage{" +
           "id=" + pricePackageID +
           ", course=" + (course != null ? course.getCourseName() : "null") +
           ", name='" + name + '\'' +
           ", accessDuration=" + accessDuration +
           ", listPrice=" + listPrice +
           ", salePrice=" + salePrice +
           ", description='" + description + '\'' +
           ", status='" + status + '\'' +
           '}';
}

}

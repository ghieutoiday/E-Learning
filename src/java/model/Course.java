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
public class Course {

    private int courseID;
    private String courseName;
    private CourseCategory courseCategory;
    private String thumbnail, description;
    private User owner;
    private String status;
    private int numberOfLesson;
    private int feature;
    private Date createDate;

    public Course() {
    }

    public Course(int courseID, String courseName, CourseCategory courseCategory, String description, User owner, String status, int numberOfLesson, int feature, Date createDate) {
        this.courseID = courseID;
        this.courseName = courseName;
        this.courseCategory = courseCategory;
        this.description = description;
        this.owner = owner;
        this.status = status;
        this.numberOfLesson = numberOfLesson;
        this.feature = feature;
        this.createDate = createDate;
    }
    
    

    public Course(int courseID, String courseName, CourseCategory courseCategory, String description, User owner, String status, int numberOfLesson, Date createDate) {
        this.courseID = courseID;
        this.courseName = courseName;
        this.courseCategory = courseCategory;
        this.description = description;
        this.owner = owner;
        this.status = status;
        this.numberOfLesson = numberOfLesson;
        this.createDate = createDate;
    }
    
    

    public Course(int courseID, String courseName, CourseCategory courseCategory, String thumbnail, String description, User owner, String status, int numberOfLesson, Date createDate) {
        this.courseID = courseID;
        this.courseName = courseName;
        this.courseCategory = courseCategory;
        this.thumbnail = thumbnail;
        this.description = description;
        this.owner = owner;
        this.status = status;
        this.numberOfLesson = numberOfLesson;
        this.createDate = createDate;
    }

    public Course(int courseID, String courseName, CourseCategory courseCategory, String thumbnail, String description, User owner, String status, int numberOfLesson, int feature, Date createDate) {
        this.courseID = courseID;
        this.courseName = courseName;
        this.courseCategory = courseCategory;
        this.thumbnail = thumbnail;
        this.description = description;
        this.owner = owner;
        this.status = status;
        this.numberOfLesson = numberOfLesson;
        this.feature = feature;
        this.createDate = createDate;
    }

    public int getFeature() {
        return feature;
    }

    public void setFeature(int feature) {
        this.feature = feature;
    }
    

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public CourseCategory getCourseCategory() {
        return courseCategory;
    }

    public void setCourseCategory(CourseCategory courseCategory) {
        this.courseCategory = courseCategory;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getNumberOfLesson() {
        return numberOfLesson;
    }

    public void setNumberOfLesson(int numberOfLesson) {
        this.numberOfLesson = numberOfLesson;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    
}

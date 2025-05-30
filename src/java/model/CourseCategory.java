/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class CourseCategory {
    private int courseCategory;
    private String courseCategoryName;

    public CourseCategory() {
    }

    public CourseCategory(int courseCategory, String courseCategoryName) {
        this.courseCategory = courseCategory;
        this.courseCategoryName = courseCategoryName;
    }

    public int getCourseCategory() {
        return courseCategory;
    }

    public void setCourseCategory(int courseCategory) {
        this.courseCategory = courseCategory;
    }

    public String getCourseCategoryName() {
        return courseCategoryName;
    }

    public void setCourseCategoryName(String courseCategoryName) {
        this.courseCategoryName = courseCategoryName;
    }

    @Override
    public String toString() {
        return courseCategoryName;
    }
    
}

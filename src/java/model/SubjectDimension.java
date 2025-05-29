/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class SubjectDimension {
    private int dimensionID;
    private Course course;
    private String type, name, description;

    public SubjectDimension() {
    }

    public SubjectDimension(int dimensionID, Course course, String type, String name, String description) {
        this.dimensionID = dimensionID;
        this.course = course;
        this.type = type;
        this.name = name;
        this.description = description;
    }

    public int getDimensionID() {
        return dimensionID;
    }

    public void setDimensionID(int dimensionID) {
        this.dimensionID = dimensionID;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "SubjectDimension{" + "dimensionID=" + dimensionID + ", course=" + course + ", type=" + type + ", name=" + name + ", description=" + description + '}';
    }
    
    
}

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
public class UserLessonProgress {
    
    private int userLessonProgressID;
    private User user;
    private Lesson lesson;
    private String status;
    private Date completedAt, createdAt, updatedAt;

    public UserLessonProgress() {
    }

    public UserLessonProgress(int userLessonProgressID, User user, Lesson lesson, String status, Date completedAt, Date createdAt, Date updatedAt) {
        this.userLessonProgressID = userLessonProgressID;
        this.user = user;
        this.lesson = lesson;
        this.status = status;
        this.completedAt = completedAt;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getUserLessonProgressID() {
        return userLessonProgressID;
    }

    public void setUserLessonProgressID(int userLessonProgressID) {
        this.userLessonProgressID = userLessonProgressID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Lesson getLesson() {
        return lesson;
    }

    public void setLesson(Lesson lesson) {
        this.lesson = lesson;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(Date completedAt) {
        this.completedAt = completedAt;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    
}

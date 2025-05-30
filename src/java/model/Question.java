/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class Question {
    private int questionID;
    private Course course;
    private Lesson lesson;
    private int demension;
    private String content, media, explanation;
    private int level;
    private String status;

    public Question() {
    }

    public Question(int questionID, Course course, Lesson lesson, int demension, String content, String media, String explanation, int level, String status) {
        this.questionID = questionID;
        this.course = course;
        this.lesson = lesson;
        this.demension = demension;
        this.content = content;
        this.media = media;
        this.explanation = explanation;
        this.level = level;
        this.status = status;
    }

    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public Lesson getLesson() {
        return lesson;
    }

    public void setLesson(Lesson lesson) {
        this.lesson = lesson;
    }

    public int getDemension() {
        return demension;
    }

    public void setDemension(int demension) {
        this.demension = demension;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getMedia() {
        return media;
    }

    public void setMedia(String media) {
        this.media = media;
    }

    public String getExplanation() {
        return explanation;
    }

    public void setExplanation(String explanation) {
        this.explanation = explanation;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}

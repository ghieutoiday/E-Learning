/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class AnswerOption {
    private int answerOptionID;
    private Question question;
    private String content;
    private boolean isCorrect;

    public AnswerOption() {
    }

    public AnswerOption(int answerOptionID, Question question, String content, boolean isCorrect) {
        this.answerOptionID = answerOptionID;
        this.question = question;
        this.content = content;
        this.isCorrect = isCorrect;
    }

    public int getAnswerOptionID() {
        return answerOptionID;
    }

    public void setAnswerOptionID(int answerOptionID) {
        this.answerOptionID = answerOptionID;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean isIsCorrect() {
        return isCorrect;
    }

    public void setIsCorrect(boolean isCorrect) {
        this.isCorrect = isCorrect;
    }
    
    
}

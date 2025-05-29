/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class QuizQuestion {
    private int quizID;
    private Question question;

    public QuizQuestion() {
    }

    public QuizQuestion(int quizID, Question question) {
        this.quizID = quizID;
        this.question = question;
    }

    public int getQuizID() {
        return quizID;
    }

    public void setQuizID(int quizID) {
        this.quizID = quizID;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    @Override
    public String toString() {
        return "QuizQuestion{" + "quizID=" + quizID + ", question=" + question + '}';
    }
    
    
    
}

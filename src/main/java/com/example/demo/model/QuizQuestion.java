package com.example.demo.model;

import jakarta.persistence.*;

@Entity
@Table(name = "quiz_questions")
public class QuizQuestion {
    @EmbeddedId
    private QuizQuestionId id;

    public QuizQuestion() {
    }

    public QuizQuestionId getId() {
        return id;
    }

    public void setId(QuizQuestionId id) {
        this.id = id;
    }
}

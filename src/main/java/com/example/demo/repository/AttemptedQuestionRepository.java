package com.example.demo.repository;

import com.example.demo.model.AttemptedQuestion;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AttemptedQuestionRepository extends JpaRepository<AttemptedQuestion, Integer> {
}

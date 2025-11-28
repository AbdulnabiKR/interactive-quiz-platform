package com.example.demo.repository;

import com.example.demo.model.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface QuestionRepository extends JpaRepository<Question, Integer> {

    // Fetch questions for a specific quiz via the quiz_questions mapping table
    @Query(value = "SELECT q.* FROM questions q " +
            "JOIN quiz_questions qq ON q.id = qq.question_id " +
            "WHERE qq.quiz_id = :quizId", nativeQuery = true)
    List<Question> findByQuizId(@Param("quizId") Integer quizId);
}

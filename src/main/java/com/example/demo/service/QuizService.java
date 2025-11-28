package com.example.demo.service;

import com.example.demo.model.Quiz;
import com.example.demo.repository.QuizRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class QuizService {
    @Autowired
    private QuizRepository quizRepository;

    // Create
    public Quiz addQuiz(Quiz quiz) {
        return quizRepository.save(quiz);
    }

    // List all
    public List<Quiz> getAllQuizzes() {
        return quizRepository.findAll();
    }

    // Get by ID
    public Quiz getQuizById(Integer id) {
        return quizRepository.findById(id).orElse(null);
    }

    // Update by ID
    public Quiz updateQuiz(Integer id, Quiz updatedQuiz) {
        return quizRepository.findById(id)
                .map(existing -> {
                    existing.setTitle(updatedQuiz.getTitle());
                    existing.setDescription(updatedQuiz.getDescription());
                    existing.setStatus(updatedQuiz.getStatus());
                    existing.setCreatedBy(updatedQuiz.getCreatedBy());
                    existing.setCreatedAt(updatedQuiz.getCreatedAt());
                    return quizRepository.save(existing);
                })
                .orElse(null);
    }

    // Delete by ID
    public boolean deleteQuiz(Integer id) {
        if (quizRepository.existsById(id)) {
            quizRepository.deleteById(id);
            return true;
        } else {
            return false;
        }
    }
}

package com.example.demo.service;

import com.example.demo.model.AttemptedQuestion;
import com.example.demo.repository.AttemptedQuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class AttemptedQuestionService {
    @Autowired
    private AttemptedQuestionRepository repo;

    public AttemptedQuestion save(AttemptedQuestion question) {
        return repo.save(question);
    }

    public List<AttemptedQuestion> getAll() {
        return repo.findAll();
    }

    // Get by ID
    public AttemptedQuestion getById(Integer id) {
        return repo.findById(id).orElse(null);
    }

    // DELETE
    public boolean delete(Integer id) {
        if (repo.existsById(id)) {
            repo.deleteById(id);
            return true;
        } else {
            return false;
        }
    }
}

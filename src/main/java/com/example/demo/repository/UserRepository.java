package com.example.demo.repository;

import com.example.demo.model.User; // Adjust if using a "model" package
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Integer> {
    User findByUsername(String username);

    User findByEmail(String email);
}

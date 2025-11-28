CREATE DATABASE quiz_platform;
USE quiz_platform;
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role ENUM('user','admin') DEFAULT 'user',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, password, email, role)
VALUES
  ('john_doe', 'hashed_password1', 'john@example.com', 'user'),
  ('admin', 'hashed_admin_password', 'admin@example.com', 'admin'),
  ('jane_smith', 'hashed_password2', 'jane@example.com', 'user');

-- Quizzes (unique, no duplicate titles)
CREATE TABLE quizzes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    status ENUM('active','inactive') DEFAULT 'active',
    created_by INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id)
);

INSERT INTO quizzes (title, description, status, created_by)
VALUES
  ('General Knowledge', 'Test your general knowledge!', 'active', 2),
  ('Java Basics', 'Basic concepts of Java programming', 'active', 2),
  ('Tech Quiz', 'Programming and computer basics!', 'active', 2); -- NEW SECTION

-- Questions: assign each question to the right quiz via quiz_questions mapping
CREATE TABLE questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_text TEXT NOT NULL,
    option_a VARCHAR(255) NOT NULL,
    option_b VARCHAR(255) NOT NULL,
    option_c VARCHAR(255) NOT NULL,
    option_d VARCHAR(255) NOT NULL,
    correct_option CHAR(1) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Unique questions, each for a specific quiz
INSERT INTO questions (question_text, option_a, option_b, option_c, option_d, correct_option)
VALUES
  -- GK
  ('What is the capital of India?', 'Delhi', 'Mumbai', 'Kolkata', 'Chennai', 'A'),
  ('What is H2O commonly known as?', 'Hydrogen', 'Oxygen', 'Water', 'Salt', 'C'),
  -- Java Basics
  ('Which keyword is used to declare a class in Java?', 'function', 'class', 'public', 'package', 'B'),
  ('Which method is the entry point in a Java app?', 'run', 'execute', 'start', 'main', 'D'),
  -- Tech Quiz
  ('Who invented the World Wide Web?', 'Bill Gates', 'Tim Berners-Lee', 'Elon Musk', 'Steve Jobs', 'B'),
  ('Which is the largest planet in the solar system?', 'Earth', 'Jupiter', 'Mars', 'Saturn', 'B');

-- Mapping questions to quizzes (many-to-many)
CREATE TABLE quiz_questions (
    quiz_id INT NOT NULL,
    question_id INT NOT NULL,
    PRIMARY KEY (quiz_id, question_id),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
);

-- Assign unique questions to the correct quiz (get IDs from auto_increment or SELECT * FROM)
-- For this example, let's assume:
-- GK: questions.id=1 and 2, Java: id=3 and 4, Tech: id=5 and 6

INSERT INTO quiz_questions (quiz_id, question_id) VALUES
  (1, 1), (1, 2),    -- General Knowledge
  (2, 3), (2, 4),    -- Java Basics
  (3, 5), (3, 6);    -- Tech Quiz

-- Attempts and attempted questions tables (leave empty for now, used by app)
CREATE TABLE quiz_attempts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    quiz_id INT,
    score INT,
    taken_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    duration_sec INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id)
);

CREATE TABLE attempted_questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    attempt_id INT,
    question_id INT,
    chosen_option CHAR(1),
    is_correct BOOLEAN,
    FOREIGN KEY (attempt_id) REFERENCES quiz_attempts(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE 
);

-- Clean up foreign key for attempted_questions if needed (your code does this)
ALTER TABLE attempted_questions DROP FOREIGN KEY attempted_questions_ibfk_2;

ALTER TABLE attempted_questions
  ADD CONSTRAINT fk_attempted_question_qid
  FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE;

-- TEST: See structure and all data
SELECT * FROM quizzes;
SELECT * FROM questions;
SELECT * FROM quiz_questions;
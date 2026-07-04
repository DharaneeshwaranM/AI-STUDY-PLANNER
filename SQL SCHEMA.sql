-- ==========================================
-- AI STUDY PLANNER MYSQL DATABASE SETUP
-- ==========================================

CREATE DATABASE IF NOT EXISTS ai_study_planner;
USE ai_study_planner;

DROP TABLE IF EXISTS tasks;
DROP TABLE IF EXISTS study_plans;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS syllabi;

CREATE TABLE users (

    
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE study_plans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT DEFAULT 1,
    goal_text TEXT,
    plan_json JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT DEFAULT 1,
    title VARCHAR(255) NOT NULL,
    subject VARCHAR(100),
    deadline DATE,
    priority ENUM('Low', 'Medium', 'High') DEFAULT 'Medium',
    is_completed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS focus_sessions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT DEFAULT 1,
    subject VARCHAR(100) NOT NULL,
    duration_seconds INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS subject_roadmaps (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject VARCHAR(100) NOT NULL,
    roadmap_json JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS syllabi (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    subject VARCHAR(100) NOT NULL,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- ------------------------------------------
-- 3. MOCK DATA (For testing your queries)
-- ------------------------------------------

-- Insert a test user (Password is 'password123')
INSERT INTO users (name, email, password_hash)
VALUES ('Alex Dev', 'alex@example.com', 'scrypt:32768:8:1$u6Nq6S7q$9e7b30969d7b889387e6181f0857216a698a96b2708b5e2a2221369f88d7f3e8');

-- Insert a sample study plan for the user with ID 1
INSERT INTO study_plans (user_id, goal_text, plan_json)
VALUES (1, 'Mastering MySQL', '{"sessions": []}');
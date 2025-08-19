-- Create Database
CREATE DATABASE SportsTournamentDB;
USE SportsTournamentDB;

-- Create Teams Table
CREATE TABLE Teams (
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(50) NOT NULL,
    coach_name VARCHAR(50)
);

-- Create Players Table
CREATE TABLE Players (
    player_id INT AUTO_INCREMENT PRIMARY KEY,
    player_name VARCHAR(50) NOT NULL,
    team_id INT,
    role VARCHAR(30),
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

-- Create Matches Table
CREATE TABLE Matches (
    match_id INT AUTO_INCREMENT PRIMARY KEY,
    team1_id INT,
    team2_id INT,
    match_date DATE,
    winner_id INT,
    FOREIGN KEY (team1_id) REFERENCES Teams(team_id),
    FOREIGN KEY (team2_id) REFERENCES Teams(team_id),
    FOREIGN KEY (winner_id) REFERENCES Teams(team_id)
);

-- Create Stats Table
CREATE TABLE Stats (
    stat_id INT AUTO_INCREMENT PRIMARY KEY,
    match_id INT,
    player_id INT,
    runs INT DEFAULT 0,
    wickets INT DEFAULT 0,
    points INT DEFAULT 0,
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (player_id) REFERENCES Players(player_id)
);

-- Insert Teams
INSERT INTO Teams (team_name, coach_name) VALUES
('Warriors', 'John Smith'),
('Titans', 'Alex Brown'),
('Strikers', 'Michael Lee');

-- Insert Players
INSERT INTO Players (player_name, team_id, role) VALUES
('David Warner', 1, 'Batsman'),
('Chris Green', 1, 'Bowler'),
('Steve Taylor', 2, 'All-Rounder'),
('Mark Johnson', 2, 'Batsman'),
('Sam Wilson', 3, 'Bowler'),
('Kevin Stark', 3, 'Batsman');

-- Insert Matches
INSERT INTO Matches (team1_id, team2_id, match_date, winner_id) VALUES
(1, 2, '2025-08-01', 1),
(2, 3, '2025-08-05', 3),
(1, 3, '2025-08-10', 1);

-- Insert Stats
INSERT INTO Stats (match_id, player_id, runs, wickets, points) VALUES
(1, 1, 55, 0, 10),
(1, 2, 10, 2, 8),
(1, 3, 35, 1, 7),
(1, 4, 20, 0, 4),
(2, 3, 45, 0, 9),
(2, 4, 30, 0, 5),
(2, 5, 10, 3, 8),
(3, 1, 70, 0, 12),
(3, 2, 5, 1, 3),
(3, 6, 40, 0, 7);


-- ✅ Queries & Outputs --

-- Match Results
SELECT m.match_id, t1.team_name AS Team1, t2.team_name AS Team2,
       t3.team_name AS Winner, m.match_date
FROM Matches m
JOIN Teams t1 ON m.team1_id = t1.team_id
JOIN Teams t2 ON m.team2_id = t2.team_id
JOIN Teams t3 ON m.winner_id = t3.team_id;

-- Player Scores
SELECT p.player_name, SUM(s.runs) AS TotalRuns, 
       SUM(s.wickets) AS TotalWickets, SUM(s.points) AS TotalPoints
FROM Stats s
JOIN Players p ON s.player_id = p.player_id
GROUP BY p.player_id;

-- Leaderboard (View) 
CREATE OR REPLACE VIEW Leaderboard AS
SELECT p.player_name, t.team_name, SUM(s.points) AS TotalPoints
FROM Stats s
JOIN Players p ON s.player_id = p.player_id
JOIN Teams t ON p.team_id = t.team_id
GROUP BY p.player_id
ORDER BY TotalPoints DESC;

-- Team Points Table (View)
CREATE OR REPLACE VIEW TeamPoints AS
SELECT t.team_name, COUNT(m.match_id) AS MatchesPlayed,
       SUM(CASE WHEN m.winner_id = t.team_id THEN 1 ELSE 0 END) AS Wins,
       SUM(CASE WHEN m.winner_id IS NOT NULL AND m.winner_id != t.team_id THEN 1 ELSE 0 END) AS Losses
FROM Teams t
LEFT JOIN Matches m ON t.team_id IN (m.team1_id, m.team2_id)
GROUP BY t.team_id;

-- Average Player Performance (CTE) ✅ Fixed for MySQL 8
WITH AvgPerformance AS (
    SELECT p.player_name, 
           AVG(s.runs) AS AvgRuns, 
           AVG(s.wickets) AS AvgWickets, 
           AVG(s.points) AS AvgPoints
    FROM Stats s
    JOIN Players p ON s.player_id = p.player_id
    GROUP BY p.player_id
)
SELECT * FROM AvgPerformance;

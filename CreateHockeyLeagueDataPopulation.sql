USE HockeyLeague
/*Populate the Team table */
INSERT INTO Team VALUES (1, 'Blades of Steel', 'Never-Ever', 1)
INSERT INTO Team VALUES (2, 'Puck U', 'Never-Ever', 1)
/*Populate the Player table */
INSERT INTO Player VALUES (1, 1, 17, 'Jeff', 'Davis', 'R')
INSERT INTO Player VALUES (2, 1, 54, 'Greg', 'Tales', 'R')
INSERT INTO Player VALUES (3, 1, 79, 'David', 'Glanville', 'D')
INSERT INTO Player VALUES (4, 1, 88, 'Alec', 'Glanville', 'L')
INSERT INTO Player VALUES (5, 1, 22, 'Jared', 'Exel', 'D')
INSERT INTO Player VALUES (6, 1, 92, 'David', 'Gallinat', 'C')
INSERT INTO Player VALUES (7, 1, 2, 'Joseph', 'Angileri', 'C')
INSERT INTO Player VALUES (8, 1, 11, 'Brian', 'Doull', 'D')
INSERT INTO Player VALUES (9, 1, 84, 'Randall', 'Hucks', 'D')
INSERT INTO Player VALUES (10, 1, 44, 'Paul', 'Longworth', 'L')
INSERT INTO Player VALUES (11, 1, 47, 'Ryan', 'Riker', 'C')
INSERT INTO Player VALUES (12, 2, 71, 'Paul', 'Granowicz', 'R')
INSERT INTO Player VALUES (13, 2, 41, 'Aron', 'Harris', 'C')
INSERT INTO Player VALUES (14, 2, 0, 'Richard', 'Kummert', 'L')
INSERT INTO Player VALUES (15, 2, 5, 'Kristen', 'Granowicz', 'D')
INSERT INTO Player VALUES (16, 2, 21, 'Angela', 'James', 'D')
INSERT INTO Player VALUES (17, 2, 47, 'Alejandro', 'Mendoza', 'D')
INSERT INTO Player VALUES (19, 2, 24, 'Jeff', 'Miller', 'C')
INSERT INTO Player VALUES (19, 2, 10, 'Nick', 'Demeester', 'R')
/*Populate Game table*/
INSERT INTO Game VALUES (1, 1, 2)
/*Populate Score Table*/
INSERT INTO Score VALUES (1, 1, 1, 2, 0, 1, '10:15')
INSERT INTO Score VALUES (2, 1, 2, 3, 0, 1, '8:22')
INSERT INTO Score VALUES (3, 1, 12, 13, 14, 1, '5:48')
INSERT INTO Score VALUES (4, 1, 5, 3, 0, 1, '0:21')
INSERT INTO Score Values (5, 1, 4, 1, 6, 2, '6:07')
/*Populate Penalty Table*/
INSERT INTO Penalty Values (1, 1, 10, 1, '3:10', 'High-Stick', 3)
INSERT INTO Penalty Values (2, 1, 19, 2, '3:05', 'Roughing', 3)
INSERT INTO Penalty Values (3, 1, 3, 2, '3:05', 'Slashing', 3)
INSERT INTO Penalty Values (4, 1, 7, 2, '3:05', 'Roughing', 3)

/*Stored Procedure for Game Data*/

CREATE PROC GameData
AS
BEGIN
SELECT 
    Score.ScorePeriod,
    Team.TeamName,
    Count(*) as Goals
FROM 
Score LEFT OUTER JOIN 
Player as Scorer ON Score.ScorerID = Scorer.ID
LEFT OUTER JOIN
Team on Scorer.TeamID = Team.ID
WHERE GameID = 1
GROUP BY Score.ScorePeriod, Team.TeamName
ORDER BY ScorePeriod, TeamName


SELECT 
    Score.ScorePeriod,
    CAST (Score.ScoreTime as Time) as GoalTime,
    Scorer.JerseyNumber as ScorerNum, Scorer.FName +' '+ Scorer.LName as ScoredBy,
    Assist1.JerseyNumber as Assist1Num, Assist1.FName +' '+ Assist1.LName as FirstAssist,
    Assist2.JerseyNumber as Assist2Num, Assist2.FName +' '+ Assist2.LName as SecondAssist
FROM 
Score LEFT OUTER JOIN 
Player as Scorer ON Score.ScorerID = Scorer.ID LEFT OUTER JOIN
Player as Assist1 ON Score.Asist1ID = Assist1.ID LEFT OUTER JOIN
Player as Assist2 ON Score.Assist2ID = Assist2.ID
WHERE GameID = 1 and ScorePeriod = 1


SELECT 
    Score.ScorePeriod,
    CAST (Score.ScoreTime as Time) as GoalTime,
    Scorer.JerseyNumber as ScorerNum, Scorer.FName +' '+ Scorer.LName as ScoredBy,
    Assist1.JerseyNumber as Assist1Num, Assist1.FName +' '+ Assist1.LName as FirstAssist,
    Assist2.JerseyNumber as Assist2Num, Assist2.FName +' '+ Assist2.LName as SecondAssist
FROM 
Score LEFT OUTER JOIN 
Player as Scorer ON Score.ScorerID = Scorer.ID LEFT OUTER JOIN
Player as Assist1 ON Score.Asist1ID = Assist1.ID LEFT OUTER JOIN
Player as Assist2 ON Score.Assist2ID = Assist2.ID
WHERE GameID = 1 and ScorePeriod = 2

SELECT 
    Score.ScorePeriod,
    CAST (Score.ScoreTime as Time) as GoalTime,
    Scorer.JerseyNumber as ScorerNum, Scorer.FName +' '+ Scorer.LName as ScoredBy,
    Assist1.JerseyNumber as Assist1Num, Assist1.FName +' '+ Assist1.LName as FirstAssist,
    Assist2.JerseyNumber as Assist2Num, Assist2.FName +' '+ Assist2.LName as SecondAssist
FROM 
Score LEFT OUTER JOIN 
Player as Scorer ON Score.ScorerID = Scorer.ID LEFT OUTER JOIN
Player as Assist1 ON Score.Asist1ID = Assist1.ID LEFT OUTER JOIN
Player as Assist2 ON Score.Assist2ID = Assist2.ID
WHERE GameID = 1 and ScorePeriod = 3

SELECT
    Penalty.PenaltyPeriod, 
    CAST(Penalty.PenaltyTime as time) as PenaltyTime, 
    Player.FName + ' ' + Player.LName as Player, 
    CAST(Penalty.PenaltyMinutes as varchar(2)) + ' minutes for ' + Penalty.Penalty as Penalty 
FROM 
    Penalty LEFT OUTER JOIN Player ON Penalty.PlayerID = Player.ID
END

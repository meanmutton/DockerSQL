USE HockeyLeague
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
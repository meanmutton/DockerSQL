CREATE DATABASE HockeyLeague
GO
USE HockeyLeague
CREATE TABLE Team (ID int, TeamName nvarchar(30), Division nvarchar(10), IsActive bit)
CREATE TABLE Player (ID int, TeamID int, JerseyNumber int, FName nvarchar(20), LName nvarchar(20), Position nvarchar(1))
CREATE TABLE Game (ID int, HomeTeamID int, VisitorTeamID int)
CREATE TABLE Penalty (ID int, GameID int, PlayerID int, PenaltyPeriod int, PenaltyTime datetime, Penalty nvarchar (10), PenaltyMinutes int)
CREATE TABLE Score (ID int, GameID int, ScorerID int, Asist1ID int, Assist2ID int, ScorePeriod int, ScoreTime datetime)

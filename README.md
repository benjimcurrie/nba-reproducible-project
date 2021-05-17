
# NBA Reproducible Project

<br/>

## Introduction
<br/>

This GitHub repository comprises the components for a reproducible data analysis project, for the purpose of assessment within the 'Applied Data Analysis in Sport' course at the University of Canberra. 

Following a season where the Chicago Bulls finished with a record of 22 wins and 60 losses (ranked 4th worst in the league, 27th of 30). The General Manager of the Chicago Bulls is investing in the data analytics approach to find the best starting five players for the 2019-20 NBA season. As the data analysis with the Chicago Bulls NBA (National Basketball Association), the team’s owners have set the budget at $118 million (ranked 26th of 30 teams) for player contracts for the 2019-20 season.

For perspective, the team with the highest payroll budget is Portland with $148 million, while the best performing team was Milwaukee Bucks, who clenched a 60-22 win-loss record in the 2018-19 NBA Season, have a team payroll of $131 million.

The aim of this project is to identify a starting five line-up for the Chicago Bulls in the 2019-20 NBA Season.
The aim of this project needs to be achieved within the following parameters:
  1.	The starting line-up will need to be made up of a player from each of the traditional starting positions (1) Point Guard, (2) Shooting Guard, (SF) Small Forward, (4) Power Forward, and (5) Centre. 
  2.	The team's budget for player contracts next season is $118 million, and the team’s management will need to complete a full roster (15 players in the 2019-20 NBA Season) for the upcoming season. 
  3.	Team management will require justification for each of the player selections.
  4.	Develop a reproducible data analysis project and generate a knitr report using R Markdown describing your analysis and findings to the General Manager.

<br/> 

### Contents

  1. Location of files
  2. Data sources
  3. Definitions of variables for each data set
  4. Created variables

<br/> 

### 1. Location of Files

  1. Rmarkdown
  2. Data
    2.1 Raw-data
    2.2 Processed-data
  3. Rscript files
    3.1 Cleaning.R
    3.2 exploratory-analysis.R
    3.3 models.R
  4. Figures
  
<br/> 
  
### 2. Data Sources

  1. [2018-19_nba_player-statistics.csv](https://www.basketball-reference.com/leagues/NBA_2019_totals.html)  

  2. [2018-19_nba_player-salaries.csv](https://hoopshype.com/salaries/)  

  3. [2019-20_nba_team-payroll.csv](https://hoopshype.com/salaries/)  

  4. [2018-19_nba_team-statistics_1.csv](https://www.basketball-reference.com/leagues/NBA_2019.html)  

  5. [2018-19_nba_team-statistics_2.csv](https://www.basketball-reference.com/leagues/NBA_2019.html)

<br/> 

### 3. Definitions of Variables

#### 2018-19_nba_player-statistics.csv  
Explained variables within the 2018-19_nba_player-statistics data-set:

  player_name : Player Name
  Pos :  (PG = point guard, SG = shooting guard, SF = small forward, PF = power forward, C = center) 
  Age : Age of Player at the start of February 1st of that season.
  Tm : Team
  G : Games
  GS : Games Started
  MP : Minutes Played
  FG : Field Goals
  FGA : Field Goal Attempts
  FG% : Field Goal Percentage
  3P : 3-Point Field Goals
  3PA : 3-Point Field Goal Attempts
  3P% : FG% on 3-Pt FGAs
  2P : 2-Point Field Goals
  2PA : 2-point Field Goal Attempts
  2P% : FG% on 2-Pt FGAs
  eFG% : Effective Field Goal Percentage
  FT : Free Throws
  FTA : Free Throw Attempts
  FT% : Free Throw Percentage
  ORB : Offensive Rebounds
  DRB : Defensive Rebounds
  TRB : Total Rebounds
  AST : Assists
  STL : Steals
  BLK : Blocks
  TOV : Turnovers
  PF : Personal Fouls
  PTS : Points

#### 2018-19_nba_player-salaries.csv 
Explained variables within the 2018-19_nba_player-salaries data-set:

  player_id : unique player identification number
  player_name : player name
  salary : year salary in $USD
 
#### 2018-19_nba_team-statistics_1.csv 
Explained variables within the 2018-19_nba_team-statistics_1 data-set:

  Rk : Rank
  Age : Mean Age of Player at the start of February 1st of that season.
  W : Wins
  L : Losses
  PW : Pythagorean wins, i.e., expected wins based on points scored and allowed
  PL : Pythagorean losses, i.e., expected losses based on points scored and allowed
  MOV : Margin of Victory
  SOS : Strength of Schedule; a rating of strength of schedule. The rating is denominated in points above/below average, where zero is average.
  SRS : Simple Rating System; a team rating that takes into account average point differential and strength of * schedule. The rating is denominated in points above/below average, where zero is average.
  ORtg : Offensive Rating; An estimate of points produced (players) or scored (teams) per 100 possessions
  DRtg : Defensive Rating; An estimate of points allowed per 100 possessions
  NRtg : Net Rating; an estimate of point differential per 100 possessions.
  Pace : Pace Factor: An estimate of possessions per 48 minutes
  FTr : Free Throw Attempt Rate; Number of FT Attempts Per FG Attempt
  3PAr : 3-Point Attempt Rate; Percentage of FG Attempts from 3-Point Range
  TS% : True Shooting Percentage; A measure of shooting efficiency that takes into account 2-point field goals, 3-point field goals, and free throws.
  eFG% : Effective Field Goal Percentage; This statistic adjusts for the fact that a 3-point field goal is worth one more point than a 2-point field goal.
  TOV% : Turnover Percentage; An estimate of turnovers committed per 100 plays.
  ORB% : Offensive Rebound Percentage; An estimate of the percentage of available offensive rebounds a player grabbed while he was on the floor.
  FT/FGA : Free Throws Per Field Goal Attempt
  DRB% : Defensive Rebound Percentage
 
#### 2018-19_nba_team-statistics_2.csv 
Explained variables within the 2018-19_nba_team-statistics_2 data-set:

  Team : Team name
  Rk : Ranking
  MP : Minutes Played
  G : Games
  FG : Field Goals
  FGA : Field Goal Attempts
  FG% : Field Goal Percentage
  3P : 3-Point Field Goals
  3PA : 3-Point Field Goal Attempts
  3P% : FG% on 3-Pt FGAs
  2P : 2-Point Field Goals
  2PA : 2-point Field Goal Attempts
  2P% : FG% on 2-Pt FGAs
  FT : Free Throws
  FTA : Free Throw Attempts
  FT% : Free Throw Percentage
  ORB : Offensive Rebounds
  DRB : Defensive Rebounds
  TRB : Total Rebounds
  AST : Assists
  STL : Steals
  BLK : Blocks
  TOV : Turnovers
  PF : Personal Fouls
  PTS : Points

#### 2018-19_nba_team-payroll.csv 
Explained variables within the 2018-19_nba_team-payroll data-set:

  team_id : unique team identification number
  team : team name
  salary : team payroll budget in 2019-20 in $USD
 
### 4. Created Variables

<br/> 

#### EFF - Individual player efficiency


The NBA publishes online all of the basic statistics recorded officially by the league. Individual player efficiency is expressed there by a stat referred to as 'efficiency' and abbreviated EFF. \

It is derived by a simple formula: 

(PTS + REB + AST + STL + BLK − Missed FG − Missed FT - TO) / GP.
\

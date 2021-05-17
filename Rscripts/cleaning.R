# Cleaning the data ----

## Cleaning r.script for NBA reproducible project

## Load Packages ----
library (tidyverse) # load tidyverse
library(dplyr)

## Read in the player data ----
player_stats <- read_csv("data/raw/2018-19_nba_player-statistics.csv") # player stats
player_sal <- read_csv("data/raw/2018-19_nba_player-salaries.csv") # players salaries

## Read in the team data ----
team_stats1 <- read_csv("data/raw/2018-19_nba_team-statistics_1.csv") # team stats
team_stats2 <- read_csv("data/raw/2018-19_nba_team-statistics_2.csv") # team stats
team_pay <- read_csv("data/raw/2019-20_nba_team-payroll.csv") # team payroll

## Data Wrangle ----

### Tidy player data ----

## remove rows with "TOT" as Team
player_stats_tidyish <- player_stats[player_stats$Tm != "TOT", ] # remove rows with "TOT" as the team. "TOT" served as a combination of player data for the 2018-29 season.

## group players with multiple rows by numerical and character and join
player_stats_ch <- player_stats_tidyish %>% 
  group_by(player_name) %>% 
  summarise_if(~ is.character(.) || is.factor(.), ~ paste(., collapse="_"))

player_stats_age <- player_stats_tidyish %>% 
  group_by(player_name) %>% 
  summarise(across(c(Age), mean))

player_stats_num <- player_stats_tidyish %>% 
  group_by(player_name) %>% 
  summarise(across(c(G, GS, MP, FG, FGA, `FG%`, `3P`, `3PA`, `3P%`, `2P`, `2PA`, `2P%`, `eFG%`, FT, FTA, 'FT%', ORB, DRB, TRB, AST, STL, BLK, TOV, PF, PTS), sum))

player_stats_tidy <- inner_join(player_stats_ch, player_stats_age, by = c("player_name"))
player_stats_tidy <- inner_join(player_stats_tidy, player_stats_num, by = c("player_name"))

### Transforming player_statistics data ----

## rename variables
player_stats_transformed <- rename(player_stats_tidy, FGp = 'FG%', x3P = '3P', x3PA = '3PA', x3Pp = '3P%', x2P = '2P', x2PA = '2PA', x2Pp = '2P%', eFGp = 'eFG%', FTp = 'FT%')

### Create new variables ----

## Games started percentage - to have a variable to indicate the percentage of games started from games played in. This variable will be used to create a categorical variable based on its percentage output.
player_stats_transformed <- mutate(player_stats_transformed, GSp = GS/G)

### Assist to turnover ratio "AST_to_TOV_ratio
player_stats_transformed <- mutate(player_stats_transformed, AST_to_TOV_ratio = AST/TOV) # New variable AST_to_TOV_ratio created for assist to turnover ratio as a player metric for point guards

### 'Efficiency' rating for individual players 'EFF'. EFF is an individual player efficiency rating this project will use to measure a players performance.

## new variables required to calculate EFF - "FG_miss", "FT_miss"
player_stats_transformed <- mutate(player_stats_transformed, FG_miss = FGA - FG) # New variable EFF created as a measure of player rating
player_stats_transformed <- mutate(player_stats_transformed, FT_miss = FTA - FT) # New variable EFF created as a measure of player rating
player_stats_transformed <- mutate(player_stats_transformed, EFF = (PTS + TRB + AST + STL + BLK - FG_miss - FT_miss - TOV)/G) # New variable EFF created as a measure of player rating

## create new _per_game variable for MP, FG, FGA, x3P, x3PA, x2P, x2PA, FT, FTA, ORB, DRB, TRB, AST, STL, BLK, TOV, PF, PTS

player_stats_transformed <- mutate(player_stats_transformed, 
                                   MP_per_game = MP/G,
                                   ORB_per_game = ORB/G, 
                                   DRB_per_game = DRB/G, 
                                   TRB_per_game = TRB/G, 
                                   AST_per_game = AST/G, 
                                   STL_per_game = STL/G, 
                                   BLK_per_game = BLK/G, 
                                   TOV_per_game = TOV/G, 
                                   PTS_per_game = PTS/G)

## combine the player salary data to the tidier player_stats data
player_stats_clean <- right_join(x = player_stats_transformed, y = player_sal[-c(1)], by = c("player_name")) # combine players_stats and player salary data

## dollars_per_EFF
player_stats_clean <- mutate(player_stats_clean, dollars_per_EFF = salary/EFF) # New variable dollars_per_EFF created as a player value metric

## dollars_per_PTS_per_game
player_stats_clean <- mutate(player_stats_clean, dollars_per_PTS_per_game = salary/PTS_per_game) # New variable dollars_per_PTS_per_game created as a measure of player value metric

## round to 3 decimal places across the data frame

player_stats_clean <- player_stats_clean %>% 
  mutate(across(where(is.numeric), ~ round(., 2)))

## Create "Starter" or "Non-Starter" variable
player_stats_clean <- mutate(player_stats_clean, Starter = ifelse(GSp > 0.7, "Starter", "Non-Starter")) # New categorical variable to determine if player is a starter or non-starter to filter for selecting starting 5. Player must have started 70% of games to be considered as a starter for this project

## Tidy team data ----

## combine team data
team_stats_combined <- right_join(x = team_stats1[-c(1,23,24,25)], y = team_stats2[-c(1)], by = c("Team")) # combine team_stats data

team_stats_transformed <- rename(team_stats_combined, x3PAr = '3PAr', TSp = 'TS%', ORBp = 'ORB%', TOVp = 'TOV%', DRBp = 'DRB%', FGp = 'FG%', x3P = '3P', x3PA = '3PA', x3Pp = '3P%', x2P = '2P', x2PA = '2PA', x2Pp = '2P%', eFGp = 'eFG%', FTp = 'FT%')

## new "_per_game" in teams_stats

team_stats_transformed <- mutate(team_stats_transformed, 
                                   MP_per_game = MP/G,
                                   FG_per_game = FG/G,
                                   FGA_per_game = FGA/G,
                                   x3P_per_game = x3P/G,
                                   x3PA_per_game = x3PA/G, 
                                   x2P_per_game = x2P/G, 
                                   x2PA_per_game = x2PA/G, 
                                   FT_per_game = FT/G, 
                                   FTA_per_game = FTA/G, 
                                   ORB_per_game = ORB/G, 
                                   DRB_per_game = DRB/G, 
                                   TRB_per_game = TRB/G, 
                                   AST_per_game = AST/G, 
                                   STL_per_game = STL/G, 
                                   BLK_per_game = BLK/G, 
                                   TOV_per_game = TOV/G, 
                                   PF_per_game = PF/G, 
                                   PTS_per_game = PTS/G)

team_stats_clean <- team_stats_transformed %>% 
  mutate(across(where(is.numeric), ~ round(., 2)))

# Exploratory Analysis Script ----

## Load Packages ----
library (tidyverse) # load tidyverse
library(dplyr)
library(broom)

## Summarise player data ----

### Filter Player Stats by Starter Status ----

player_stats_starters <- filter(player_stats_clean, Starter == "Starter")

### Filter Player Stats by Player Positions ----

## filter players into positions to select a starting player from each position

#### Point Guards ----
player_stats_PG <- filter(player_stats_starters, Pos == "PG")

#### Shooting Guards ----
player_stats_SG <- filter(player_stats_starters, Pos == "SG")

#### Small Forwards ----
player_stats_SF <- filter(player_stats_starters, Pos == "SF")

#### Power Forwards ----
player_stats_PF <- filter(player_stats_starters, Pos == "PF")

#### Centres ----
player_stats_C <- filter(player_stats_starters, Pos == "C")

## check the distribution of variables ----

## points per game
ggplot(team_stats_clean, aes(PTS_per_game)) + 
  geom_histogram(fill = "dodgerblue", colour = "navy", bins = 15)

## total rebounds per game
ggplot(team_stats_clean, aes(TRB_per_game)) + 
  geom_histogram(fill = "dodgerblue", colour = "navy", bins = 15)

## assists per game
ggplot(team_stats_clean, aes(AST_per_game)) + 
  geom_histogram(fill = "dodgerblue", colour = "navy", bins = 15)

## steals per game
ggplot(team_stats_clean, aes(STL_per_game)) + 
  geom_histogram(fill = "dodgerblue", colour = "navy", bins = 15)

## blocks per game
ggplot(team_stats_clean, aes(BLK_per_game)) + 
  geom_histogram(fill = "dodgerblue", colour = "navy", bins = 15)

## Looking for correlations in team data ----

## Check team stats data for correlations between metrics and Games Won

## what team metrics are related to winning games of basketball?

## initial linear correlation between "_per_game" metrics and games won

## points per game
ggplot(team_stats_clean, aes(x = W, y = PTS_per_game)) + 
  geom_point(colour = "dodgerblue") + 
  labs(title = "Season wins by points per game", x = "Season Wins", y = "Points per game") + 
  geom_smooth(method = "lm", se = FALSE, colour = "magenta")

## assists per game
ggplot(team_stats_clean, aes(x = W, y = AST_per_game)) + 
  geom_point(alpha = 0.5, colour = "dodgerblue") + 
  labs(title = "Season wins by assists per game", x = "Season Wins", y = "Assists per game") + 
  geom_smooth(method = "lm", se = FALSE, colour = "magenta")

## total rebounds per game
ggplot(team_stats_clean, aes(x = W, y = TRB_per_game)) + 
  geom_point(alpha = 0.5, colour = "dodgerblue") + 
  labs(title = "Season wins by total rebounds per game", x = "Season Wins", y = "Rebounds per game") + 
  geom_smooth(method = "lm", se = FALSE, colour = "magenta")

## steals per game
ggplot(team_stats_clean, aes(x = W, y = STL_per_game)) + 
  geom_point(alpha = 0.5, colour = "dodgerblue") + 
  labs(title = "Season wins by steals per game", x = "Season Wins", y = "Steals per game") + 
  geom_smooth(method = "lm", se = FALSE, colour = "magenta")

## blocks per game
ggplot(team_stats_clean, aes(x = W, y = BLK_per_game)) +
  geom_point(alpha = 0.5, colour = "dodgerblue") + 
  labs(title = "Season wins by blocks per game", x = "Season Wins", y = "Blocks per game") + 
  geom_smooth(method = "lm", se = FALSE, colour = "magenta")

## turnovers per game
ggplot(team_stats_clean, aes(x = W, y = TOV_per_game)) + 
  geom_point(alpha = 0.5, colour = "dodgerblue") + 
  labs(title = "Season wins by turnovers per game", x = "Season Wins", y = "Turnovers per game") + 
  geom_smooth(method = "lm", se = FALSE, colour = "magenta")

## multiple linear regression
fit <- lm(W ~ PTS_per_game + AST_per_game + TRB_per_game + STL_per_game + BLK_per_game + TOV_per_game, data = team_stats_clean)
tidy(fit, conf.int = TRUE)

## Check for linearity 
car::avPlots(fit)

## Check for collinearity 
pairs(formula = ~ PTS_per_game + AST_per_game + TRB_per_game + STL_per_game + BLK_per_game + TOV_per_game, data = team_stats_clean)
car::vif(fit)
sqrt(car::vif(fit))

## we can surmise that there are a number of variables that are correlated to winning games of basketball

## PTS_per_game was highly correlated with an increase of 1.04 wins per season per 1 point increase scored per game.

## As other variables appear related, the "EFF" (individual player 'efficiency') score for individual players will be a good metric to use when selecting a starting five, as well as points per game (PTS_per_game) and using these variables to establish value metrics by dividing the player salary by both the EFF and PTS_per_game variables.

## Player correlations

## $/EFF
ggplot(player_stats_starters, aes(x = salary/1000000, y = EFF, colour = Pos)) + 
  geom_point() + 
  labs(x = "Efficiency", y = "Salary") + 
  geom_smooth(method = "lm", se = FALSE, colour = "magenta")

## $/PTS_per_game
ggplot(player_stats_starters, aes(x = salary/1000000, y = PTS_per_game, colour = Pos)) + 
  geom_point() + 
  labs(x = "Points per game", y = "Salary") + 
  geom_smooth(method = "lm", se = FALSE, colour = "magenta")

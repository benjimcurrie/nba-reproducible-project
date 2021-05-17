# Present Tables ----

## Present tables for each position based off of the key metrics
# 1. PTS_per_game
# 2. EFF 
# 3. dollars_per_EFF
# 4. dollars_per_PTS_per_game
# 5. salary

## Point Guard ----
PG_summary_table <- player_stats_PG %>%
  select(player_name, PTS_per_game, EFF, dollars_per_EFF, dollars_per_PTS_per_game, salary ) %>%
  arrange(desc(PTS_per_game), salary) %>%
  top_n(20)

## visualisation table for PG
kbl(PG_summary_table) %>%
  kable_paper("striped", full_width = F) %>%
  row_spec(1, bold = T, color = "white", background = "red")

## Shooting Guard ----
SG_summary_table <- player_stats_SG %>%
  select(player_name, PTS_per_game, EFF, dollars_per_EFF, dollars_per_PTS_per_game, salary ) %>%
  arrange(desc(PTS_per_game), salary) %>%
  top_n(20)

## visualisation table for SG
kbl(SG_summary_table) %>%
  kable_paper("striped", full_width = F) %>%
  row_spec(1, bold = T, color = "white", background = "red")

## Small Forward ----

SF_summary_table <- player_stats_SF %>%
  select(player_name, PTS_per_game, EFF, dollars_per_EFF, dollars_per_PTS_per_game, salary ) %>%
  arrange(desc(PTS_per_game), salary) %>%
  top_n(20)

## visualisation table for SF
kbl(SF_summary_table) %>%
  kable_paper("striped", full_width = F) %>%
  row_spec(3, bold = T, color = "white", background = "red")

## Power Forward ----

PF_summary_table <- player_stats_PF %>%
  select(player_name, PTS_per_game, EFF, dollars_per_EFF, dollars_per_PTS_per_game, salary ) %>%
  arrange(desc(PTS_per_game), salary) %>%
  top_n(20)

## visualisation table for PF
kbl(PF_summary_table) %>%
  kable_paper("striped", full_width = F) %>%
  row_spec(1, bold = T, color = "white", background = "red")

## Centre ----

C_summary_table <- player_stats_C %>%
  select(player_name, PTS_per_game, EFF, dollars_per_EFF, dollars_per_PTS_per_game, salary) %>%
  arrange(desc(PTS_per_game), salary) %>%
  top_n(20)

## visualisation table for C
kbl(C_summary_table) %>%
  kable_paper("striped", full_width = F) %>%
  row_spec(3, bold = T, color = "white", background = "red")

## Starting 5 ----

starting_5_table <- player_stats_starters %>%
  slice(c(37, 50, 54, 75, 76)) %>%
  select(Pos, player_name, salary, PTS_per_game, EFF, dollars_per_EFF, dollars_per_PTS_per_game)

print(starting_5_table)

## visualisation table for starting five
kbl(starting_5_table) %>%
  kable_paper("striped", full_width = F) %>%
  row_spec(1, bold = T, color = "white", background = "red") %>%
  row_spec(2, bold = T, color = "white", background = "black") %>%
  row_spec(3, bold = T, color = "white", background = "red") %>%
  row_spec(4, bold = T, color = "white", background = "black") %>%
  row_spec(5, bold = T, color = "white", background = "red")
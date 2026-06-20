# Installing packages
library(tidyverse)

# Loading data (filtered to include only UT and A&M system schools)
df <- read.csv("~/Downloads/UT AnM System Grad Rates.csv")

# adding marker to code which system a school is in
clean_df <- df |>
mutate(System = c("Texas A&M System", "UT System", "Texas A&M System",
                  "Texas A&M System", "Texas A&M System", "Texas A&M System",
                  "Texas A&M System", "Texas A&M System", "Texas A&M System",
                  "Texas A&M System", "Texas A&M System", "UT System", "UT System",
                  "UT System", "UT System", "UT System", "UT System", "UT System",
                  "UT System", "Texas A&M System",
                  "Texas A&M System", "UT System", "Texas A&M System",
                  "Texas A&M System", "Texas A&M System", "Texas A&M System",
                  "Texas A&M System", "Texas A&M System", "Texas A&M System",
                  "Texas A&M System", "Texas A&M System", "UT System", "UT System",
                  "UT System", "UT System", "UT System", "UT System", "UT System",
                  "UT System", "Texas A&M System",
                  "Texas A&M System", "UT System", "Texas A&M System",
                  "Texas A&M System", "Texas A&M System", "Texas A&M System",
                  "Texas A&M System", "Texas A&M System", "Texas A&M System",
                  "Texas A&M System", "Texas A&M System", "UT System", "UT System",
                  "UT System", "UT System", "UT System", "UT System", "UT System",
                  "UT System", "Texas A&M System", NA, NA, NA)) |>
# dropping N/A values
drop_na()

# viewing 4 year graduation rates across institution
int_4yr_grd_rt <- clean_df |>
  filter(ReportYear == max(ReportYear)) |>
  group_by(Institution, System) |>
  summarise(GradRate4yr)

# viewing average 4 year graduation rates across school system
sys_4yr_grd_rt <- clean_df |>
  filter(ReportYear == max(ReportYear)) |>
  group_by(System) |>
  summarise(mean(GradRate4yr))

# viewing 6 year graduation rates across institution
int_6yr_grd_rt <- clean_df |>
  filter(ReportYear == max(ReportYear)) |>
  group_by(Institution, System) |>
  summarise(GradRate6yr)

# viewing average 6 year graduation rates across school system
sys_6yr_grd_rt <- clean_df |>
  filter(ReportYear == max(ReportYear)) |>
  group_by(System) |>
  summarise(mean(GradRate6yr))

# viewing change between 4 year graduation rate across reporting year
inst_grd_rt_chng <- clean_df |>
  arrange(Institution) |>
  filter(ReportYear != median(ReportYear)) |>
  select(ReportYear, Institution, GradRate4yr, System) |>
  pivot_wider(names_from = ReportYear, values_from = GradRate4yr) |>
  mutate(percent_change = ((`2023` - `2021`) / `2021`) * 100)
  
# Plotting completion gap across 4-6 years by school system in most recent reporting year

# filtering by most recent reporting year and selecting relevant collumns
plot_df <- clean_df |>
  filter(ReportYear == max(ReportYear)) |>
  select(ReportYear, Institution, GradRate4yr, GradRate6yr, System) |>
  pivot_longer(cols = ends_with('yr'), names_to = 'TimeFrame', values_to = "Rate")

# Building plot
ggplot(plot_df, aes(x = Rate, y = reorder(Institution, Rate))) +
  geom_line(aes(color = System), linewidth = 0.75) +
  geom_point(aes(color = System), size = 3) +
  scale_color_manual(values = c('Texas A&M System' = '#500000', 'UT System' = '#BF5700')) +
  theme_minimal() +
  theme(legend.position = "bottom",
        plot.title = element_text(face = "bold")) +
  labs(
    title = "How Graduation Rates Climb After Year 4",
    subtitle = "Comparison of 4-year and 6-year graduation rates across UT and A&M systems (2023 Reporting Year)",
    x = "Graduation Rate
    (Left points show 4-year rate, right points show 6-year rate)",
    y = NULL,
    color = NULL
  )

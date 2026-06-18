#How Graduation Rates Climb After Year 4

A data journalism piece produced as a tryout submission for *The Daily Texan*, comparing 4-year and 6-year graduation rates across UT System and Texas A&M System institutions using IPEDS data, Excel, and R.

---

## Overview

Most federal financial aid and merit scholarships are designed around a 4-year degree timeline — but how many students at Texas public universities actually finish on time? This project visualizes the gap between 4-year and 6-year graduation rates across all UT and A&M system schools, revealing which institutions see the biggest jumps after year four and which systems perform best overall.

---

## Dataset

- **Source:** IPEDS (Integrated Postsecondary Education Data System) — Texas University Graduation Rates
- **Scope:** UT System and Texas A&M System institutions across multiple reporting years (2021–2023)
- **Key variables:**
  - `Institution` — school name
  - `ReportYear` — reporting year
  - `GradRate4yr` — 4-year graduation rate
  - `GradRate6yr` — 6-year graduation rate

---

## Key Findings

- **The UT System outperforms the A&M System overall.** In the most recent reporting year (2023), UT System schools averaged a 43.3% 4-year graduation rate and 63.3% 6-year rate, compared to A&M System schools' 31.8% and 54.5%, respectively.
- **Texas A&M University-San Antonio had the lowest 6-year graduation rate** at 30%, and tied with Prairie View A&M, Texas A&M-Texarkana, and UT El Paso for the lowest 4-year rate at 20%.
- **The lowest-performing UT System school** was UT El Paso, with a 20% 4-year rate and 50% 6-year rate.
- **4-year rates were largely static** across reporting years — only two schools saw change: Texas A&M-Texarkana dropped 20% from 2021 to 2023, while UT Rio Grande Valley rose 33.3%. UT San Antonio was excluded from trend analysis due to missing 2021 data.

---

## Methodology

### 1. Data Filtering (Excel)
The raw IPEDS dataset was scanned, filtered, and sorted in Excel to include only institutions within the UT and Texas A&M systems.

### 2. Feature Engineering (R)
After importing the filtered CSV, a `System` column was manually added using `mutate()` to tag each institution as either `"UT System"` or `"Texas A&M System"`. Rows with `NA` system labels were dropped with `drop_na()`.

### 3. Analysis (R / tidyverse)
Four summary analyses were run on the cleaned data:
- 4-year and 6-year graduation rates by institution (most recent year)
- Average 4-year and 6-year rates by school system (most recent year)
- Year-over-year change in 4-year rates using `pivot_wider()` across oldest and most recent reporting years

> UT San Antonio was omitted from trend analysis entirely due to missing 2021 data. Rather than impute with a mean or median, the school was excluded to preserve the integrity of the comparison.

### 4. Visualization (ggplot2)
A connected dot plot (dumbbell chart) was built using `ggplot2`, with the left point representing the 4-year rate and the right point the 6-year rate. Schools are sorted by graduation rate and colored by system using official brand colors.

```r
scale_color_manual(values = c('Texas A&M System' = '#500000', 'UT System' = '#BF5700'))
```

---

## Visualization

<img width="2940" height="1782" alt="image" src="https://github.com/user-attachments/assets/3ca9db59-3997-4f5e-8ad7-5551da3332dc" />


> *Each line connects a school's 4-year (left) and 6-year (right) graduation rate. Longer lines indicate a larger jump after year four.*

---

## Why It Matters

Most scholarships and federal financial aid programs are structured around a 4-year timeline. Attending a school where most students take 5 or 6 years to graduate can add thousands of dollars in unplanned tuition, housing, and opportunity costs. Understanding which schools have low 4-year rates raises important questions about how well institutions are supporting their students toward timely completion.

---

## Requirements

- R (≥ 4.0)
- `tidyverse`

```r
install.packages("tidyverse")
```

---

## Files

```
├── Daily_Texan_Tryout.R                  # Data cleaning, analysis, and visualization script
├── Texas_University_Graduation_Rates.xlsx # Source data (filtered in Excel)
└── README.md
```

---

## Author

Produced as a data journalism tryout submission for *The Daily Texan*. Built as part of a data science portfolio.

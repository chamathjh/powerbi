# Analysis of New Work Permit Issuance Data (2022–2024)

This repository contains an analysis of **new work permit issuance data** (excluding extensions) from January 2022 to November 2024, based on publicly available data from [Migrationsverket](https://www.migrationsverket.se/English/About-the-Migration-Agency/Current-topics/Increased-maintenance-requirement-for-work-permits.html). The analysis highlights the **impact of a new law** introduced on **November 1, 2023**, which raised the salary threshold for work permits in Sweden.

---

## Key Insights

### Impact of the Law Change (November 1, 2023)
- **Salary Threshold Change**: Increased to **80% of the median salary**, equivalent to:
  - **SEK 27,360** (2023 initial threshold based on SEK 34,200 median).
  - **SEK 28,480** (2024 threshold based on SEK 35,600 median).
- **Decline in New Work Permits Issued**:
  - **Pre-November 2023 average**: **1,960 permits per month** (January 2022–October 2023).
  - **Post-November 2023 average**: **1,129 permits per month** (November 2023 onwards).

### Professions with the Most Permits (Jan 2022–Nov 2024)
- **Seasonal Workers (Berry Pickers, Planters)**: 13,000 permits (22.7%).
- **IT Architects, System Developers**: 11,000 permits (19.3%).
- **Engineers**: 9,000 permits (16%).

### Nationals with the Most Permits (Jan 2022–Nov 2024)
- **Thailand** (primarily for seasonal work): Most permits overall.
- **India, China, Turkey, and Iran** also received a significant share of permits.

### Year-on-Year Changes: Pre- and Post-Law Change
1. **Biggest Decline in Professions**:
   - **Berry Pickers and Planters**: **-3,873 permits**.
   - **IT Architects, System Developers**: **-955 permits**.
   - **Fast Food Workers**: **-503 permits**.
   - **Cleaners and Home Service**: **-346 permits**.
   - **Cooks and Kitchen Assistants**: **-246 permits**.

2. **Regional Trends**:
   - **Asian Nationals Most Affected**:
     - **Thai Nationals**: 61% drop (-3,908 permits).
     - **Indian Nationals**: 23% drop (-962 permits).
     - **Iranian Nationals**: 33% drop (-245 permits).
     - **Turkish Nationals**: 19% drop (-165 permits).
     - **Iraqi Nationals**: 62% drop (-155 permits).

3. **Janitorial and Restaurant Professions**:
   - Pre-November 2023: Combined monthly average **193 permits**.
   - Post-November 2023: Combined monthly average **77 permits**.

---

## Data Sources

1. **Data Source**:
   - Data was obtained from the official [Migrationsverket statistics page](https://www.migrationsverket.se/Om-Migrationsverket/Statistik/Arbete.html).

2. **Data Period**:
   - January 2022 to November 2024 (current).
   - Focused on **new work permits only** (excludes permit renewals).

---

## Data Processing

### Tools Used:
- **Excel Power Query**:
  - Cleaned and organized the raw data.
  - Combined time-series data from separate files into a single dataset.
- **AI Translation**:
  - Translated data into English.
  - Ensured consistency by using **VLOOKUP** to align translations across datasets.
- **Manual Data Correction**:
  - Fixed inaccuracies in naming (e.g., "St. Kitts" → "Saint Kitts").

### Analysis & Visualization:
- **Power BI**:
  - Imported cleaned data into Power BI.
  - Created relevant measures, grouped data, and used **DAX expressions** for deeper analysis.
  - Designed interactive visualizations to explore trends and insights.

---

## Disclaimer

This analysis was conducted for personal use and educational purposes. Users are encouraged to refer to the original data sources and perform their own validation before drawing any conclusions.

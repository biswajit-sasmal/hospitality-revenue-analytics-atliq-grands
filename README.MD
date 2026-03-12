# 🏨 AtliQ Grands — Hospitality Revenue Analytics

<p align="center">
  <img src="resources/mock up dashboard_atliq grands.png" alt="AtliQ Grands Dashboard" width="80%"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Domain-Hospitality-blue?style=for-the-badge&logo=hotel&logoColor=white"/>
  <img src="https://img.shields.io/badge/SQL-Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white"/>
  <img src="https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black"/>
  <img src="https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white"/>
  <img src="https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Timeline-May–July%202022-orange?style=flat-square"/>
  <img src="https://img.shields.io/badge/Properties-15%2B%20Hotels-blueviolet?style=flat-square"/>
  <img src="https://img.shields.io/badge/SQL%20Queries-21%20Business%20Questions-informational?style=flat-square"/>
  <img src="https://img.shields.io/badge/Reports-20%20CSV%20Files-success?style=flat-square"/>
</p>

---

> **Domain:** Hospitality | **Tools:** SQL Server · Power BI | **Timeline:** May – July 2022

---

## 📌 Project Overview
AtliQ Grands is a luxury & Business hotel chain operating **20+ five-star properties** across India.
This project analyzes **3 months of historical booking data** to uncover revenue loss,
occupancy trends, cancellation patterns, and ADR/RevPAR performance across all properties.

---

## ❗ Problem Statement
AtliQ Grands are losing **market share and revenue** in the luxury/business hotel segment
due to competitor strategies and weak data-driven decision-making.
The revenue management team hired a 3rd party analytics provider to extract insights
from historical data and guide future strategy.

---

## ✅ Project Tasks
| # | Task |
|---|------|
| 1 | Exploratory Data Analysis (EDA) — data quality, nulls, duplicates |
| 2 | 21 business questions answered using SQL |
| 3 | Exported all query results as CSV reports |
| 4 | Built an interactive Power BI dashboard |
| 5 | Delivered a management presentation with key insights |

---

## 🛠️ Tools & Technology
| Tool | Purpose |
|------|---------|
| SQL Server | Data exploration & business analysis queries |
| Power BI | Interactive dashboard & data visualization |
| Excel | Metrics reference & quick data checks |
| Git & GitHub | Version control & project sharing |

---

## 📁 Project File Structure
```
hospitality-revenue-analytics-atliq-grands/
│
├── README.md
│
├── dataset/                                              → Raw input data files
│   ├── dim_date.csv                                      → Calendar table (May–July 2022)
│   ├── dim_hotels.csv                                    → Hotel master list
│   ├── dim_rooms.csv                                     → Room type mapping
│   ├── fact_bookings.csv                                 → Individual booking records
│   ├── fact_aggregated_bookings.csv                      → Daily room summary data
│   ├── metrics list.xlsx                                 → KPI reference sheet
│   └── meta_data_hospitality.txt                         → Column descriptions
│
├── sql_queries/                                          → All SQL scripts
│   ├── AtliQ_Grands_Hotel_Bookings_eda.sql               → Data quality checks
│   └── AtliQ_Grands_Revenue_Analysis.sql                 → 21 business questions
│
├── report_files/                                         → SQL query outputs (CSV)
│   ├── top_level_revenue_breakdown_report.csv
│   ├── city_wise_revenue_breakdown_report.csv
│   ├── property_wise_revenue_breakdown_report.csv
│   ├── property_wise_all_metrics_full_report.csv
│   ├── property_wise_successfull_bookings_breakdown_report.csv
│   ├── property_wise_cancellation_breakdown_report.csv
│   ├── property_wise_realisation_breakdown_report.csv
│   ├── property_wise_occupancy_breakdown_report.csv
│   ├── property_wise_ADR_breakdown_report.csv
│   ├── property_wise_RevPAR_breakdown_report.csv
│   ├── property_category_wise_revenue_breakdown_report.csv
│   ├── property_category_wise_rating_breakdown_report.csv
│   ├── hotel_room_class_wise_occupancy_breakdown_report.csv
│   ├── hotel_room_category_wise_ADR_breakdown_report.csv
│   ├── city_most_popular_room_category_report.csv
│   ├── bookings_platform_wise_cancellation_breakdown_report.csv
│   ├── weekend_vs_weekday_occupancy_breakdown_report.csv
│   ├── weekend_vs_weekday_successfull_bookings_breakdown_report.csv
│   ├── monthly_revenue_trend_breakdown_report.csv
│   └── weekly_successfull_bookings_trend_report.csv
│
├── powerbi_reports/                                      → Power BI files
│   ├── AtliQ_Grands_Hotel_Revenue_Analysis_PowerBI_Report.pbix
│   └── report_screenshots/
│       ├── 01_home_page.pdf
│       ├── 02_revenue_analysis_page.pdf
│       └── powerbi_semantic_data_model.png
│
├── presentation/
│   └── AtliQ Grands Hotel Revenue Analysis Presentation.pptx
│
└── resources/
    └── mock up dashboard_atliq grands.png
```

---

## ▶️ How to Run This Project

**Step 1 — Create the Database:**
```sql
CREATE DATABASE AtliQ_Hotel_Bookings_DB;
USE AtliQ_Hotel_Bookings_DB;
```

**Step 2 — Load the Data:**
1. Open SQL Server Management Studio (SSMS)
2. Right-click `AtliQ_Hotel_Bookings_DB` → Tasks → Import Flat File
3. Import all 5 CSV files from `dataset/` folder one by one

**Step 3 — Run SQL Queries:**
1. Run `AtliQ_Grands_Hotel_Bookings_eda.sql` first — checks data quality
2. Run `AtliQ_Grands_Revenue_Analysis.sql` — answers 21 business questions

**Step 4 — Open Power BI Dashboard:**
1. Open `.pbix` file from `powerbi_reports/` in Power BI Desktop
2. Update data source connection to your local `dataset/` folder
3. Click **Refresh** to reload all data

---

## 📊 Live Power BI Dashboard
🔗 **[View Live Dashboard →](https://app.powerbi.com/view?r=eyJrIjoiNjlkOTgwNjQtODJlMS00NzBmLWI2MjEtZjMxOWQ2OGFhNjg2IiwidCI6ImJmOGY3NjI3LTQ2MmQtNGFhMC1iMWVlLWNhMzc5ZDlhZTA3OCJ9)**


---

## 🙏 Acknowledgements
- **Dataset & Project Idea:** [Codebasics](https://codebasics.io) — Resume Project Challenge
- **Project Link**: [AtliQ Grands Hospitality Revenue Insights](https://codebasics.io/challenges/codebasics-resume-project-challenge/4)
- **Domain Guidance:** Hospitality Revenue Management concepts (RevPAR, ADR, Occupancy %)
- **Mentor Support:** Codebasics Community & Mentors

---

## 🤝 Connect With Me

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/biswajitsasmal/)
[![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:biswajitsasmal.data@gmail.com)

> 💬 *Feel free to reach out for feedback, collaboration, or just to connect!*

---

## ⭐ Thank You!

```
If you found this project helpful or interesting,
please consider giving it a ⭐ on GitHub —
it genuinely means a lot and motivates me
to keep building and sharing more projects like this!

Thank you for stopping by! 🙌
```

---
*© 2026 · Built with ❤️ by BISWAJIT SASMAL*
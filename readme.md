ETL Pipeline Bash Project

This project demonstrates an ETL (Extract, Transform, Load) pipeline using Bash scripts.
It automates the process of downloading a dataset, transforming it into a clean structure, loading it into a final directory, scheduling the pipeline with cron, and organizing CSV/JSON outputs.

📂 Project Structure
bash_assignment/
│── raw/
│   │── etl_pipeline.sh          # Main ETL pipeline script
│   │── etl_schedule.sh          # Script for scheduling with cron
│   │── move_files.sh            # Script to organize CSV/JSON files
│   │── enterprise_survey.csv    # Raw data (downloaded)
│   │── Transformed/
│   │   └── 2023_year_finance.csv
│   │── Gold/
│   │   └── 2023_year_finance.csv
│── json_and_CSV/                # Stores moved CSV and JSON files

ETL Workflow Visualization
flowchart LR
    A[Extract: Download CSV from URL] --> B[Transform: Select columns<br>year, Value, Units, variable_code]
    B --> C[Load: Copy cleaned data<br>to Gold directory]
    C --> D[Schedule: Automate with cron job]
    B --> E[Organize: Move CSV/JSON<br>to json_and_CSV folder]

 1. ETL Pipeline (etl_pipeline.sh)

This script performs the full ETL process:

Extract – Downloads a CSV file from Statistics New Zealand.

Transform – Selects relevant columns (year, Value, Units, variable_code) and writes them into a new CSV.

Load – Copies the transformed file into the Gold directory for final storage.

Run manually
bash /Users/micahonyedikachitobias/Desktop/bash_assignment/raw/etl_pipeline.sh

⏱ 2. Automating with Cron (etl_schedule.sh)

This script makes the ETL pipeline executable and sets up a cron job to run it daily at midnight.

Steps

Make the ETL script executable:

chmod +x /Users/micahonyedikachitobias/Desktop/bash_assignment/raw/etl_pipeline.sh


Open crontab editor:

crontab -e


Add the job (runs every day at midnight):

0 0 * * * /Users/micahonyedikachitobias/Desktop/bash_assignment/raw/etl_pipeline.sh >> /Users/micahonyedikachitobias/Desktop/bash_assignment/raw/etl_pipeline.log 2>&1


Logs are stored in:

etl_pipeline.log

📦 3. Organizing Files (move_files.sh)

This script moves all CSV and JSON files from the Transformed directory into a dedicated json_and_CSV folder for better organization.

Run manually
bash /Users/micahonyedikachitobias/Desktop/bash_assignment/raw/move_files.sh


The script:

Creates the destination folder if it doesn’t exist.

Moves all .csv and .json files.

Prints confirmation for each moved file.

⚙️ Requirements

Bash shell (Linux or macOS, WSL on Windows).

wget for file download.

cron for scheduling.
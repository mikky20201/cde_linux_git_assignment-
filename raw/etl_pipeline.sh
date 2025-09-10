#!/bin/bash

# ETL PIPELINE SCRIPT

# ENVIRONMENT VARIABLES
URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"
RAW_DIR="/Users/micahonyedikachitobias/Desktop/bash_assignment/raw"
TRANSFORMED_DIR="/Users/micahonyedikachitobias/Desktop/bash_assignment/raw/Transformed"
GOLD_DIR="/Users/micahonyedikachitobias/Desktop/bash_assignment/raw/Gold"
TRANSFORMED_FILE="2023_year_finance.csv"

# STEP 1: EXTRACT
mkdir -p "$RAW_DIR" "$TRANSFORMED_DIR" "$GOLD_DIR"

echo "Step 1: Downloading file..."
wget -q -O "$RAW_DIR/enterprise_survey.csv" "$URL"

if [ -f "$RAW_DIR/enterprise_survey.csv" ]; then
    echo "File successfully downloaded to $RAW_DIR"
else
    echo "Failed to download file from $URL"
    exit 1
fi

# STEP 2: TRANSFORM
echo "Step 2: Transforming file..."

# Detect column numbers
COLS=$(head -1 "$RAW_DIR/enterprise_survey.csv" \
    | sed 's/Variable_code/variable_code/' \
    | awk -F, '{
        for (i=1;i<=NF;i++) {
            if ($i=="year") y=i
            if ($i=="Value") v=i
            if ($i=="Units") u=i
            if ($i=="variable_code") vc=i
        }
        print y "," v "," u "," vc
    }')

# Write header manually to ensure correct order
echo "year,Value,Units,variable_code" > "$TRANSFORMED_DIR/$TRANSFORMED_FILE"

# Extract selected columns
tail -n +2 "$RAW_DIR/enterprise_survey.csv" \
    | cut -d',' -f$COLS >> "$TRANSFORMED_DIR/$TRANSFORMED_FILE"

if [ -f "$TRANSFORMED_DIR/$TRANSFORMED_FILE" ]; then
    echo "Transformation done"
fi

# STEP 3: LOAD
echo "Step 3: Loading data into Gold directory..."
cp "$TRANSFORMED_DIR/$TRANSFORMED_FILE" "$GOLD_DIR/"

if [ -f "$GOLD_DIR/$TRANSFORMED_FILE" ]; then
    echo "File loaded into $GOLD_DIR"
fi

echo "Process completed."

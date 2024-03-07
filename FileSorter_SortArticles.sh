#!/bin/bash

# Directory where sorted articles are stored
article_directory= "/Users/jreback/Library/CloudStorage/GoogleDrive-jmreback@gmail.com/My Drive/Hesperia Report- Resources/articles"

# Sub-directories for each category
mkdir -p "${article_directory}/1_Introduction_Overview_General_Laws"
mkdir -p "${article_directory}/2_Geospatial_Awareness"
mkdir -p "${article_directory}/3_Spotlight_on_Hesperia"
mkdir -p "${article_directory}/4_Valuation_Trendlines"
mkdir -p "${article_directory}/5_Proposition_19/Laws"
mkdir -p "${article_directory}/5_Proposition_19/Regulations"
mkdir -p "${article_directory}/5_Proposition_19/Other"

# Function to categorize a single article
categorize_article() {
    local article="$1"
    local content=$(cat "$article")

    # Simple keyword-based categorization logic
    if grep -qiE 'introduction|overview|general laws' <<< "$content"; then
        mv "$article" "${article_directory}/1_Introduction_Overview_General_Laws/"
    elif grep -qi 'California|SoCal' <<< "$content"; then
        mv "$article" "${article_directory}/2_Geospatial_Awareness/"
    elif grep -qi 'Hesperia' <<< "$content"; then
        mv "$article" "${article_directory}/3_Spotlight_on_Hesperia/"
    elif grep -qi 'valuation|trendlines' <<< "$content"; then
        mv "$article" "${article_directory}/4_Valuation_Trendlines/"
    elif grep -qi 'Proposition 19' <<< "$content"; then
        # Further classification for Proposition 19 articles
        if grep -qi 'law|code' <<< "$content"; then
            mv "$article" "${article_directory}/5_Proposition_19/Laws/"
        elif grep -qi 'regulation|policy' <<< "$content"; then
            mv "$article" "${article_directory}/5_Proposition_19/Regulations/"
        else
            mv "$article" "${article_directory}/5_Proposition_19/Other/"
        fi
    else
        echo "Article '$article' does not match any category."
        # Optionally move or handle unclassified articles
    fi
}

# Loop through each article in the directory
for article in "${article_directory}"/*; do
    # Skip directories
    if [[ -d "$article" ]]; then continue; fi

    categorize_article "$article"
done

echo "Articles have been categorized."

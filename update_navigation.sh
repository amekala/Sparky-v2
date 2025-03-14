#!/bin/bash

# List of all HTML files to update
HTML_FILES=(
    "evaluate_stage_mock.html"
    "learn_stage_mock.html"
    "post_transaction_stage_mock.html"
    "innovative_format_1_sponsored_followups.html"
    "innovative_format_2_interactive_comparison.html"
    "innovative_format_3_conversational_brand_personas.html"
    "innovative_format_4_immersive_experiences.html"
    "future_ad_formats_report.html"
    "innovative_ad_formats_overview.html"
)

for file in "${HTML_FILES[@]}"; do
    echo "Processing $file"
    
    # Extract the page title from the filename
    filename=$(basename "$file" .html)
    page_title=$(echo "$filename" | sed 's/_/ /g' | sed 's/\b\(.\)/\u\1/g' | sed 's/Mock//g')
    
    # Create a temporary file for processing
    temp_file="${file}.tmp"
    
    # Read the file line by line and make changes
    while IFS= read -r line; do
        # Replace hamburger menu with back arrow
        if [[ $line == *'<span class="nav-menu">☰</span>'* ]]; then
            echo "        <a href=\"index.html\" class=\"back-arrow\">←</a>" >> "$temp_file"
            # Add the page title after the back arrow
            echo "        Sparky - $page_title" >> "$temp_file"
        # Skip the navigation div and its contents
        elif [[ $line == *'<div class="overlay"></div>'* ]] || 
             [[ $line == *'<div class="navigation">'* ]] || 
             [[ $line =~ '<div class="nav-header">' ]] || 
             [[ $line =~ '<span>Sparky Menu</span>' ]] || 
             [[ $line =~ '<span class="nav-close">' ]] || 
             [[ $line =~ '<ul class="nav-links">' ]] || 
             [[ $line =~ '<li><a href=' ]] || 
             [[ $line =~ '</ul>' ]] || 
             [[ $line =~ '</div>' && $(grep -A 1 '<div class="navigation">' "$file" | grep -c "$line") -eq 1 ]]; then
            # Skip these lines
            continue
        # Replace sponsored tags with standardized format
        elif [[ $line == *'<span class="sponsored-tag">'* ]]; then
            echo '                <span class="sponsored-label">Sponsored Ad</span>' >> "$temp_file"
        else
            # Keep the line as is
            echo "$line" >> "$temp_file"
        fi
    done < "$file"
    
    # Replace the original file with the temporary file
    mv "$temp_file" "$file"
    
    echo "Updated $file"
done

echo "All files have been updated with the new navigation, page titles, and standardized sponsored labels!" 
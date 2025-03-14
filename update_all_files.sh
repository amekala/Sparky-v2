#!/bin/bash

# List of HTML files to update
HTML_FILES=(
    "evaluate_stage_mock.html"
    "learn_stage_mock.html"
    "post_transaction_stage_mock.html"
    "innovative_format_1_sponsored_followups.html"
    "innovative_format_2_interactive_comparison.html"
    "innovative_format_3_conversational_brand_personas.html"
    "innovative_format_4_immersive_experiences.html"
)

# Navigation HTML to insert
NAV_HTML='<div class="overlay"></div>
        <div class="navigation">
            <div class="nav-header">
                <span>Sparky Menu</span>
                <span class="nav-close">&times;</span>
            </div>
            <ul class="nav-links">
                <li><a href="index.html">Home</a></li>
                <li><a href="explore_stage_mock.html">Explore Stage</a></li>
                <li><a href="learn_stage_mock.html">Learn Stage</a></li>
                <li><a href="evaluate_stage_mock.html">Evaluate Stage</a></li>
                <li><a href="buy_stage_mock.html">Buy Stage</a></li>
                <li><a href="post_transaction_stage_mock.html">Post-Transaction Stage</a></li>
                <li><a href="innovative_format_1_sponsored_followups.html">Sponsored Followups</a></li>
                <li><a href="innovative_format_2_interactive_comparison.html">Interactive Comparison</a></li>
                <li><a href="innovative_format_3_conversational_brand_personas.html">Brand Personas</a></li>
                <li><a href="innovative_format_4_immersive_experiences.html">Immersive Experiences</a></li>
            </ul>
        </div>'

# Script to add to body
SCRIPT_TAG='<script src="js/main.js"></script>'

for file in "${HTML_FILES[@]}"; do
    echo "Processing $file"
    
    # Add CSS link if missing
    if ! grep -q '<link rel="stylesheet" href="css/styles.css">' "$file"; then
        sed -i '' 's/<title>.*<\/title>/<title>&<\/title>\n    <link rel="stylesheet" href="css\/styles.css">/' "$file"
    fi
    
    # Add navigation menu
    if ! grep -q '<div class="navigation">' "$file"; then
        sed -i '' 's/<div class="container">/<div class="container">\n        '"$NAV_HTML"'/' "$file"
    fi
    
    # Add menu toggle to header
    if ! grep -q '<span class="nav-menu">' "$file"; then
        sed -i '' 's/<div class="header">/<div class="header">\n            <span class="nav-menu">☰<\/span>/' "$file"
    fi
    
    # Add script tag if missing
    if ! grep -q '<script src="js/main.js">' "$file"; then
        sed -i '' 's/<\/body>/    '"$SCRIPT_TAG"'\n<\/body>/' "$file"
    fi
    
    echo "Updated $file"
done

echo "All files have been updated!" 
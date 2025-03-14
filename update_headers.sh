#!/bin/bash

# List of files to update
FILES=(
  "evaluate_stage_mock.html"
  "learn_stage_mock.html"
  "post_transaction_stage_mock.html"
  "innovative_format_1_sponsored_followups.html"
  "innovative_format_2_interactive_comparison.html"
  "innovative_format_3_conversational_brand_personas.html"
  "innovative_format_4_immersive_experiences.html"
)

# Loop through each file
for file in "${FILES[@]}"; do
  echo "Updating $file..."
  
  # Extract the title from the filename
  title=$(echo "$file" | sed 's/\.html$//' | sed 's/_/ /g' | sed 's/\b\(.\)/\u\1/g')
  
  # Replace the header content with back arrow and page title
  sed -i '' '/<div class="header">/,/<\/div>/c\
        <div class="header">\
            <a href="index.html" class="back-arrow">←</a>\
            <h1 class="page-title">Sparky - '"$title"'</h1>\
        </div>' "$file"
  
  echo "Updated $file"
done

echo "All files updated successfully!" 
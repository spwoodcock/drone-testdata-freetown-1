#!/bin/bash

# Delete specific images to create coverage gaps
# Reads from images_to_delete.txt

DELETE_LIST="images_to_delete.txt"

if [[ ! -f "$DELETE_LIST" ]]; then
    echo "Error: $DELETE_LIST not found"
    exit 1
fi

echo "Images to be deleted:"
grep -v '^#' "$DELETE_LIST" | grep -v '^$'
echo ""

read -p "Proceed with deletion? (y/n): " confirm

if [[ "$confirm" == "y" ]]; then
    while IFS= read -r filepath; do
        # Skip comments and empty lines
        [[ "$filepath" =~ ^#.*$ ]] && continue
        [[ -z "$filepath" ]] && continue
        
        if [[ -f "$filepath" ]]; then
            rm "$filepath"
            echo "Deleted: $filepath"
        else
            echo "Not found: $filepath"
        fi
    done < "$DELETE_LIST"
    
    echo ""
    echo "Deletion complete"
else
    echo "Deletion cancelled"
fi

#!/bin/bash

# Change directory to /etc/profile.d
cd /etc/profile.d

# Flag to keep track of whether any files have been updated
updated=false

# Iterate over each file with .sh or .csh extension
for file in *.sh *.csh; do
    # Check if the file contains a umask setting
    if grep -q "umask" "$file"; then
        # Check if umask is compliant (umask 027)
        if ! grep -q "umask 027" "$file"; then
            # Update the file with compliant umask setting
            echo "Updating $file..."
            echo "umask 027" >> "$file"
            echo "$file has been updated to compliant umask setting"
            updated=true
        fi
    else
        # Add umask setting if not present
        echo "Adding umask setting to $file..."
        echo "umask 027" >> "$file"
        echo "umask setting added to $file"
        updated=true
    fi
done

# If no files were updated
if ! $updated; then
    echo "All files are compliant"
fi

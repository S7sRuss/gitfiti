# Full git commit script with 50% chance and multiple file types
# For every day randomly since 2011

START_DATE="2023-10-04"
END_DATE=$(date -I)

# Convert dates to seconds since epoch for easier calculation
START_EPOCH=$(date -d "$START_DATE" +%s)
END_EPOCH=$(date -d "$END_DATE" +%s)

# Calculate total days

TOTAL_DAYS=$(( (END_EPOCH - START_EPOCH) / 86400 ))

# Array of file types and extensions
FILE_TYPES=("java" "js" "py" "cpp" "go" "rs" "ts" "php" "rb" "swift")
FILE_NAMES=("Main" "App" "Utils" "Helper" "Service" "Controller" "Model" "Config" "Test" "Handler")



for i in $(seq 0 $TOTAL_DAYS); do
    # Calculate the date for this iteration
    CURRENT_DATE=$(date -I -d "$START_DATE + $i days")
    
    # Using modulo 100 for exact percentage
    if [ $((RANDOM % 100)) -lt 30 ]; then
        echo "$CURRENT_DATE - Daily update"
        
        # Randomly select file type and name
        FILE_EXT=${FILE_TYPES[$((RANDOM % ${#FILE_TYPES[@]}))]}
        FILE_NAME=${FILE_NAMES[$((RANDOM % ${#FILE_NAMES[@]}))]}
        FILENAME="${FILE_NAME}.${FILE_EXT}"
        
        # Create different types of "code" content based on file type
        case $FILE_EXT in
            "java")
                echo "// Updated on $CURRENT_DATE" >> $FILENAME
                echo "public class $FILE_NAME {" >> $FILENAME
                echo "    // TODO: Implement functionality" >> $FILENAME
                echo "}" >> $FILENAME
                ;;
            "js")
                echo "// Updated on $CURRENT_DATE" >> $FILENAME
                echo "function ${FILE_NAME,,}() {" >> $FILENAME
                echo "    // TODO: Add implementation" >> $FILENAME
                echo "}" >> $FILENAME
                ;;
            "py")
                echo "# Updated on $CURRENT_DATE" >> $FILENAME
                echo "def ${FILE_NAME,,}():" >> $FILENAME
                echo "    # TODO: Add implementation" >> $FILENAME
                echo "    pass" >> $FILENAME
                ;;
            "cpp")
                echo "// Updated on $CURRENT_DATE" >> $FILENAME
                echo "#include <iostream>" >> $FILENAME
                echo "// TODO: Implement $FILE_NAME" >> $FILENAME
                ;;
            "go")
                echo "// Updated on $CURRENT_DATE" >> $FILENAME
                echo "package main" >> $FILENAME
                echo "// TODO: Implement $FILE_NAME" >> $FILENAME
                ;;
            *)
                echo "// Updated on $CURRENT_DATE" >> $FILENAME
                echo "// TODO: Implement $FILE_NAME functionality" >> $FILENAME
                ;;
        esac
        
        # Also update activity log
        echo "$CURRENT_DATE - Updated $FILENAME" >> activity.log
        
        git add $FILENAME activity.log
        git commit -m "Update $FILENAME for $CURRENT_DATE" --date="$CURRENT_DATE"
    fi
done

# Add commit for today
TODAY=$(date -I)
echo "# Project updated on $TODAY" > README.md
git add README.md
git commit -m "Update project for $TODAY" --date="$TODAY"

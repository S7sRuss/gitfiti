# Full of git commit -a -m "update streak for `date -I -d "$DATE"`" --date="$DATE"
# For every day randomly since 2011

START_DATE="2023-09-14"
END_DATE=$(date -I)

# Convert dates to seconds since epoch for easier calculation
START_EPOCH=$(date -d "$START_DATE" +%s)
END_EPOCH=$(date -d "$END_DATE" +%s)

# Calculate total days
TOTAL_DAYS=$(( (END_EPOCH - START_EPOCH) / 86400 ))

for i in $(seq 0 $TOTAL_DAYS); do
    # Calculate the date for this iteration
    CURRENT_DATE=$(date -I -d "$START_DATE + $i days")
    
    # Randomly decide whether to make a commit (50% chance)
   if [ $((RANDOM % 2)) -eq 0 ]; then
        echo "$CURRENT_DATE - Daily update" >> activity.log
        git add .
        git commit -m "update streak for $CURRENT_DATE" --date="$CURRENT_DATE"
    fi
done

# Add commit for today
TODAY=$(date -I)
git commit -a -m "update streak for $TODAY" --date="$TODAY"

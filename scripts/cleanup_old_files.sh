  #!/bin/bash
  TARGET_DIR=${CLEANUP_DIR:-/tmp}
  DAYS=${CLEANUP_DAYS:-7}
  OUTPUT_FILE="reports/cleanup.txt"

  echo "=== Cleanup Old Files ===" > $OUTPUT_FILE
  echo "Directory : $TARGET_DIR" >> $OUTPUT_FILE
  echo "Older than: $DAYS days" >> $OUTPUT_FILE
  echo "" >> $OUTPUT_FILE

  FILES=$(find "$TARGET_DIR" -maxdepth 1 -type f -mtime +$DAYS 2>/dev/null)

  if [ -z "$FILES" ]; then
    echo "No files to clean up." >> $OUTPUT_FILE
  else
    echo "$FILES" >> $OUTPUT_FILE
    find "$TARGET_DIR" -maxdepth 1 -type f -mtime +$DAYS -delete 2>/dev/null
    echo "Files deleted." >> $OUTPUT_FILE
  fi
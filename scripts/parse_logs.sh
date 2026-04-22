  #!/bin/bash
  LOG_FILE=${LOG_PATH:-/var/log/syslog}
  OUTPUT_FILE="reports/log_analysis.txt"

  echo "=== Log Analysis ===" > $OUTPUT_FILE
  echo "Source: $LOG_FILE" >> $OUTPUT_FILE
  echo "" >> $OUTPUT_FILE

  if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE" >> $OUTPUT_FILE
    exit 0
  fi

  ERROR_COUNT=$(grep -c "ERROR" "$LOG_FILE" 2>/dev/null || echo 0)
  WARN_COUNT=$(grep -c "WARN" "$LOG_FILE" 2>/dev/null || echo 0)

  echo "ERROR count : $ERROR_COUNT" >> $OUTPUT_FILE
  echo "WARN  count : $WARN_COUNT" >> $OUTPUT_FILE
  echo "" >> $OUTPUT_FILE
  echo "--- Last 10 ERRORs ---" >> $OUTPUT_FILE
  grep "ERROR" "$LOG_FILE" | tail -10 >> $OUTPUT_FILE
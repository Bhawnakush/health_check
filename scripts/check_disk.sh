  #!/bin/bash
  THRESHOLD=${DISK_THRESHOLD:-80}
  OUTPUT_FILE="reports/disk_check.txt"

  echo "=== Disk Usage Check ===" > $OUTPUT_FILE
  df -h >> $OUTPUT_FILE
  echo "hii this is me bhawna"

  USAGE=$(df / | awk 'END{print $5}' | tr -d '%')
  if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "STATUS: WARNING - Disk usage is ${USAGE}% (threshold: ${THRESHOLD}%)" >> $OUTPUT_FILE
    exit 1
  else
    echo "STATUS: OK - Disk usage is ${USAGE}% (threshold: ${THRESHOLD}%)" >> $OUTPUT_FILE
  fi
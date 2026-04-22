  #!/bin/bash
  OUTPUT_FILE="reports/memory_check.txt"

  echo "=== Memory & CPU Check ===" > $OUTPUT_FILE
  echo "--- Memory ---" >> $OUTPUT_FILE
  free -h >> $OUTPUT_FILE

  echo "--- CPU Load ---" >> $OUTPUT_FILE
  uptime >> $OUTPUT_FILE

  MEM_USED=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
  echo "STATUS: Memory used: ${MEM_USED}%" >> $OUTPUT_FILE
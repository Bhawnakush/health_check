  #!/bin/bash
  OUTPUT_FILE="reports/services_check.txt"
  FAILED=0

  SERVICES=("docker" "ssh")

  echo "=== Service Status Check ===" > $OUTPUT_FILE

  for SERVICE in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$SERVICE" 2>/dev/null; then
      echo "OK       - $SERVICE is running" >> $OUTPUT_FILE
    else
      echo "WARNING  - $SERVICE is NOT running" >> $OUTPUT_FILE
      FAILED=1
    fi
  done

  if [ $FAILED -ne 0 ]; then
    exit 1
  fi
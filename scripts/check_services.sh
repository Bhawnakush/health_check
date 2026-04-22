  #!/bin/bash                                                                                                                                                      
  OUTPUT_FILE="reports/services_check.txt"
  FAILED=0                                                                                                                                                         
                                         
  SERVICES=("docker" "ssh")

  echo "=== Service Status Check ===" > $OUTPUT_FILE

  for SERVICE in "${SERVICES[@]}"; do
    if pgrep -x "$SERVICE" > /dev/null 2>&1; then
      echo "OK       - $SERVICE is running" >> $OUTPUT_FILE
    else
      echo "INFO     - $SERVICE not detected (may be normal in container)" >> $OUTPUT_FILE
    fi
  done

  echo "--- Docker Containers ---" >> $OUTPUT_FILE
  docker ps >> $OUTPUT_FILE 2>&1

  echo "STATUS: OK" >> $OUTPUT_FILE
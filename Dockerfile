FROM python:3.11-slim                                                                                                                                      
                                                                                                                                                            
WORKDIR /app                                                                                                                                               
COPY generate_report.py .                                                                                                                                  
                                                                                                                                                               
COPY reports/ ./reports/                                                                                                                                   
                                                                                                                                                               
CMD ["python3", "generate_report.py"] 
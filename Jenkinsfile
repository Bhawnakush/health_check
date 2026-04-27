
  pipeline {
      agent any

      parameters {
          string(name: 'DISK_THRESHOLD', defaultValue: '80', description: 'Disk usage % to trigger warning')
          string(name: 'CLEANUP_DAYS',   defaultValue: '7',  description: 'Delete files older than N days')
          string(name: 'CLEANUP_DIR',    defaultValue: '/tmp', description: 'Directory to clean up')
          string(name: 'LOG_PATH',       defaultValue: '/var/log/syslog', description: 'Log file to analyze')
      }

      environment {
          DISK_THRESHOLD = "${params.DISK_THRESHOLD}"
          CLEANUP_DAYS   = "${params.CLEANUP_DAYS}"
          CLEANUP_DIR    = "${params.CLEANUP_DIR}"
          LOG_PATH       = "${params.LOG_PATH}"
      }

      triggers {
          cron('H 8 * * *')  // runs every day at 8 AM
      }

      stages {
         stage('aws')
         {
            agent{
                docker{
                    image 'amazon/aws-cli'
                    args "--entrypoint=''"
                }
            }
            steps{
                echo "aws-cli image "
                withCredentials([usernamePassword(credentialsId: 'my-aws', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
    // some block
    sh '''
                  aws --version
                  '''
}
                
            }
         }
          stage('Disk Check') {
              steps {
                  sh 'bash scripts/check_disk.sh'
              }
          }
          stage('Memory Check') {
              steps {
                  sh 'bash scripts/check_memory.sh'
              }
          }
          stage('Service Check') {
              steps {
                  sh 'bash scripts/check_services.sh'
              }
          }
          stage('Log Analysis') {
              steps {
                  sh 'bash scripts/parse_logs.sh'
              }
          }
          stage('Cleanup Old Files') {
              steps {
                  sh 'bash scripts/cleanup_old_files.sh'
              }
          }
          stage('Generate Report') {
              
              steps {
                    sh '''
              docker build -t report-generator .
              docker run --rm -v $(pwd)/reports:/app/reports report-generator
          '''
              }
          }
          stage('Archive Report') {
              steps {
                  archiveArtifacts artifacts: 'reports/final_report.html', fingerprint: true
              }
          }
      }

      post {
          success {
              echo "Health check completed successfully."
          }
          failure {
              echo "Health check FAILED - check the report."
          }
          always {
              echo "Pipeline finished at ${new Date()}"
          }
      }
  }
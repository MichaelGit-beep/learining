# By default, jenkins-jobs looks for ~/.config/jenkins_jobs/jenkins_jobs.ini, <script directory>/jenkins_jobs.ini or /etc/jenkins_jobs/jenkins_jobs.ini (in that order), but you may specify an alternative location when running jenkins-jobs.
# Specify alternative file
/root/.local/bin/jenkins-jobs --conf jenkins_jobs.ini update jobs

# Conf file syntax
[jenkins]
user=jenkins
password=1234567890abcdef1234567890abcdef
url=https://jenkins.example.com
query_plugins_info=False
##### This is deprecated, use job_builder section instead
#ignore_cache=True
# 

# Install  pip uninstall --user jenkins-job-builder



Create job - cat /root/jobs/test_job.yaml
- job:
    name: test_job
    description: |
      <hr>
      <h2>To run this job need to meet the requirements</h2>
      <ul>
        <li>Linux User must have sudo priveleges</li>
        <li>Linux machine must access bc-artifactory01 By ip, name resolution is no needed </li>
        <li>Working Briefcam Server with install WebServices</li>
      </ul>
    project-type: pipeline
    triggers:
    - timed: 'H H * * *'
    dsl: |
        pipeline {
            agent any
            stages{
                stage("1"){
                    steps{
                        sh "echo 123"
                    }
                }
            }
        }

# from the /root dir
root@mws:~/jobs# /root/.local/bin/jenkins-jobs update jobs

Delete job -  /root/.local/bin/jenkins-jobs delete test_job
# Specify alternative file
/root/.local/bin/jenkins-jobs --conf jenkins_jobs.ini update jobs



By default, jenkins-jobs looks for ~/.config/jenkins_jobs/jenkins_jobs.ini, <script directory>/jenkins_jobs.ini or /etc/jenkins_jobs/jenkins_jobs.ini (in that order), but you may specify an alternative location when running jenkins-jobs.

[jenkins]
user=jenkins
password=1234567890abcdef1234567890abcdef
url=https://jenkins.example.com
query_plugins_info=False
##### This is deprecated, use job_builder section instead
#ignore_cache=True


# Install  pip uninstall --user jenkins-job-builder


Create job - cat /root/jobs/jobs/test_job.yaml
- job:
    name: test_job
    description: "Automatically generated test"
    project-type: freestyle
    builders:
    - shell: "ls"


Delete job -  /root/.local/bin/jenkins-jobs delete test_job

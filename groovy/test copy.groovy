servers = ['lin-slave-11', 'lin-slave-12', 'lin-slave-13', 'lin-slave-14',]
def cleanup(servername){
    node(servername){
        stage("Cleanup ${servername}"){
            sh label: '', script: 'sudo find /data/jenkins/workspace/ -type f -mtime +7 -exec rm -rf {} \\;'
        }
    }
        
}

parallel(servers.collectEntries{[
    "Cleaning on ${it}":  {cleanup(it)} 
]})

# export env with password 
> export PGPASSWORD=pass1234
# Connect to DB
PGPASSWORD=pass1234 psql -U username -h 'host' 
# Insert kubeconfig into DB
```
kubeconfig=$(cat kubeconfig | base64 | tr -d '\n')
PGPASSWORD=mysecretpassword psql -U postgres -h localhost -d briefcam -c "CREATE TABLE newtable (id int, first_name VARCHAR(50), config TEXT);"
PGPASSWORD=mysecretpassword psql -U postgres -h localhost -d briefcam -c "INSERT INTO briefcam VALUES(13, 'config', '$kubeconfig');"
PGPASSWORD=mysecretpassword psql -U postgres -h localhost -d briefcam -c "INSERT INTO bc_k8s_config VALUES('briefcam', '$kubeconfig');"

PGPASSWORD=mysecretpassword psql -U postgres -h localhost -d briefcam -c "insert into bc_k8s_gpus (gpu_model, gpu_pool_size) values('{{ hostvars[item].gpu_type }}','{{ hostvars[item].gpu_count }}');" || PGPASSWORD=mysecretpassword psql -U postgres -h localhost -d briefcam -c "update bc_k8s_gpus set gpu_pool_size=gpu_pool_size + '{{ hostvars[item].gpu_count }}' where gpu_model='{{ hostvars[item].gpu_type }}';"

PGPASSWORD=mysecretpassword psql -U postgres -h localhost -d briefcam -c "SELECT * FROM briefcam;"
```
# To use config from postgres first need to decode it
```
echo "encodedconfig" | base64 --decode > kubeconfig
```
# export env with password 
> export PGPASSWORD=pass1234
# Connect to DB
PGPASSWORD=pass1234 psql -U username -h 'host' 
# Insert into DB
PGPASSWORD=mysecretpassword psql -U postgres -h localhost -d briefcam -c "CREATE TABLE newtable (id int, first_name VARCHAR(50));"
PGPASSWORD=mysecretpassword psql -U postgres -h localhost -d briefcam -c "INSERT INTO briefcam VALUES(6, 'something');"
PGPASSWORD=mysecretpassword psql -U postgres -h localhost -d briefcam -c "SELECT * FROM briefcam;"
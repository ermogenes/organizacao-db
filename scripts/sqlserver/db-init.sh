echo "[db-init.sh] started."

#wait for the SQL Server to come up
echo "wait 60s for the SQL Server to come up..."
sleep 60s

echo "running [db-init.sql] set up script..."
#run the setup script to create the DB and the schema in the DB
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P My_secret_!2#4% -d master -i db-init.sql

echo "[db-init.sh] done."

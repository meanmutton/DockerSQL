# DockerSQL

Note: Docker for Windows requires Windows 10 Pro or Enterprise version 14393, or Windows server 2016 RTM to run. Docker runs fine on Mac.

Prior to starting, be sure to install docker: https://docs.docker.com/install/

Next, get the .sql files and download them to local.

Once you have that, to create a docker container, populate it with SQL, run a test script against it, and destroy it, do the following:

From your command line*:
   *Replace single quotes with double quotes on Windows Command Line

#### 1 - Get the latest Docker container:

```bash
docker pull microsoft/mssql-server-linux:2017-latest
```
This will pull the latest SQL Docker instance from Microsoft.

#### 2 - Stand up your SQL instance:

```bash
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=CorrectHorseBatteryStaple!'  -p 1433:1433 --name DockerSQL  -d microsoft/mssql-server-linux:2017-latest
```
-e ACCEPT_EULA=Y is needed to accept the EULA. Always use this.

-e SA_PASSWORD= is used to set the SA Password. You can adjust this as needed. To create other users, script it out in your file to create the schema.

-p This determines which port SQL is running on. MappedPort:DockerPort 1444:1433 to map default SQL port 1433 to 1444

--name is the Docker Instance name.

-d This is the docker container to use, pulled down above.


#### 3 - Copy Create Scripts to Container:

```bash
docker cp ~/Documents/GitHub/HockeyLeague/CreateHockeyLeagueSchema.sql DockerSQL:/var/opt/mssql/
docker cp ~/Documents/GitHub/HockeyLeague/CreateHockeyLeagueDataPopulation.sql DockerSQL:/var/opt/mssql/
```

Docker cp will copy from a local file to a file space in the docker container. This is not persistant storage and will be lost if the container is destroyed.

These are the files to create the schema and populate it with sample data. You'd want to have these point to a GitHub pull of the files in this repo.


#### 4 - Run CreateHockeyLeagueSchema.sql

```bash
docker exec DockerSQL /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'CorrectHorseBatteryStaple!' -i /var/opt/mssql/CreateHockeyLeagueSchema.sql
```

You can use docker exec to run commands inside the docker instance. The first item is the name of the instance, then the name of the command (in this case, sqlcmd). The rest are the attributes for the command you're running.

This command logs in as SA with the defined password and runs the script to build the schema.

#### 5 - Run CreateHockeyLeagueDataPopulation.sql

```bash
docker exec DockerSQL /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'CorrectHorseBatteryStaple!' -i /var/opt/mssql/CreateHockeyLeagueDataPopulation.sql
```

This command runs the data population script.

#### 6 - Copy Test Scripts to Container:

```bash
docker cp ~/Documents/GitHub/HockeyLeague/TestScript.sql DockerSQL:/var/opt/mssql/
```

Copies scripts from local to the docker container.

#### 7 - Run Test Scripts:

```bash
docker exec DockerSQL /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'CorrectHorseBatteryStaple!' -i /var/opt/mssql/TestScript.sql
```

Running the test scripts

#### 8 - Connect to the database with SSMS or SQL OS.

You can open up SQL Server Management Studio or SQL Operations Studio and connect to the database.

The server will be located at your local host's IP address with the port specified above. You should be able to use the sa login defined when creating the instance unless you've scripted the schema build script to eliminate it.


#### 9 - Stop Docker

```bash
docker stop DockerSQL
```

If you don't want to run the container anymore, you can stop it here.

#### 10 - Remove Dcker instance

```bash
docker rm DockerSQL
```

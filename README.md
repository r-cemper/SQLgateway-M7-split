
# SQLgateway-migration-ORACLE-IRIS #  
Sample repository to show how to migrate from IBM DB2server to InterSystems IRIS    
**using SQLgateway** in contrast to using an external tool as DBeaver or CloudBeaver or similar. 
### Warning ###
This is just JDBC/Java and IRIS with ISOS and SQL 
- no AI, no Python, no other magic
 
## Credits ##
Git>Hub package [migration-oracle-iris](https://github.com/yurimarx/migration-oracle-iris)
provided by [YURI MARX PEREIRA GOMES](https://openexchange.intersystems.com/user/YURI%20MARX%20PEREIRA%20GOMES/QKGV1uPuZml09uNsC8bNKcRQj8)   
    - Special thanks as this was an excellent base to start off.  
And the [official documentation on SQLgateway](https://docs.intersystems.com/iris20261/csp/docbook/Doc.View.cls?KEY=BSQG_overview)  

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation 
Clone/git pull the repo into any local directory
```
git https://github.com/r-cemper/SQLgateway-migration-ORACLE-IRIS.git
```
1. Build
```
docker-compose build
```
2. Run it in foreground. Sometimes container start is slower than estimated.  
```
docker-compose up
```
  - Wait for confirmation from your containers container:  **ready to accept connections**
  - The first pull for DB2 may take quite some time for the upload

3.   **Connection to ORACLE**: 
        - host: container oracle 
        - database: SAMPLEDB 
        - port: 1521
        - username: SAMPLEDB
        - password: Welcome1
4.   **Connection to IRIS**: 
        - host: localhost 
        - namespace: user 
        - port: 41773 
        - username: _SYSTEM 
        - password: SYS
5. **SQLgateway**  
   is installed during Docker build and the required   
   jdbcdriver for Linux is included in this repo   
   
## How to test ##
SMP is available here 
     http://localhost:42773/csp/sys/UtilHome.csp    
     
All migration actions can be executed directly from SMP.   
1. Verify the gateway connection in    
   SMP> Administration> Configuration> Connectivity> SqlGateway_Configuration    
 ![](https://raw.githubusercontent.com/r-cemper/SQLgateway-migration-ORACLE-IRIS/master/docs/gty01.jpg) 
   - To test Connection click **edit** for connection **ORACLE**     
   - verify  **Connection successful**      
   - Be patient at this point. Some DB containers take quite some time to talk to you.   
     wait a little bit, reload the page in browser and try the test again. 
   
2. Identifying the source tables. In SMP > Change to Namespace USER   
  then step to SMP >Explorers >SQL >Wizards > Data Migration   
  ![](https://raw.githubusercontent.com/r-cemper/SQLgateway-migration-ORACLE-IRIS/master/docs/gty04.jpg)
  
3. Set required import parameters  
 
  -  Destination Namespace = USER  
  -  Type = TABLE   
  -  Select a SQL Gateway connection: = ORACLE  ; now the first connection is established and you select 
  -  and you select Schema = [your choice ? ]
  -  Tables to migrate:  The example has a lot of cross-references 
     It might be clever to load tables in their logical order to reduce errors
     Also, loading definitions first and data later would improve success 
  
4. Identifying new targets is possible, but may cause conflicts in cross-references   

5. Skipping special settings, we use defaults to start the task in background      
  ![](https://raw.githubusercontent.com/r-cemper/SQLgateway-migration-ORACLE-IRIS/master/docs/gty07.jpg) 
  
6. Now check the results and see if everything was working without Errors
  You might see errors if tables depend on content not yet migrated.   
  And wait for completions until the status shows **Done** 
  
7. We terminate the Migration Wizard and return to normal table view 
   All tables are visible and show meaningful columns
  
8. Selecting a table and clicking on **OpenTable** shows reasonable contents   
  
9. A look into the related generated Class Definitions confirms the result and successful completion.

  [Article on DC](https://community.intersystems.com/post/sqlgateway-migration-ORACLE-iris)    
  [Data source description by Yuri Marx](https://community.intersystems.com/post/data-migration-tool-part-v-oracle-database-21c-iris)


# SQLgateway-operating-IRIS-IRIS #  
Sample example to show how to communicate between instances of IRIS     
**using SQLgateway** in contrast to other types of linking.        
Migration is the most attractive functionality in SQLgatway and it is easy to visualize.    
Migration doesn't mean a full DB copy but also just a few tables.    
As copy of definitions are separated from data it might be just a data update.   
But SQLgateway also offers a broad range of non-permanent linking of databases.   
e.g. centralized error tracking.    
Inspired by my previous packages, IRIS was only DB missing in the collection.    
So this is a logical follower.  
### Warning ###
This is just JDBC/Java and IRIS with ISOS and SQL   
- no AI, no Python, no other magic  
 
## Credits ##
 [official documentation on SQLgateway](https://docs.intersystems.com/iris20261/csp/docbook/Doc.View.cls?KEY=BSQG_overview) uncovers more useful features.

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.    

## Installation 
Clone/git pull the repo into any local directory
```
git https://github.com/r-cemper/SQLgateway-migration-IRIS-IRIS.git
```
1. Build
```
docker-compose build
```
2. Run it in foreground. Sometimes container start is slower than estimated.  
```
docker-compose up
```
A sample of demo data is generated on IRIS2 on namespace USER

3.   **Connection to IRIS2**: 
        - host: container iris2 
        - database: USER 
        - port: 1972
        - username: _SYSTEM
        - password: SYS
        - SMP: http://localhost:51772/csp/sys/UtilHome.csp
        
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
 ![](https://raw.githubusercontent.com/r-cemper/SQLgateway-migration-IRIS-IRIS/master/docs/gty01.jpg) 
   - To test Connection click **edit** for connection **IRIS2**     
   - verify  **Connection successful**      
   - Be patient at this point. Sometimes DB containers take quite some time to talk to you.   
     Wait a little bit, reload the page in browser and try the test again. 
   
2. Identifying the source tables. In SMP > Change to Namespace USER   
  then step to SMP >Explorers >SQL >Wizards > Data Migration   
  ![](https://raw.githubusercontent.com/r-cemper/SQLgateway-migration-IRIS-IRIS/master/docs/gty04.jpg)
  
3. Set required import parameters  
   -  Destination Namespace = USER  
  -  Type = TABLE   
  -  Select a SQL Gateway connection: = IRIS2  ; now the first connection is established 
  -  and you select Schema = SAMPLES  
  -  Tables to migrate: the Samples.* package   
     It's a modest set adopted from Caché  
   
4. Identifying new targets is possible, but may cause conflicts in cross-references 
   This is one key to success:   
   Tables get listed alphabetically not by logical dependency or sequence. 
   This could cause errors.  

5. Skipping special settings, we use defaults to start the task in background      
  ![](https://raw.githubusercontent.com/r-cemper/SQLgateway-migration-IRIS-IRIS/master/docs/gty07.jpg) 
  
6. Now check the results and see if everything was working without errors  
   You might see errors if tables depend on content not yet migrated.   
   And wait for completions until the status shows **Done** 
  
7. We terminate the Migration Wizard and return to the normal table view 
   All tables are visible and show meaningful columns and contents
  
8. Selecting a table and clicking on **OpenTable** shows reasonable contents   
  
9. A look into the related generated Class Definitions confirms the result and successful completion.

  [Article on DC](https://community.intersystems.com/post/sqlgateway-migration-iris-iris) 
 

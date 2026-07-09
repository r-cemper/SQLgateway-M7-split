# The Magnificent Seven #  
After composing examples of using SQLgateway for DB_Migration to IRIS  
I couldn't resist assembling all 7 around IRIS in a single package.   
8 containers in 1 Docker-Compose felt like driving an 8-cylinder engine.   
- sqlgateway-magnificent-7 > IRiS1
- 1 oracle21c
- 2 mysql
- 3 postgres
- 4 IBM db2 
- 5 MSsql
- 6 Caché 
- 7 IRIS2   

#### Warning ####
This is just JDBC/Java and IRIS with ISOS and SQL   
- no AI, no Python, no other magic  
 
## Credits ##
Special thanks for the test data to [YURI MARX PEREIRA GOMES](https://openexchange.intersystems.com/user/YURI%20MARX%20PEREIRA%20GOMES/QKGV1uPuZml09uNsC8bNKcRQj8)    
This was an excellent base to start off.   
And the [official documentation on SQLgateway](https://docs.intersystems.com/iris20261/csp/docbook/Doc.View.cls?KEY=BSQG_overview) with more features.

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.    
For the test with Caché, a valid Caqché license is required

## Installation 
Clone/git pull the repo into any local directory
```
git https://github.com/r-cemper/SQLgateway-Magnificent-7.git
```
1. Build
```
docker-compose build
```
2. Run it in foreground. Sometimes container start is slower than estimated.  
```
docker-compose up
```
Downloading some GB of test data takes some time. Be patient.  
As I like to follow the progress of Compose, I use 
```
docker-compose up -d   && docker-compose logs -f
```
This brings some movement to my screen and is less boring.   
Demo data are generated or imported during compose.

3.    **Connection to IRIS**: 
        - host: localhost 
        - namespace: user 
        - port: 41773 
        - username: _SYSTEM 
        - password: SYS
        - SMP: http://localhost:42773/csp/sys/UtilHome.csp
        
4. **SQLgateway**  
   is installed during Docker build and all required   
   jdbcdriver are included and activated
   
## How to test ##
SMP is available here 
     http://localhost:42773/csp/sys/UtilHome.csp    
     
All migration actions can be executed directly from SMP.   
1. Verify the gateway connection in    
   SMP> Administration> Configuration> Connectivity> SqlGateway_Configuration    
 ![](https://raw.githubusercontent.com/r-cemper/SQLgateway-Magnificent-7/master/docs/gty01.jpg) 
   - To test Connection click **edit** 
   - Test connection and check **Connection successful**      
   - Be patient at this point. Sometimes DB containers take quite some time to talk to you.   
     Wait a little bit, reload the page in browser and try the test again. 
   
2. Identifying the source tables. In SMP > Change to Namespace USER   
  then step to SMP >Explorers >SQL >Wizards > Data Migration   
  ![](https://raw.githubusercontent.com/r-cemper/SQLgateway-Magnificent-7/master/docs/gty04.jpg)
  
3. Set required import parameters  
   -  Destination Namespace = USER  
  -  Type = TABLE   
  -  Select ay SQL Gateway connection    
  -  and next select a Schema from source
  -  Tables to migrate: as offered  
    
4. Identifying new targets is possible, but may cause conflicts in cross-references 
   This is one key to success:   
   Tables get listed alphabetically not by logical dependency or sequence. 
   This could cause errors.  

5. Skipping special settings, we use defaults to start the task in background      
  ![](https://raw.githubusercontent.com/r-cemper/SQLgateway-migration-Magnificent-7/master/docs/gty07.jpg) 
  
6. Now check the results and see if everything was working without errors  
   You might see errors if tables depend on content not yet migrated.   
   And wait for completions until the status shows **Done**    
  ![](https://github.com/r-cemper/SQLgateway-Magnificent-7/blob/main/docs/7upSuccess.jpg)

8. We terminate the Migration Wizard and return to the normal table view 
   All tables are visible and show meaningful columns and contents
   
9. Selecting a table and clicking on **OpenTable** shows reasonable contents   
  
10. A look into the related generated Class Definitions confirms the result and successful completion.

  [Article on DC](https://community.intersystems.com/post/sqlgateway-magnificent-7) 
 

# The Magnificent Seven > splitted #  

My previous package on [SQLgateway Migrations](https://github.com/r-cemper/SQLgateway-Magnificent-7) 
was a big block showing   
available possibilities. Though it is not easy to handle and hard to trace.  
So my challenge: **How to eat an Elephant?**  >> Cut it in pieces !! 

My goal was to allow both: creating every container isolated but allow   
also a 1 click build of the whole collection. So it is now possible to   
fix problems related to an individual container without touching the others.  

It turned out that this became an exercise in Docker networking and scripting,   
- Every Docker-Compose Up creates its own network. So simple starting as   
  in previous examples, builds 8 networks isolated from each other.   
  **SOLUTION:** Define a common network and attach the containers.   
  Now TCP/JDBC finds the servers, and we see no port conflicts anymore
- running 8 times *docker-compose up -d* for all containers is not so funny
  SOLUTION: Docker Compose has an INCLUDE directive. 1 click and all blows up.
```
include:   
  - ./iris1/docker-compose.yml   
  - ./cache/docker-compose.yml    
  - ./ibmDB2/docker-compose.yml   
  - ./iris2/docker-compose.yml    
  - ./MSsql/docker-compose.yml   
  ## - ./mysql/docker-compose.yml   
  - ./ORACLE/docker-compose.yml   
  - ./postgres/docker-compose.yml
```
Now you can create all containers from top or step into   
the subdirectories for an individual Startup. It's a feature  
added for debugging or cleaning containers.
 
## Credits ##
Special thanks for the test data to [YURI MARX PEREIRA GOMES](https://openexchange.intersystems.com/user/YURI%20MARX%20PEREIRA%20GOMES/QKGV1uPuZml09uNsC8bNKcRQj8)    
This was an excellent base to start off.   
And the [official documentation on SQLgateway](https://docs.intersystems.com/iris20261/csp/docbook/Doc.View.cls?KEY=BSQG_overview) with more features.

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.    
For the test with Caché, a **valid** Caqché license is required

## Installation 
Clone/git pull the repo into any local directory
```
git https://github.com/r-cemper/SQLgateway-Magnificent-7.git
```
0. Before any other action, define your common network
```
docker network create sqlgateway
```
1. Build all containers or just a specific one from the subdirectory
```
docker-compose build
```
2. As I like to follow the progress of Compose, I use   
```
docker-compose up -d   && docker-compose logs -f
```
This adds some movement to my screen and makes it less boring.  
You get a real Docker Container creation show.  
Downloading some GB of test data takes some time. Be patient.   
Demo data are always generated or imported during compose. 

3. Next start MSsql container to avoid resource conflicts in   
   compose. MSsql is a really lazy jerk that I would fire if    
   it were my employee, and look for an improving migration. :-))
```
docker compose -f .\MSsql\docker-compose.yml up 
```   
4. **Connection to IRIS**: 
        - host: localhost 
        - namespace: user 
        - port: 41773 
        - username: _SYSTEM 
        - password: SYS
        - SMP: http://localhost:42773/csp/sys/UtilHome.csp
        
5. **SQLgateway**  
   is ready for all 7 containers
   
## How to test ##
SMP is available here 
     http://localhost:42773/csp/sys/UtilHome.csp    
     
All migration actions can be executed directly from SMP.   
1. Verify the gateway connection in    
   SMP> Administration> Configuration> Connectivity> SqlGateway_Configuration    
 ![](https://raw.githubusercontent.com/r-cemper/SQLgateway-M7-split/master/docs/gty01.jpg) 
   - To check the connections, click **edit** 
   - Test connection and check **Connection successful**      
   - Be patient at this point. Sometimes DB containers (MSsql) take quite   
     some time to talk to you. Wait a little bit, reload the page in browser
     and try the test again.    
     **Hint:**    
     If the problem persists Start/Stop the affected Container helps sometimes. 
     A missing Cache.Key requires rebuilding the Cache image or manually   
     adding the license on the SPM  (port 57772) 

     **Know limit:** For some reason MSsql container is not able to complete its    
     init inside the compose. Might be related to available resources. So it 
     has to be built separately. My interpretation. MSsql refuses competition.
         
2. Identifying the source tables. In SMP > Change to Namespace USER   
  then step to SMP >Explorers >SQL >Wizards > Data Migration   
  ![](https://raw.githubusercontent.com/r-cemper/SQLgateway-M7-split/master/docs/gty04.jpg)
  
3. Set required import parameters  
   -  Destination Namespace = USER  
  -  Type = TABLE   
  -  Select any SQL Gateway connection    
  -  and next select a Schema from source
  -  Tables to migrate: as offered  
    
4. Applying a new schema is possible, but may cause conflicts    
   This is one key to success:    
   Tables get listed alphabetically not by logical dependency or sequence.
   ALso this could cause errors.  

6. Skipping special settings, we use defaults to start the task in background      
  ![](https://raw.githubusercontent.com/r-cemper/SQLgateway-migration-M7-split/master/docs/gty07.jpg) 
  
7. Now check the results and see if everything was working without errors  
   You might see errors if tables depend on content not yet migrated.   
   And wait for completions until the status shows **Done**    
  ![](https://github.com/r-cemper/SQLgateway-Magnificent-7/blob/main/docs/7upSuccess.jpg)

8. We terminate the Migration Wizard and return to the normal table view 
   All tables are visible and show meaningful columns and contents
   
9. Selecting a table and clicking on **OpenTable** shows reasonable contents   
  
10. A look into the related generated Class Definitions confirms the result and successful completion.

  [Article on DC](https://community.intersystems.com/post/sqlgateway-m7-split) 
 

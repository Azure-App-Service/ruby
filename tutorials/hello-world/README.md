# Hello World Tutorial
## Introduction
This tutorial will show you how to create a basic ruby on rails application locally and prepare/deploy it to Azure App Service on Linux
## Prerequisites
1. Ruby 2.3.3 is installed onto your development machine however you want (RVM or rbenv etc)
2. git is installed on your development machine
3. Azure account + subscription
4. This tutorial is written under the context of an Ubuntu environment, so all system commands are bash specific

## Steps
### Creating a new rails application locally
1. create a separate directory to work in `mkdir workspace` ; `cd workspace`
2. Initialize ruby and check its version using `ruby -v` 
![1](assets/1.PNG?raw=true)
3. Install rails using `gem install rails`
![2](assets/2.PNG?raw=true)
3. Create a new rails application **hello-world** using `rails new hello-world`
![3](assets/3.PNG?raw=true "beginning of output")
![4](assets/4.PNG?raw=true "end of output")
4. Move into created directory `cd hello-world`
5. Start the rails server `rails server`
![5](assets/5.PNG?raw=true "The website will now be running under localhost:3000")
6. Navigate to `localhost:3000` in your web browser of choice
![6](assets/6.PNG?raw=true "default landing page for rails")

### Preparing application for Azure
The ruby image, by default, runs the server with the flag `-e production`. This requires some special setup, some of which the container takes care of (such as setting a SECRET_KEY_BASE). What you as the user needs to prepare is a root landing page as the default rails landing page, otherwise the website will fail to start. 
1. Open `config/routes.rb` and add the line `root 'application#hello'`
![7](assets/7.PNG?raw=true)
2. Open `app/controllers/application_controller.rb` and add these lines of code: 
```
def hello
  render html: "Hello, world from App Service on Linux!"
end
```
![8](assets/8.PNG?raw=true)
After these steps your landing page should be configured. You can try running the server and navigating to the page yourself to see.
![13](assets/13.PNG?raw=true)

### Creating a ruby website on Azure
1. On the azure portal [portal.azure.com](portal.azure.com), click on the `+` symbol on the sidebar and search for `web apps on linux`
![9.1](assets/9.1.PNG?raw=true)
![9](assets/9.PNG?raw=true)
2. Choose an appropriate application name 
![9.2](assets/9.2.PNG?raw=true)
3. For app service plan, create a new one as such:
![9.3](assets/9.3.PNG?raw=true)
4. For **configure container** choose `Ruby 2.3`
![9.4](assets/9.4.PNG?raw=true)
Your finished settings should look something like this:
![9.5](assets/9.5.PNG?raw=true)
5. Create the site and browse to the webpage and you should see the default splash page
![10](assets/10.PNG?raw=true)

### Deploying your application to Azure
1. Your newly created azure application has built in local git deployment set up. The git link can be found here: `https://{yoursitename}.scm.azurewebsites.net/api/scm/info` and is traditionally formatted as: `https://{yoursitename}.scm.azurewebsites.net/{yoursitename}.git`
2. Go back to your hello world application's home directory in bash and run these git commands: 
```
git init
git remote add azure <link to your sites git>
git add -A
git commit -m "Initial Commit"
git push azure master
```
3. Deployment will take a while, see the github readme for our ruby image to see the steps taken. You may be waiting for a few minutes, but afterwards your output should look like this: 
![11](assets/11.PNG?raw=true)
```
if the git client returns any error indicating the remote hung up, your deployment may still be progressing on the server side. To check the status of your deployment, navigate to this link: https://{yoursitename}.scm.azurewebsites.net/api/deployments
```
4. You will need to manually restart your site to see the new deployment take effect. 
``` 
Restart may take a while to be put in effect, so after you click restart in the portal, wait a few minutes before navigating back to the website. You may receive 503's while restart is in effect
```
And when navigating to your site you should see this!
![12](assets/12.PNG?raw=true)

# Continuous Integration from GitHub
## Introduction
This tutorial will show you how to set up continuous deployment of your ruby website from github.
## Prerequisites
1. A personal GitHub account
2. A github repository containing a ruby application that works in **production** mode. (You can just fork the tutorial example instead if you don't want to go about creating a new ruby application)

## Steps
1. This tutorial will be using a repo named Hamster-Huey/ruby-splash. This is a basic ruby site that serves a modified version of the Azure App Service splash page. Fork this repository to repro this tutorial exactly. 

![1](assets/1.PNG?raw=true)

2. Go to the [azure portal](http://portal.azure.com/) and click `new` and choose `Web App on Linux`

![2](assets/2.PNG?raw=true)
![3](assets/3.PNG?raw=true)

3. Set up your new website making sure to choose `ruby 2.3` container

![4](assets/4.PNG?raw=true)

4. Wait for the site creation to complete. Navigate to your new site's blade in the portal and look on the sidebar to click on `deployment options`

![5](assets/5.PNG?raw=true)

5. For **Deployment source** choose **Github Repository**

![6](assets/6.PNG?raw=true)
![7](assets/7.PNG?raw=true)

6. Configure your deployment source to your GitHub accountn and private project repository. Here's an example:

![8](assets/8.PNG?raw=true)
![9](assets/9.PNG?raw=true)

7. Your deployment options blade may look like this: 

![10](assets/10.PNG?raw=true)

Click **sync** to kick off a sync/build of your ruby site. 

![11](assets/11.PNG?raw=true)

8. Wait for the deployment to finish

![12](assets/12.PNG?raw=true)

9. Navigate to your site's url. You may have to wait a couple minutes as the container starts, but in the end you should see this page:

![13](assets/13.PNG?raw=true)


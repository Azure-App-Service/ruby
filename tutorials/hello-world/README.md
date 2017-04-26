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

# Rails Bootstrap Tutorial
## Introduction
This tutorial will show you:
1. Debugging versioning issues in deploying your Rails application
2. Serving precompiled assets from your website

## Prerequisites
1. git is installed in your local machine
2. A text editor of your choice
3. A freshly-created Web App on Linux using Ruby 2.3 (see previous tutorial [here](https://github.com/Azure-App-Service/ruby/blob/master/tutorials/hello-world/README.md#creating-a-ruby-website-on-azure) for details on how to do that)

## Steps
### Deploy Rails-Bootstrap
1. Navigate to the Rails-Bootstrap Github repository [here](https://github.com/RailsApps/rails-bootstrap)

![1](assets/1.PNG?raw=true)

2. Copy the git link from the "clone or download" tab as such

![2](assets/2.PNG?raw=true)

3. Clone the git repository to your local machine using the command 'git clone https://github.com/RailsApps/rails-bootstrap.git` 

![3](assets/3.PNG?raw=true)

4. Run these series of git commands to set up git to your website
```
git remote add azure https://<your-website-name>.scm.azurewebsites.net/<your-website-name>.git
git push azure master
```

Your deployment **will fail** unfortunately as such

![4](assets/4.PNG?raw=true)

5. After digging though the deployment logs in our `/home/site/deployments` directory (through kudu site or ftp copy), we can see versioning issues happening. As the Web Apps on Linux service only currently supports **2.3.3**, we need to tailor our application accordingly.

6. To fix this, we first open our **Gemfile** and locate this line:

![5](assets/5.PNG?raw=true)

and change it to this:

![6](assets/6.PNG?raw=true)

7. That's not all yet, as if you try deploying again you will see this error in your logs:

![7](assets/7.PNG?raw=true)

To fix this, open up your **.ruby-version** file and change the line to say ```2.3.3```

8. Now let's redeploy our application. Run these commands:
```
git add Gemfile
git add .ruby-version
git commit -m "Update ruby version"
git push azure master
```

Your output should look something like this:
![8](assets/8.PNG?raw=true)

9. Let's try and hit our site! Let's see....oh no...

![9](assets/9.PNG?raw=true)

It looks like there's no css. If we check the developer console in chrome we see this:

![10](assets/10.PNG?raw=true)

This happens because rails applications in App Service are run in **production** mode. If you look in `config/environments/production.rb` you will see that an environment variable **RAILS_SERVE_STATIC_FILES** needs to be set in order to serve static assets. 

10. In your site application settings in the [portal](http://portal.azure.com), you need to set `RAILS_SERVE_STATIC_FILES=true` 

![11](assets/11.PNG?raw=true)

11. If we ping our website again we will see this:

![12](assets/12.PNG?raw=true)

This means that we need to precompile our stylesheets and javascript using rake. Luckily, we can do this through our kudu deployment. 

12. In your site appsettings, set `ASSETS_PRECOMPILE=true`

![17](assets/17.PNG?raw=true)

13. Check your scm site ```<yoursitename>.scm.azurewebsites.net/Env.cshtml``` to make sure that you see your appsetting there:

![13](assets/13.PNG?raw=true)

If it's not there, keep refreshing until you do. This is to make sure that the Kudu container has successfully recycled with the new appsetting before we deploy. 

14. Now, let's kick off a new git deployment. A quick and simple way to do this would be to create a temporary file and add it to your git repo. 

``` 
touch restart.txt
git add restart.txt
git commit -m "Add restart.txt"
git push azure master
```

15. In your deployment output, you should now see this:

![14](assets/14.PNG?raw=true)

![15](assets/15.PNG?raw=true)

16. After deployment is finished, check your site. If it hasn't changed, you might need to manually restart through the portal. After restarting and waiting a couple minutes (the site container has to restart which takes a bit of time), you should see this:

![16](assets/16.PNG?raw=true)

Congrats! You have now created a ruby website that serves precompiled javascript and stylesheet assets (in this case with bootstrap). 

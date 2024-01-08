Hosting info


I've launched a fresh ubuntu 22 instance. I have a folder in /home/ubuntu/shademap which has an index.html and some javascript and css files.
I want to use caddy as a reverse proxy to get my site online at my domain sm.skoop.digital with https. My domain is pointed to the public ip of my instance which is 52.33.184.219, and all ports are open.
I am trying to serve my site on localhost as is a requirement of the library used in the site, but I want to access the site remotely. Thus I am considering using caddy to reverse proxy the locally hosted site served with python which should all start on boot
What are all the steps I need to take.


1. Install Caddy:

    a. Update your Ubuntu package list:

    ```
    sudo apt update
    ```

    b. Install the necessary packages for adding a new repository:

    ```
    sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
    ```

    c. Import the GPG key for the repository:

    ```
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo apt-key add -
    ```

    d. Add the Caddy repository:

    ```
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/deb/ubuntu.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
    ```

    e. Update your package list again:

    ```
    sudo apt update
    ```

    f. Install Caddy:

    ```
    sudo apt install caddy
    ```

2. Create a Caddyfile:

    a. Navigate to the Caddy directory (usually /etc/caddy):

    ```
    cd /etc/caddy
    ```

    b. Create a new file named Caddyfile:

    ```
    sudo nano Caddyfile
    ```

    c. Add the following lines to the file:

    ```
    sm.skoop.digital {
        reverse_proxy localhost:8000
    }
    ```
    Replace 8000 with the port your application is running on.

    d. Save and close the file.

3. Set up your application to start on boot:

    a. Create a new systemd service file:

    ```
    sudo nano /etc/systemd/system/myapp.service
    ```

    b. Add the following lines to the file:

    ```
    [Unit]
    Description=My app
    After=network.target

    [Service]
    ExecStart=/usr/bin/python3 -m http.server
    WorkingDirectory=/home/ubuntu/shademap
    User=ubuntu
    Restart=always

    [Install]
    WantedBy=multi-user.target
    ```

    c. Save and close the file.

    d. Enable the service to start on boot:

    ```
    sudo systemctl enable myapp
    ```

    e. Start the service:

    ```
    sudo systemctl start myapp
    ```

4. Restart Caddy:

    ```
    sudo systemctl restart caddy
    ```

Now, if you access sm.skoop.digital in your browser, you should see your application. If it doesn't work, you can check the status of your application and Caddy with `systemctl status myapp` and `systemctl status caddy`, respectively. 

Please replace `myapp` with the actual name of your application. 

Also, make sure your domain is pointing to the correct IP address and that your firewall allows traffic on ports 80 and 443. 

This setup assumes that your application is a Python application using the built-in HTTP server on port 8000. If your application uses a different command to start or a different port, you will need to adjust the steps accordingly. 

If you have multiple applications, you can create a separate systemd service for each one, and add a separate block to your Caddyfile for each domain. 

Remember to replace sm.skoop.digital with your actual domain name.

For the python server to work properly, make sure all your files are in the /home/ubuntu/shademap directory including the index.html file.

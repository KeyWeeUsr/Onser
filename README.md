# Onser

... or "Onion (Hidden) Service". Onser is a simple Docker image allowing you to
very quickly create an Onion hidden service for the TOR network.
Based on NGINX and latest Tor.


### Run

1. Get [Docker](https://www.docker.com/get-started)
2. Get Tor Browser
   [via torproject.org](https://www.torproject.org/download/download-easy.html.en),
   [via email](mailto://gettor@torproject.org),
   [via twitter](https://twitter.com/get_tor)
3. ``git clone https://github.com/KeyWeeUsr/Onser``
4. Put your files into the ``www`` folder
5. Run the ``run.bat`` (Windows) or ``source run.sh`` (MacOS or GNU/Linux)
6. Get your .onion address: ``docker exec -it $(docker ps -q) cat www/hostname``
7. Navigate to the .onion address in the Tor Browser
8. Enjoy


### Multiple services

You can use ``docker-compose.yml`` to run multiple separate onion services with
multiple ``www`` folders set via build argument ``www_folder`` (similarly
``nginx_conf``). See the default compose file.

To build and run the services you need just a single command:

    docker-compose up -d

which will build the images and run the containers.

To get the .onion URLs use:

    docker-compose exec one cat www/hostname
    docker-compose exec two cat www/hostname
    docker-compose exec three cat www/hostname

Each service has a separate volume specified in the compose file thus holds
a unique ``private_key`` for the service.

To remove containers, volumes, images, networks use:

    docker-compose down --volumes --rmi all


### Custom permissions

To modify the permissions to your liking you can use this example:

    FROM keyweeusr/onser:<tag>
    USER root

    # folder
    RUN chmod 0123 /home/onser/www

    # folder + files
    RUN chmod -R 0123 /home/onser/www
    USER onser


### Issues

Sometimes building the Docker image fails due to importing the ``gpg`` keys.

    gpg: directory '/root/.gnupg' created
    gpg: keybox '/root/.gnupg/pubring.kbx' created
    gpg: keyserver receive failed: Cannot assign requested address


### Disclaimer

Made for educational purposes, in my free time, unrelated to any
institution/company/subject/... I was or am in contact with.


### PS

Please do not use it for nasty crap
and/or don't connect me with it if you do anyway.

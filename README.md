Dropplets Blog Dockerfile
=========================

Dockerfile to build a Docker image of the Dropplets blogging platform

## Deploy from index.docker.io

	docker pull wujtruj/dropplets

### Temporary config

Run fresh instance of Dropplets:

	docker run -d wujtruj/dropplets

Check port and navigate to `http://localhost:port`

### Permanent config

To run instance with persistant config and posts, You have to prepare local directory with dropplets files:

	wget --no-check-certificate https://github.com/circa75/dropplets/archive/master.zip
	unzip master.zip
	rm master.zip
	mv dropplets-master/ dropplets/
	chown -R www-data: dropplets/

Then You simply run container pointing out directory to mount:

	docker run -d -p 80:80 -v `pwd`/dropplets:/var/www/dropplets wujtruj/dropplets

Then navigate to `http://localhost`

## Roll your own image

To build your own image, run `sudo docker build -t <image_name> .` in the directory with the Dockerfile after cloning this.

## License

[MIT License](http://opensource.org/licenses/mit-license.html)

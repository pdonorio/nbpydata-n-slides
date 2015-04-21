G# nbpydata-n-slides

This is a docker image:

**Ipython notebook via jupyter with all pydata packages + live slides via notebook**

(available via Public Docker Hub, [here](https://registry.hub.docker.com/u/pdonorio/ipynb_data_slides/))

To work with it you need to have [docker](https://docs.docker.com/installation/) installed in your system.

## Simple launch

```
# Launch jupyter server
docker run -t --name ipy -p 80:8000 pdonorio/ipynb_data_slides

# or Launch jupyter server in background (recommended)
docker run -d --name ipy -p 80:8000 pdonorio/ipynb_data_slides
```

Then go see [http://localhost](http://localhost)

*user*: **pydatanalysis**
*pw*: **workshop**

*Warning*: if you are using '**boot2docker**' on mac/windows, the address may be different.
E.g. on a mac you may run
```
boot2docker ip
# 192.168.59.103
```
to check the ip to use instead of 'localhost'.


## Persistence of notebooks

**Very important**

To share notebooks if you have some, or to avoid notebooks you create from getting destroyed when you remove the container, you need to share a Docker Volume when you launch the container.

```
# Share notebooks in a directory called 'nbs'
docker run -d --name ipy -p 80:8000 -v /path/to/your/notebooks:/home/pydatanalysis/nbs pdonorio/ipynb_data_slides

# At this point when log in, you will find a directory where to save and move your notebooks!
```

## Pause/Unpause the container

```
# Stop the running container
docker stop ipy

# Destroy the container from memory, only if stopped
docker rm ipy

# Restart (if only stopped) the notebook container
docker start ipy
```

## See an example of slides made with ipython notebook

Run the example inside this project
```
git clone https://github.com/pdonorio/nbpydata-n-slides.git mynb
cd mynb
docker run -d --name ipy -p 80:8000 -v $(pwd)/slides:/home/pydatanalysis/sl pdonorio/ipynb_data_slides
```

At this point you may access the example at the web address

[http://localhost/user/pydatanalysis/notebooks/sl/myslides.ipynb](http://localhost/user/pydatanalysis/notebooks/sl/myslides.ipynb)

You should see something like this snapshot:

![notebook with slides](/../screenshots/screens/screen.png?raw=true "Notebook with slideshow")

Press the histogram button on the side of "Cell toolbar", and enjoy!

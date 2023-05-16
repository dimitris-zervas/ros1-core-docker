# ros1-core-docker
Docker images with core ros1 libraries

## Beginners tutorial

Followed the instructions for the beginners tutorial to create the suggested nodes:

* talker
* listener

You can find the tutorial [here](http://wiki.ros.org/ROS/Tutorials/WritingPublisherSubscriber%28python%29).

## Build the docker image

The following command will build and set up a ros environment with the `ros-noetic-ros-base` package. **No GUI tools**.

From the root directory of this repo (where this README file is):

```bash
docker build -t ros1-base .
```

This will build a Docker image whose size is approx. 1.48G.

You can verify that you have the image on your local machine with the following command:

```bash
docker images | grep ros1-base
```

## Run a single container

Now that you built the Docker image, you can create a container out of it with the following command:

```bash
docker run -it --rm -v ${PWD}/src:/home/ros_ws/src ros1-base /bin/bash
```

This above command will **share a volume**. More specifically, the `src` folder of this repo will be shared/common with the `/home/ros_ws/src` folder of the container. That way, you can make changes in your `src` folder from your editor and those changes will be apparent inside the container.

## Get multiple bash terminal sessions from the above container

In ROS you will need multiple terminals to run various commands. To get another bash terminal from the container you created above, first, you need to find its _container id_.

```bash
docker container list
```

The above command will list all the Docker containers that are currently up and running on your local machine. From this list, one row should look similar to:

```bash
10a144370553   ros1-base   "/bin/bash"   5 seconds ago   Up 4 seconds   jovial_dewdney
```

You should look for the name of the image which is `ros1-base`. The first column is the ID we are looking for.

To get a bash terminal from that container, run the following command on a new terminal of your local machine:

```bash
docker exec -it 10a144370553 /bin/bash
```

If you need 3 bash terminals from the container with ID `10a144370553` you should open 3 terminals on your local machine and run the above command to each one of them.

# Test it

To see that everything is set up properly we will need 3 bash terminals from a container created from the image we built, ros1-base.

* Terminal 1: build the beginner_tutorials package and run the roscore.
* Terminal 2: Run the listener node.
* Terminal 3: Run the publisher node.

## Terminal 1

Create the container (in case you didn't before):

```bash
docker run -it --rm -v ${PWD}/src:/home/ros_ws/src ros1-base /bin/bash
```

Once in the container, run the following commands:

```bash
catkin_make
source devel/setup.bash
roscore
```

## Terminal 2

From a new terminal on your local machine, get the container ID as described above. Let's say the ID is `3a3b73e83e57`.

Get a bash terminal from the container we started on Terminal 1, which has ID `3a3b73e83e57``:

```bash
docker exec -it 3a3b73e83e57 /bin/bash
```

Now on this bash terminal, run the _listener_ node:

```bash
source devel/setup.bash
rosrun beginner_tutorials listener.py
```

## Terminal 3

From a new terminal on your local machine, get the container ID as described above. Let's say the ID is `3a3b73e83e57`.

Get a bash terminal from the container we started on Terminal 1, which has ID `3a3b73e83e57``:

```bash
docker exec -it 3a3b73e83e57 /bin/bash
```

Now on this bash terminal, run the _publisher_ node:

```bash
source devel/setup.bash
rosrun beginner_tutorials publisher.py
```






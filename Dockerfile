FROM ubuntu:20.04

RUN apt update

RUN apt install -y software-properties-common curl

RUN add-apt-repository universe
RUN add-apt-repository multiverse
RUN add-apt-repository restricted

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt-get update

# Install full desktop version of ROS
RUN apt install -y ros-noetic-ros-base
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# Dependencies for building packages
RUN apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
RUN rosdep init
RUN rosdep update

# Setup catkin workspace
RUN mkdir -p /home/ros_ws/src
WORKDIR /home/ros_ws

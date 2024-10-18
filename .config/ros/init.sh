#!/bin/zsh

# ROS Noetic
if [ -f /opt/ros/noetic/setup.zsh ]
then
  source /opt/ros/noetic/setup.zsh
  alias catkin_debug="catkin_make -DCMAKE_BUILD_TYPE=Debug"
fi

# ROS Noetic
if [ -f /opt/ros/humble/setup.zsh ]
then
  source /opt/ros/humble/setup.zsh
  alias catkin_debug="catkin_make -DCMAKE_BUILD_TYPE=Debug"
fi

alias rs='source ${ROS_DEVEL_SOURCE}' # Variable must be set in .envrc through direnv

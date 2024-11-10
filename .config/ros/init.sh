#!/bin/zsh

SCRIPT_PATH="${0:A:h}"

# ROS Noetic
if [ -f /opt/ros/noetic/setup.zsh ]
then
  source /opt/ros/noetic/setup.zsh
  alias catkin_debug="catkin_make -DCMAKE_BUILD_TYPE=Debug"
fi

# ROS Noetic
if [ -f /opt/ros/humble/setup.zsh ]
then
  source $SCRIPT_PATH/ros2.humble.zsh
fi


# Alias
alias rs='source ${ROS_OVERLAY_SCRIPT}' # Variable must be set in .envrc through direnv

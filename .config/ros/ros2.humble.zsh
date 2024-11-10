#!/bin/zsh

ROSDISTRO='humble'

# Main Setup
source /opt/ros/${ROSDISTRO}/setup.zsh

# Build Time WIP
alias catkin_debug="catkin_make -DCMAKE_BUILD_TYPE=Debug"

# Colcon
source /usr/share/colcon_cd/function/colcon_cd.sh
export _colcon_cd_root=/opt/ros/${ROSDISTRO}/

# Alias
alias ccb='colcon build --parallel-workers 4'
alias rsdpi='rosdep install -i --from-path src --rosdistro ${ROSDISTRO} -y'

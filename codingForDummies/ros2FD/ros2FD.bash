####### SOURCE STUFFS
echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
echo "export _colcon_cd_root=~/ros2_install" >> ~/.bashrc
echo "export ROS_DOMAIN_ID=<YOUR_ROS_DOMAIN_ID>" >> ~/.bashrc
echo "export ROS_PARTICIPANT_ID=<YOUR_ROS_PARTICIPANT_ID>" >> ~/.bashrc

#################################################

####### Aliases
alias  rosg2='less $(fd ros2FD.bash ~)'
alias rosgg2='less $(fd ros2FD.bash ~) | grep'

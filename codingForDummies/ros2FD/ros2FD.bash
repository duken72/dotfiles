####### Source stuffs
echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
echo "export _colcon_cd_root=~/ros2_install" >> ~/.bashrc
echo "export ROS_DOMAIN_ID=<YOUR_ROS_DOMAIN_ID>" >> ~/.bashrc
echo "export ROS_PARTICIPANT_ID=<YOUR_ROS_PARTICIPANT_ID>" >> ~/.bashrc
#################################################

####### working with packages
ros2 pkg executables <package_name> # check if package installed, return package's executables
ros2 run <package_name> <executable_name> # run an executable from a package
ros2 run <package_name> <executable_name> --ros-args --remap [topic1]:=[topic2]
#################################################

####### ros2 node - working with nodes
ros2 node list
ros2 node info <node_name>
#################################################

####### ros2 topic - working with topics
ros2 topic list [-t] # -t for topic type
ros2 topic echo <topic_name>
ros2 topic info <topic_name>
ros2 topic pub [--rate 1] <topic_name> <msg_type> '<args>' # publish messagge to a topic from CLI, use YAML syntax
ros2 topic hz <topic_name>
#################################################

####### ros2 service - working with services
ros2 service list [-t] # -t for service type
ros2 service type <service_name>
ros2 service find <type_name>
ros2 service call <service_name> <service_type> <arguments> # call service from CLI, use YAML syntax
#################################################

####### ros2 param - working with parameters
ros2 param list
ros2 param get <node_name> <parameter_name>
ros2 param set <node_name> <parameter_name> <value>
ros2 param dump <node_name>
ros2 param load <node_name> <parameter_file>
ros2 run <package_name> <executable_name> --ros-args --params-file <file_name>
#################################################

####### ros2 action - working with actions
ros2 action list [-t]
ros2 action info <action_name>
ros2 action send_goal <action_name> <action_type> <values> [--feedback]
#################################################

####### ros2 interface - showing interface of topic, service, action
ros2 interface show <topic_name>
ros2 interface show <type_name>.srv
ros2 interface show <action_name>
#################################################

rqt_graph
rqt_console || ros2 run rqt_console rqt_console
ros2 run <package_name> <executable_name> --ros-args --log-level WARN

####### ros2 launch
ros2 launch <package_name> <launch_file_name>
#################################################

####### ros2 bag - record and play
mkdir bag_files
cd bag_files
ros2 bag record [-o subset] <topic_name>
ros2 bag info <bag_file_name>
ros2 bag info subset
ros2 bag play subset
#################################################

####### rosdep - dealing with dependencies
cd ws_folder && rosdep install -i --from-path src --rosdistro foxy -y
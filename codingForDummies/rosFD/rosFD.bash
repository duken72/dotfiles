####### Source stuffs
echo "source ~/ws/devel/setup.bash" >> ~/.bashrc

#################################################

####### rospack, roscd, rosls - navigating
# only work with things in ROS_PACKAGE_PATH
echo $ROS_PACKAGE_PATH
rospack find [package_name]
roscd <package-or-stack>[/subdir]
rosls <package-or-stack>[/subdir]
roscd log # folder where ROS stores log files
# if package not found, source it first:
# source catkin_ws/devel/setup.bash
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc

echo $EDITOR # check default editor
rosed [package_name] [filename] # edit files
roscp [package_name] [file_to_copy_path] [copy_path] #copy files
rosmv [package] [filename] [destination] #move files

#################################################

####### rosdep - working with dependencies
rospack depends1 <package_name>/<dependency_name>
rospack depends <package_name>
rosdep check <packages> # check if dependencies have been met
rosdep install <packages> # install dependencies of given packages

#################################################

#######  rosnode, roscore, rosrun, roslaunch - working with nodes 
roscore # master + rosout(stdout/stderr) + parameter server
rosnode list
rosnode info [/node]
rosnode ping ..
rosrun [package_name] [node_name] [__name:=new_name] # run node from a given package
roslaunch [package] [filename.launch] # run multiple nodes, with args, params

####### Create, build and run nodes (Publisher / Subscriber / Service / Client Node)
# 1. Create files src/_.cpp or _.py
# 2. Edit CMakeLists.txt
# 3. Rerun catkin_make at ws_folder

#################################################

####### rostopic, rosmsg - working with topic and message 
rostopic list [-v/-p/-s] # -v verbose, -p only publishers, -s only subscribers
rostopic info [topic]
rostopic hz [topic] #return the rate the data is published
rostopic type [topic] [| rosmsg show] #return message type and its description, example: geometry_msgs/Twist
rostopic echo [topic] [ | tee topic.yaml] # publish to .yaml file
rostopic pub [-1] [topic] [msg_type] [args] # publish data to a topic
# "-1": publish one msg, then exit
# ex: rostopic pub -1 /turtle1/cmd_vel geometry_msgs/Twist -- '[2.0, 0.0, 0.0]' '[0.0, 0.0, 1.8]'

#################################################

####### rosservice - working with services
# Another way that nodes can communicate with each others
# Allow nodes to send a request and receive a response.
rosservice list [-n]
rosservice type [service] [| rossrv show] # See service type and its required input args
rosservice call [service] [args]

#################################################

####### rosparam - working with parameters
rosparam list
rosparam set [param_name] [val]
rosparam get [param_name]
rosparam dump [file.yaml] [namespace]
rosparam load [file.yaml] [namespace]

#################################################

####### Examine stuffs
rqt_graph # Nodes Graph (rosrun rqt_graph rqt_graph)
rqt_plot # A scrolling time plot of the data published on topics. (rosrun rqt_plot rqt_plot)
rqt_console # Check ROS info, error, warn, debug, fatal ..
rqt_logger_level # rosrun rqt_logger_level rqt_logger_level

#################################################

####### rosmsg, rossrv - working with ROS msg and srv
# 1. Create files msg/_.msg, srv/_.srv 
# 2. Edit package.xml and CMakeLists.txt
# 3. catkin_make # At /catkin_ws, remake the package to apply
rosmsg show [msgType] # msgType = packageName/nameOfMessage or just nameOfMessage
# ex: rosmsg show beginner_tutorials/Num -> int64 num
rosmsg package [packageName] #list messages in a package
rossrv show [packageName/srvtype]
# ex: rossrv show beginner_tutorials/AddTwoInts
rossrv package [packageName] #list services in a package

#################################################

####### rosbag - Recording and Play
mkdir && cd _/bagfiles
rosbag record -a # record all
rosbag record -O [subset_name] [topic_n] ..
<time> rosbag info <your bagfile> [| grep -E "(topic7|topic2)"] # show info: date, #no. messages each topics ..
<time> rosbag play [-r rate] [--immediate] <your bagfile> [--topics /topic2 /topic7..]
#won't be perfectly mimicked, --immediate open as quickly as possible
ros_readbagfile <bagfile.bag> [topic7] [topic2] [| tee topics.yaml]
# using ros_readbagfile because rostopic can only read 1 topic at a time and slower
# rostopic echo -b large_bag_file /topic1

####### roswtf
roswtf # Checking installation, try online and find errors

####### ROS Action
roscd [pkg_folder]; rosrun actionlib_msgs genaction.py -o msg/ action/File.action #manually generate message from .action file
catkin_make #automatically generate .msg and .h file, after adding stuffs to CMakeLists.txt
rostopic list [-v] | grep goal #find the action goal topic
rostopic pub /topicName/goal [TAB] [TAB] #publish goal to that topic
rosrun actionlib_tools axclient.py /name_of_the_action #another GUI to manualy change action goal
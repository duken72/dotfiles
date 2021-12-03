## Generate message from .action file
# Manually:
roscd [pkg_folder]
rosrun actionlib_msgs genaction.py -o msg/ action/File.action
# Automatically:
# After adding stuffs to CMakeLists.txt
catkin_make


## Send a Goal to Action Server without Action Client

# Find the goal topic in the topic list
rostopic list [-v] | grep goal
# Publish to that topic
# 1. Find the template to publish
rostopic pub /topic_name/goal [TAB] [TAB]

rosrun actionlib_tools axclient.py /name_of_the_action

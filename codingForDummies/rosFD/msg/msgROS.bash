# ROS msg
# 1. Create .msg file: catkin_ws/src/packageName/msg/Name.msg
# 2. Add dependencies to package.xml in ws_folder, not msg/
#   <build_depend>message_generation</build_depend>
#   <exec_depend>message_runtime</exec_depend>
# 3. Add stuffs to CMakeLists.txt in ws_folder, not msg/
# find_package(catkin REQUIRED COMPONENTS
#   ...
#   message_generation 
#   ...
# )
# catkin_package(
#   CATKIN_DEPENDS message_runtime ...)
# add_message_files(
#   FILES
#   Name.msg)
# generate_messages(
#   DEPENDENCIES
#   std_msgs)
catkin_make # At /catkin_ws, remake the package to apply


rosmsg show [msgType] 
# msgType = packageName/nameOfMessage or just nameOfMessage
# ex: rosmsg show beginner_tutorials/Num -> int64 num
rosmsg package [packageName] #list messages in a package

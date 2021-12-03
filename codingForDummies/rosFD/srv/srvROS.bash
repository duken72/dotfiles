# ROS srv
# 1. Create .srv file: catkin_ws/src/packageName/srv/Name.srv
# 2. Add dependencies to package.xml
#   <build_depend>message_generation</build_depend>
#   <exec_depend>message_runtime</exec_depend>
# 3. Add stuffs to CMakeLists.txt
# find_package(catkin REQUIRED COMPONENTS
#   message_generation ...)
# catkin_package(
#   CATKIN_DEPENDS message_runtime ...)
# add_service_files(
#   FILES
#   Name.srv
# )
# generate_messages(
# DEPENDENCIES
# std_msgs
# )

rossrv show [packageName/srvtype]
# ex: rossrv show beginner_tutorials/AddTwoInts
rossrv package [packageName] #list services in a package

catkin_make # At /catkin_ws, remake the package to apply

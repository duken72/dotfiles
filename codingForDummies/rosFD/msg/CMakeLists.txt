find_package(catkin REQUIRED COMPONENTS
  ...
  message_generation
  ...
)

catkin_package(
  ...
  CATKIN_DEPENDS message_runtime ...
  ...
)

add_message_files(
   FILES
   Message1.msg
   Message2.msg
)

generate_messages(
  DEPENDENCIES
  std_msgs
)

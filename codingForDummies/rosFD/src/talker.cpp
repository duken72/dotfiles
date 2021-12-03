#include "ros/ros.h"
#include "std_msgs/String.h"

#include <sstream>

int main(int argc, char **argv)
{
  ros::init(argc, argv, "talker"); #Init ROS and node names
  ros::NodeHandle n;

  // Tell the master that a message of type std_msgs/String will be published on TOPIC chatter
  ros::Publisher chatter_pub = n.advertise<std_msgs::String>("chatter", 1000);

  ros::Rate loop_rate(10);

  int count = 0;
  while (ros::ok())
  {
    //This is a message object. You stuff it with data, and then publish it.
    std_msgs::String msg;

    std::stringstream ss;
    ss << "hello world " << count;
    msg.data = ss.str();

    ROS_INFO("%s", msg.data.c_str());

    chatter_pub.publish(msg); //msg published

    ros::spinOnce();

    loop_rate.sleep();
    ++count;
  }

  return 0;
}

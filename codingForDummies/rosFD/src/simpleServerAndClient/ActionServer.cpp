#include <chores/DoDishesAction.h>  // Note: "Action" is appended
#include <actionlib/server/simple_action_server.h>

typedef actionlib::SimpleActionServer<chores::DoDishesAction> Server; // Declare server

void execute(const chores::DoDishesGoalConstPtr& goal, Server* as)  
// Note: "Action" is not appended to DoDishes here
{
  // 'as' is a pointer to the Server?
  // this 'execute' function takes in the goal, and do sth here
  as->setSucceeded();
}

int main(int argc, char** argv)
{
  ros::init(argc, argv, "do_dishes_server");
  ros::NodeHandle n;
  Server server(n, "do_dishes", boost::bind(&execute, _1, &server), false);
  server.start();
  ros::spin();
  return 0;
}

#include <chores/DoDishesAction.h> // Note: "Action" is appended
// chores as package_name with action
#include <actionlib/client/simple_action_client.h>

typedef actionlib::SimpleActionClient<chores::DoDishesAction> Client;

int main(int argc, char** argv)
{
  ros::init(argc, argv, "do_dishes_client"); // Init some shit
  Client client("do_dishes", true); // true -> don't need ros::spin()
  client.waitForServer(); // Wait
  chores::DoDishesGoal goal; // Declare variable goal
  // Fill in goal here
  client.sendGoal(goal); // well .. Client sends goal, as .. publish the goal message??
  client.waitForResult(ros::Duration(5.0));
  if (client.getState() == actionlib::SimpleClientGoalState::SUCCEEDED)
    printf("Yay! The dishes are now clean");
  printf("Current State: %s\n", client.getState().toString().c_str());
  return 0;
}

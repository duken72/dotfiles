#include "ros/ros.h"
#include "package/headerFile.h"
#include "msgs/MsgHeader.h"
#include <package/NameAction.h>
#include <actionlib/client/simple_action_client.h>
#include <lib>

bool callbackFuncSrv(package::ServiceName::Request &req.
		  package::ServiceName::Response &res)
{
	res.res1 = func(req.req1 + req.req2);
	cmd;
	return true;
}

void callbackFuncSub(msg_type::ConstPtr& msg_)
{
	cmd;
	ROS_INFO("..");
}

void callbackFuncAct(const package::NameGoalConstPtr& goal_, Server* action_server_)
{
	cmd;
	action_server_->setSucceeded();
}

int main(int argc, char **argv)
{
	ros::init(argc, argv, "node_name");
	cmd;
	
	ros::NodeHandle nh_;
	
	// Publisher node
	ros::Publisher publisher_object_ = nh_.advertise<msg_type>("topic_name", 1000);
	ros::Rate loop_rate(10);
	while(ros::ok())
	{
		msg_type msg_;
		type content;
		content << 1; // sth into content
		msg_.data = content;
		publisher_object_.publish(msg_);
		ros::spinOnce();		
	}
	// ----------------------------

	// Subscriber node
	ros::Subscriber subscriber_object_ = nh_.subscribe("topic_name", 1000, callbackFuncSub);
	ros::spin();
	// ----------------------------

	// Service node
	ros::ServiceServer service_object_ = nh_.advertiseService("service_name", callbackFuncSrv);
	ros::spin();	
	// ----------------------------

	// Client node - calling service
	ros::ServiceClient client_object_ = nh_.serviceClient<package::ServiceName>("service_name");
	package::ServiceName srv_object_;
	srv_object.request.req1 = atoll(argv[1]);
	srv_object.request.req2 = atoll(argv[2]);
	if (client_object_.call(srv_object_))
	{
		cmd;
		ROS_INFO("Response: %ld", (int)srv_object_.response.res1);
	}
	// ----------------------------

	// Action Server node
	actionlib::SimpleActionServer<package::NameAction> server_object_(nh_, boost::bind(&callbackFuncAct, _1, &server_object_), false);
	server_object_.start();
	// can put the above into a class NameAction
	ros::spin();
	// ----------------------------

	// Action Client node
	actionlib::SimpleActionClient<package::NameAction> client_object_("action_name", true); //true => don't need ros::spin();
	client_object_.waitForServer();
	package::NameGoal goal_;
	goal_.goal1 = 2;
	goal_.goal2 = 7;
	client_object_.sendGoal(goal_);
	client_object_.waitForResult(ros::Duration(7.2));
	if (client_object_.getState() == actionlib::SimpleClientGoalState::SUCCEEDED)
		cmd;
	cmd;
	// ----------------------------

	return 0;	
}

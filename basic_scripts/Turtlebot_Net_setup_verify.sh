#restart ros services
sudo service turtlebot stop
sudo service turtlebot start 
# make sure it can contact ROS master 
rostopic list
#make sure ROS_MASTER_URI is set correctly 
echo $ROS_MASTER_URI


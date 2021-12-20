#!/usr/bin/env python3

"""
<+ ROS node docs +>
"""

import rospy
import signal
from sys import exit
from ros_utils import ChiroLock


UPDATE_HZ = 30


def main():
    # Connect to ROS
    rospy.init_node("<+ node name +>", anonymous=True)

    # Read params
    is_enabled = rospy.get_param("~enable_foo", True)
    foo_publisher = rospy.Publisher("some_topic", Type, queue_size=1)

    # TODO: Create library objects
    node = Node(<+ node params +>)

    # Lock callbacks to avoid data races
    lock = ChiroLock()
    set_speed_low = lock(node.set_speed_low)
    on_obstacle = lock(node.on_obstacle)
    tick = lock(node.tick)

    # Clean up at the end
    signal.signal(signal.SIGINT, signal_handler)

    # Start work
    rospy.Service("set_speed_low", Trigger, set_speed_low)
    rospy.Subscriber("obstacle_detected_front", Bool, on_obstacle, queue_size=1)

    def shutdown():
        print("Shutting down...")
        pass

    try:
        rate = rospy.Rate(UPDATE_HZ)
        while not rospy.is_shutdown():
            tick()
            rate.sleep()

    finally:
        shutdown()


def signal_handler(sig, frame):
    print("You pressed Ctrl+C!")
    exit(0)


if __name__ == "__main__":
    main()

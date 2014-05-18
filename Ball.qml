import QtQuick 2.0

Rectangle {
    id: ball
    width: 25;
    height: width
    radius: width / 2
    color: "yellow"
    z: 1

    // Properties holding the values of the screen boundaries
    property int leftBoundary : 0
    property int rightBoundary : 640
    property int topBoundary : 0
    property int bottomBoundary : 360

    // Holds the flag animating the ball
    property bool animate: false

    // The ball will move infinitely
    SequentialAnimation on x {
        id: ballAnimation
        loops: Animation.Infinite
        running: animate

        NumberAnimation {
            to: rightBoundary - ball.width;
            duration: 2000
        }
        NumberAnimation {
            to: leftBoundary;
            duration: 2000
        }
    }

    // Set the velocity on Y to 200
    Behavior on y {
        SpringAnimation{
            velocity: 200;
        }
    }
}

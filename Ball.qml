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

    // Move the ball to the right and back to the left repeatedly
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

    // Make y move with a velocity of 200
    Behavior on y {
        SpringAnimation{
            velocity: 100;
        }
    }

    /*
    // Detect the ball hitting the top or bottom of the view and bounce it
    onYChanged: {
        if (y <= 0) {
            y = bottomBoundary - ball.height;
        } else if (y >= bottomBoundary - ball.height) {
            y = 0;
        }
    }
    */
}

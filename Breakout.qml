import QtQuick 2.0

import "js/utils.js" as Utils

Rectangle {
    id: root
    width: 640
    height: 480
    focus: true

    property bool hasStarted : false

    // Key actions
    Keys.onLeftPressed: bar.move(-10)
    Keys.onRightPressed: bar.move(10)
    Keys.onSpacePressed: {
        if (!hasStarted){
            // Start the ball animation
            ball.animate = true

            // And make it move towards the top
            ball.y = 0

            // Set the flag indicating that the game has started
            hasStarted = true
            console.log("start")
        }
    }

    // Create the bricks
    Grid{
        columns: 12
        rows: 3
        spacing: 4
        Repeater {
            model: 36
            Brick{
                id: brick
                color: brick.colorArray[Math.floor(Math.random()*4)]
            }
        }
    }

    // Create the bar
    Bar {
        id: bar

        // Define the limits between which the bar can move
        leftBoundary: 0
        rightBoundary: root.width

        // Define the original position
        x: (root.width - bar.width) / 2
        y: root.height - 40
    }


    // Create the ball
    Ball {
        id: ball

        // Define the limits against which the ball will bounce
        leftBoundary: 0
        rightBoundary: root.width
        topBoundary: 0
        bottomBoundary: root.height

        // Define the original position
        x: (root.width - ball.width) / 2
        y: root.height - ball.height - 40

        // Detect the ball hitting the top or bottom of the view and bounce it
        onYChanged: {
            if (Utils.detectColision(ball, bar)) {
                // Send the ball to the top of the screen if it hits the bar
                console.log("colision")
                ball.y = 0;
            } else if (ball.y <= 0) {
                // Send the ball to the bottom of the screen if it hits the top of the screen
                ball.y = root.height - ball.height;
            } else  if (ball.y >= root.height - ball.height){
                // If you go to far down you lose
                ball.animate = false
                lost.visible = true
            }
        }
    }

    Text{
        id: lost
        anchors.centerIn: root
        text: "You lost!"
        font.pointSize: 48
        color: "red"
        visible: false
    }
}

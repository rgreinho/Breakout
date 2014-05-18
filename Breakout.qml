import QtQuick 2.0

Rectangle {
    id: root
    width: 640
    height: 360
    focus: true

    // Key actions
    Keys.onLeftPressed: bar.move(-10)
    Keys.onRightPressed: bar.move(10)
    Keys.onSpacePressed: {
        // Start the ball animation
        ball.animate = true

        // And make it move towards the top
        ball.y = 0
        console.log("start")
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

    /*
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
    }
    */

    // Make a ball to bounce
    Rectangle {
        id: ball

        width: 20
        height: width
        radius: width / 2
        x: (root.width - ball.width) / 2
        y: root.height - ball.height - 40
        z: 1
        color: "Yellow"

        property bool animate: false

        // Move the ball to the right and back to the left repeatedly
        SequentialAnimation on x {
            loops: Animation.Infinite
            running: ball.animate
            NumberAnimation {
                to: root.width - ball.width
                duration: 2000
            }
            NumberAnimation {
                to: 0
                duration: 2000
            }
        }

        // Set the velocity on Y
        Behavior on y {
            SpringAnimation{
                velocity: 50
            }
        }

        //Component.onCompleted: y = root.height-10; // start the ball motion

        // Detect the ball hitting the top or bottom of the view and bounce it
        onYChanged: {
            if (detectColision(ball, bar)) {
            //if (ball.y >= root.height - ball.height){
                console.log("colision")
                ball.y = 0;
            } else if (ball.y <= 0) {
                ball.y = root.height - ball.height;
            }
            /*
            else {
                ball.y = -1
            }
            */
        }
    }

    function detectColision(rectangleA, rectangleB){
        return rectangleA.x < (rectangleB.x + rectangleB.width)
                && (rectangleA.x + rectangleA.width) > rectangleB.x
                && rectangleA.y < (rectangleB.y + rectangleB.height)
                && (rectangleA.y + rectangleA.height) > rectangleB.y
    }
}

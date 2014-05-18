import QtQuick 2.0

Rectangle {
    width: 100;
    height: 25
    color: "blue"

    property int leftBoundary : 0
    property int rightBoundary : 100

    function move(distance){
        // If distance is negative, move left until we the left boundary.
        // If distance is positive, move right until we reach the right boundary.
        if (((distance < 0) && (x > leftBoundary))
                ||  ((distance > 0) && (x < (rightBoundary - width)))){
            x = x + distance
        }
    }

    Behavior on x {
        NumberAnimation { duration: 10 }
    }
}

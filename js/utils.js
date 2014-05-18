/*
    Detects the colision between 2 rectangles.
*/
function detectColision(rectangleA, rectangleB){
    return rectangleA.x < (rectangleB.x + rectangleB.width)
            && (rectangleA.x + rectangleA.width) > rectangleB.x
            && rectangleA.y < (rectangleB.y + rectangleB.height)
            && (rectangleA.y + rectangleA.height) > rectangleB.y
}

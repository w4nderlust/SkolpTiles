# SkolpShapes
Processing script for generating abstract shapes in the style of [Skolp](https://www.flickr.com/photos/nicoskolp)

## How it works

![Interface](http://i.imgur.com/Q6bynAE.png)

The script generates a number of rectangles (rows x columns) then connects them with rectangles of alternating colors and finishes the full shape with quads on the outer part.

The rist paramers regulates the four colors of the hexagons, the color of the rectangles and the color of the background.

![Colors](http://i.imgur.com/tp37pBl.jpg)

The ROWS and COLS parameters regulate the number of rectangles in the shape.

![Matrix](http://i.imgur.com/d3wp0Gu.jpg)

MARGIN_RECT and MARGIN_POINT regulate the margin of the rectangle inside its box container and margin for of the vertex of the exagons inside the rectangle built from the sorrounding ractangle shapes.

![Margins](http://i.imgur.com/W7d97HR.jpg)

RECT_WIDTH and RECT_HEIGHT regulates the ranges of variability of the dimensions of the rectangles expressed in percentage of the available space in the box minus the margin.

![Rect](http://i.imgur.com/wQLkKh7.jpg)

PADDING and EXTERNAL regulates the amount of space aroung the shape and the position of the external points.

![External](http://i.imgur.com/QWuTuny.jpg)

The orientation of the gradient is regulated by nine radio buttons.

![Gradient_Orientation](http://i.imgur.com/KW1fef8.jpg)

HUE_SHIFT regulates the amount of shift on the hue wheel of the gradient. Higher values means higher shift.

![Hue_shift](http://i.imgur.com/OdsJomp.jpg)

LEFT and RIGHT regulate the direction of the shift.

![Hue_left_right](http://i.imgur.com/BGuX1Zx.jpg)

## License

The script in released under MIT license

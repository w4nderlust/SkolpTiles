public int window_width = 700;
public int window_height= 700;

public int shape_x = 50;
public int shape_y = 50;
public int shape_width = 600;
public int shape_height = 600;
public int matrix_width = 3; //min 2
public int matrix_height = 4; // min 2

public float min_rect_width = 0.2;
public float max_rect_width = 0.6;
public float min_rect_height = 0.2;
public float max_rect_height = 0.6;

public float percent_margin_rect = 0.05;
public float percent_margin_point = 0.15;

public float percent_min_external = 0.1;
public float percent_max_external = 0.5;

public color col1 = color(219, 187, 84);
public color col2 = color(93, 52, 64);
public color col3 = color(181, 114, 84);
public color col4 = color(34, 34, 45);

public Rectangle[][] rect_matrix = new Rectangle[matrix_width][matrix_height];
public Point[][] point_matrix = new Point[matrix_width + 1][matrix_height + 1];

public color white = color(255, 255, 255);
public color black = color(0, 0, 0);
public color grey = color(192, 192, 192);
public color green = color(0, 255, 0);
public color midGrey = color(128, 128, 128);
public boolean shouldRandomize = true;



void setup() {
  size(window_width, window_height, OPENGL);
  colorMode(HSB, 360, 100, 100, 1);
}

void draw() {
  background(grey);
  if (shouldRandomize) {
    randomizeShape();
    shouldRandomize = false;
  }
  drawShape();
}

void randomizeShape() {
  int x_range = shape_width / matrix_width;
  int y_range = shape_height / matrix_height;

  for (int i = 0; i < matrix_width; i++) {
    for (int j = 0; j < matrix_height; j++) {
      int w = (int) random(min_rect_width * x_range, max_rect_width * x_range);
      int h = (int) random(min_rect_height * y_range, max_rect_height * y_range);

      int min_pos_x = shape_x + (i * x_range) + (int) (percent_margin_rect * (x_range - w));
      int max_pos_x = shape_x + ((i + 1) * x_range) - w - (int) (percent_margin_rect * (x_range - w));
      int min_pos_y = shape_y + (j * y_range) + (int) (percent_margin_rect * (y_range - h));
      int max_pos_y = shape_y + ((j + 1) * y_range) - h - (int) (percent_margin_rect * (y_range - h));

      int ax = (int) random(min_pos_x, max_pos_x);
      int ay = (int) random(min_pos_y, max_pos_y);
      int aw = w;
      int ah = h;
      rect_matrix[i][j] = new Rectangle(ax, ay, aw, ah);

      if (i > 0 && j > 0) {
        Rectangle no = rect_matrix[i-1][j-1];
        Rectangle ne = rect_matrix[i][j-1];
        Rectangle so = rect_matrix[i-1][j];
        Rectangle se = rect_matrix[i][j];

        int min_pos_x_point = max(no.x + no.w, so.x + so.w);
        int max_pos_x_point = min(ne.x, se.x);
        int min_pos_y_point = max(no.y + no.h, ne.y + ne.h);
        int max_pos_y_point = min(so.y, se.y);
        int range_x = max_pos_x_point - min_pos_x_point;
        int range_y = max_pos_y_point - min_pos_y_point;

        point_matrix[i][j] = new Point(
        (int) random(min_pos_x_point + (range_x * percent_margin_point), 
        max_pos_x_point - (range_x * percent_margin_point)), 
        (int) random(min_pos_y_point + (range_y * percent_margin_point), 
        max_pos_y_point - (range_y * percent_margin_point)));

        if (i == 1 && j == 1) {
          int min_range_x = no.x - (int) (no.x * percent_max_external);
          int max_range_x = no.x - (int) (no.x * percent_min_external);
          int min_range_y = no.y - (int) (no.y * percent_max_external);
          int max_range_y = no.y - (int) (no.y * percent_min_external);
          point_matrix[0][0] = new Point(
          (int) random(min_range_x, max_range_x), 
          (int) random(min_range_y, max_range_y));
        }
        if (j == 1) {
          int min_range_y = min(no.y, ne.y) - (int) (min(no.y, ne.y) * percent_max_external);
          int max_range_y = min(no.y, ne.y) - (int) (min(no.y, ne.y) * percent_min_external);
          point_matrix[i][0] = new Point(
          (int) random(no.x + no.w, ne.x), 
          (int) random(min_range_y, max_range_y));
        }
        if (i == matrix_width - 1 && j == 1) {
          int min_range_x = ne.x + ne.w + (int) ((window_width - (ne.x + ne.w)) * percent_min_external);
          int max_range_x = ne.x + ne.w + (int) ((window_width - (ne.x + ne.w)) * percent_max_external);
          int min_range_y = ne.y - (int) (ne.y * percent_max_external);
          int max_range_y = ne.y - (int) (ne.y * percent_min_external);
          point_matrix[matrix_width][0] = new Point(
          (int) random(min_range_x, max_range_x), 
          (int) random(min_range_y, max_range_y));
        }
        if (i == matrix_width -1) {
          int min_range_x = max(ne.x + ne.w, se.x + se.w) + (int) ((window_width - max(ne.x + ne.w, se.x + se.w)) * percent_min_external);
          int max_range_x = max(ne.x + ne.w, se.x + se.w) + (int) ((window_width - max(ne.x + ne.w, se.x + se.w)) * percent_max_external);
          point_matrix[matrix_width][j] = new Point(
          (int) random(min_range_x, max_range_x), 
          (int) random(ne.y + ne.h, se.y));
        }
        if (i == matrix_width - 1 && j == matrix_height - 1) {
          int min_range_x = se.x + se.w + (int) ((window_width - (se.x + se.w)) * percent_min_external);
          int max_range_x = se.x + se.w + (int) ((window_width - (se.x + se.w)) * percent_max_external);
          int min_range_y = se.y + se.h + (int) ((window_height - (se.y + se.h)) * percent_min_external);
          int max_range_y = se.y + se.h + (int) ((window_height - (se.y + se.h)) * percent_max_external);
          point_matrix[matrix_width][matrix_height] = new Point(
          (int) random(min_range_x, max_range_x), 
          (int) random(min_range_y, max_range_y));
        }
        if (j == matrix_height - 1) {
          int min_range_y = max(so.y + so.w, se.y + so.w) + (int) ((window_height - max(so.y + so.w, se.y + so.w)) * percent_min_external);
          int max_range_y = max(so.y + so.w, se.y + so.w) + (int) ((window_height - max(so.y + so.w, se.y + so.w)) * percent_max_external);
          point_matrix[i][matrix_height] = new Point(
          (int) random(so.x + so.w, se.x), 
          (int) random(min_range_y, max_range_y));
        }
        if (i == 1 && j == matrix_height - 1) {
          int min_range_x = so.x - (int) (so.x * percent_max_external);
          int max_range_x = so.x - (int) (so.x * percent_min_external);
          int min_range_y = so.y + so.h + (int) ((window_height - (so.y + so.h)) * percent_min_external);
          int max_range_y = so.y + so.h + (int) ((window_height - (so.y + so.h)) * percent_max_external);
          point_matrix[0][matrix_height] = new Point(
          (int) random(min_range_x, max_range_x), 
          (int) random(min_range_y, max_range_y));
        }
        if (i == 1) {
          int min_range_x = min(so.x, no.x) - (int) (min(so.x, no.x) * percent_max_external);
          int max_range_x = min(so.x, no.x) - (int) (min(so.x, no.x) * percent_min_external);
          point_matrix[0][j] = new Point(
          (int) random(min_range_x, max_range_x), 
          (int) random(no.y + no.h, so.y));
        }
      }
    }
  }
}

void drawShape() {
  for (int i = 0; i < matrix_width; i++) {
    for (int j = 0; j < matrix_height; j++) {
      if (i > 0 && j > 0) {
        boolean pair = (i + j) % 2 == 0;

        Point p = point_matrix[i][j];
        Point pn = point_matrix[i][j-1];
        Point pe = point_matrix[i+1][j];
        Point ps = point_matrix[i][j+1];
        Point po = point_matrix[i-1][j];

        Rectangle no = rect_matrix[i-1][j-1];
        Rectangle ne = rect_matrix[i][j-1];
        Rectangle so = rect_matrix[i-1][j];
        Rectangle se = rect_matrix[i][j];

        if (pair) {
          fill(col2);
        } else {
          fill(col1);
        }
        beginShape();
        vertex(no.x + no.w, no.y + no.h);
        vertex(no.x + no.w, no.y);
        vertex(pn.x, pn.y);
        vertex(ne.x, ne.y);
        vertex(ne.x, ne.y + ne.h);
        vertex(p.x, p.y);
        endShape();
        
        if (pair) {
          fill(col3);
        } else {
          fill(col4);
        }
        beginShape();
        vertex(ne.x, ne.y + ne.h);
        vertex(ne.x + ne.w, ne.y + ne.h);
        vertex(pe.x, pe.y);
        vertex(se.x + se.w, se.y);
        vertex(se.x, se.y);
        vertex(p.x, p.y);
        endShape();
        
        
        if (pair) {
          fill(col1);
        } else {
          fill(col2);
        }
        beginShape();
        vertex(se.x, se.y);
        vertex(se.x, se.y + se.h);
        vertex(ps.x, ps.y);
        vertex(so.x + so.w, so.y + so.h);
        vertex(so.x + so.w, so.y);
        vertex(p.x, p.y);
        endShape();
        
        if (pair) {
          fill(col4);
        } else {
          fill(col3);
        }
       beginShape();
        vertex(so.x + so.w, so.y);
        vertex(so.x, so.y);
        vertex(po.x, po.y);
        vertex(no.x, no.y + no.h);
        vertex(no.x + no.w, no.y + no.h);
        vertex(p.x, p.y);
        endShape();

        // External
        if (i == 1 && j == 1) {
          Point angle = point_matrix[0][0];
          Point ep = point_matrix[0][j];
          if (pair) {
            fill(col1);
          } else {
            fill(col2);
          }
          quad(angle.x, angle.y, ep.x, ep.y, no.x, no.y + no.h, no.x, no.y);
        }
        if (j == 1) {
          Point prev = point_matrix[i-1][0];
          Point ep = point_matrix[i][0];

          if (pair) {
            fill(col3);
          } else {
            fill(col4);
          }
          quad(prev.x, prev.y, ep.x, ep.y, no.x + no.w, no.y, no.x, no.y);
        }
        if (i == matrix_width - 1 && j == 1) {
          Point angle = point_matrix[matrix_width][0];
          Point ep = point_matrix[i][0];

          if (pair) {
            fill(col4);
          } else {
            fill(col3);
          }
          quad(ep.x, ep.y, angle.x, angle.y, ne.x + ne.w, ne.y, ne.x, ne.y);
        }
        if (i == matrix_width - 1) {
          Point prev = point_matrix[matrix_width][j - 1];
          Point ep = point_matrix[matrix_width][j];

          if (pair) {
            fill(col1);
          } else {
            fill(col2);
          }
          quad(prev.x, prev.y, ep.x, ep.y, ne.x + ne.w, ne.y + ne.h, ne.x + ne.w, ne.y);
        }
        if (i == matrix_width - 1 && j == matrix_height - 1) {
          Point angle = point_matrix[matrix_width][matrix_height];
          Point ep = point_matrix[matrix_width][j];

          if (pair) {
            fill(col2);
          } else {
            fill(col1);
          }
          quad(ep.x, ep.y, angle.x, angle.y, se.x + se.w, se.y + se.h, se.x + se.w, se.y);
        }
        if (j == matrix_height - 1) {
          Point prev = point_matrix[i + 1][matrix_height];
          Point ep = point_matrix[i][matrix_height];

          if (pair) {
            fill(col4);
          } else {
            fill(col3);
          }
          quad(ep.x, ep.y, prev.x, prev.y, se.x + se.w, se.y + se.h, se.x, se.y + se.h);
        }
        if (i == 1 && j == matrix_height - 1) {
          Point angle = point_matrix[0][matrix_height];
          Point ep = point_matrix[i][matrix_height];

          if (pair) {
            fill(col3);
          } else {
            fill(col4);
          }
          quad(ep.x, ep.y, angle.x, angle.y, so.x, so.y + so.h, so.x + so.w, so.y + so.h);
        }
        if (i == 1) {
          Point prev = point_matrix[0][j + 1];
          Point ep = point_matrix[0][j];

          if (pair) {
            fill(col2);
          } else {
            fill(col1);
          }
          quad(ep.x, ep.y, prev.x, prev.y, so.x, so.y + so.h, so.x, so.y);
        }
      }
    }
  }
  for (int i = 0; i < matrix_width + 1; i++) {
    for (int j = 0; j < matrix_height + 1; j++) {
      Point p = point_matrix[i][j];
      p.rollover(mouseX, mouseY);
      p.drag(mouseX, mouseY);
      p.display();
    }
  }
  for (int i = 0; i < matrix_width; i++) {
    for (int j = 0; j < matrix_height; j++) {
      Rectangle rect = rect_matrix[i][j];
      fill(white);
      noStroke();
      rect.rollover(mouseX, mouseY);
      rect.drag(mouseX, mouseY);
      rect.display();
    }
  }
}

void keyPressed() {
  shouldRandomize = true;
}

void mousePressed() {
  for (int i = 0; i < matrix_width; i++) {
    for (int j = 0; j < matrix_height; j++) {
      rect_matrix[i][j].clicked(mouseX, mouseY);
    }
  }
  for (int i = 0; i < matrix_width + 1; i++) {
    for (int j = 0; j < matrix_height + 1; j++) {
      point_matrix[i][j].clicked(mouseX, mouseY);
    }
  }
}

void mouseReleased() {
  for (int i = 0; i < matrix_width; i++) {
    for (int j = 0; j < matrix_height; j++) {
      rect_matrix[i][j].stopDragging();
    }
  }
  for (int i = 0; i < matrix_width + 1; i++) {
    for (int j = 0; j < matrix_height + 1; j++) {
      point_matrix[i][j].stopDragging();
    }
  }
}




class Rectangle {
  public int x;
  public int y;
  public int w;
  public int h;

  boolean dragging = false; // Is the rectangle being dragged?
  boolean rollover = false; // Is the mouse over the rectangle?

  int offsetX, offsetY; // Mouseclick offset

  Rectangle(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    offsetX = 0;
    offsetY = 0;
  }

  // Method to display
  void display() {
    if (dragging || rollover) {
      stroke(midGrey);
      strokeWeight(5);
    } else {
      noStroke();
    }
    fill(white);
    rect(x, y, w, h);
    noStroke();
  }

  // Is a point inside the rectangle (for click)?
  void clicked(int mx, int my) {
    if (mx > x && mx < x + w && my > y && my < y + h) {
      dragging = true;
      // If so, keep track of relative location of click to corner of rectangle
      offsetX = x-mx;
      offsetY = y-my;
    }
  }

  // Is a point inside the rectangle (for rollover)
  void rollover(int mx, int my) {
    if (mx > x && mx < x + w && my > y && my < y + h) {
      rollover = true;
    } else {
      rollover = false;
    }
  }

  // Stop dragging
  void stopDragging() {
    dragging = false;
  }

  // Drag the rectangle
  void drag(int mx, int my) {
    if (dragging) {
      x = mx + offsetX;
      y = my + offsetY;
    }
  }
}

class Point {
  public int x;
  public int y;

  boolean dragging = false; // Is the rectangle being dragged?
  boolean rollover = false; // Is the mouse over the rectangle?

  int offsetX, offsetY; // Mouseclick offset

  public Point(int x, int y) {
    this.x = x;
    this.y = y;
    offsetX = 0;
    offsetY = 0;
  }

  // Method to display
  void display() {
    if (dragging || rollover) {
      stroke(midGrey);
      strokeWeight(5);
      noFill();
      ellipse(x, y, 20, 20);
      noStroke();
    }
  }

  // Is a point inside the rectangle (for click)?
  void clicked(int mx, int my) {
    if (mx > x - 10 && mx < x + 10 && my > y - 10 && my < y + 10) {
      dragging = true;
      // If so, keep track of relative location of click to corner of rectangle
      offsetX = x-mx;
      offsetY = y-my;
    }
  }

  // Is a point around the point (for rollover)
  void rollover(int mx, int my) {
    if (mx > x - 10 && mx < x + 10 && my > y - 10 && my < y + 10) {
      rollover = true;
    } else {
      rollover = false;
    }
  }

  // Stop dragging
  void stopDragging() {
    dragging = false;
  }

  // Drag the rectangle
  void drag(int mx, int my) {
    if (dragging) {
      x = mx + offsetX;
      y = my + offsetY;
    }
  }
}


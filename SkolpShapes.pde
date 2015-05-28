public int widnow_width = 700;
public int window_height= 700;

public int shape_x = 50;
public int shape_y = 50;
public int shape_width = 600;
public int shape_height = 600;
public int matrix_width = 4; //min 2
public int matrix_height = 4; // min 2

public int min_rect_width = 20;
public int max_rect_width = 80;
public int min_rect_height = 20;
public int max_rect_height = 80;

public color col1 = color(34, 34, 45);
public color col2 = color(181, 114, 84);
public color col3 = color(93, 52, 64);
public color col4 = color(219, 187, 84);

public float percent_margin_rect = 0.01;
public float percent_margin_point = 0.15;

public Rectangle[][] rect_matrix = new Rectangle[matrix_width][matrix_height];
public Point[][] point_matrix = new Point[matrix_width - 1][matrix_height - 1];

public color white = color(255, 255, 255);
public color black = color(0, 0, 0);
public color grey = color(192, 192, 192);
public color green = color(0, 255, 0);
public boolean shouldRandomize = true;



void setup() {
  size(widnow_width, window_height, OPENGL);
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
       int w = (int) random(min_rect_width, max_rect_width);
       int h = (int) random(min_rect_height, max_rect_height);
       
       int min_pos_x = shape_x + (i * x_range) + (int) (percent_margin_rect * x_range);
       int max_pos_x = shape_x + ((i + 1) * x_range) - w - (int) (percent_margin_rect * x_range);
       int min_pos_y = shape_y + (j * y_range) + (int) (percent_margin_rect * y_range);
       int max_pos_y = shape_y + ((j + 1) * y_range) - h - (int) (percent_margin_rect * y_range);
       
       int ax = (int) random(min_pos_x, max_pos_x);
       int ay = (int) random(min_pos_y, max_pos_y);
       int aw = w;
       int ah = h;
       rect_matrix[i][j] = new Rectangle(ax, ay, aw, ah);
       
       if ( i > 0 && j > 0) {
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
         
         point_matrix[i-1][j-1] = new Point(
             (int) random(min_pos_x_point + (range_x * percent_margin_point), 
                           max_pos_x_point - (range_x * percent_margin_point)),
             (int) random(min_pos_y_point + (range_y * percent_margin_point), 
                           max_pos_y_point - (range_y * percent_margin_point)));
       }
       
     }
   }
}

void drawShape() {
  for (int i = 0; i < matrix_width; i++) {
     for (int j = 0; j < matrix_height; j++) {
       Rectangle rect = rect_matrix[i][j];
       fill(white);
       noStroke();
       rect(rect.x, rect.y, rect.w, rect.h);
       
       if (i > 0 && j > 0) {
         boolean pair = (i + j) % 2 == 0;
         
         Point p = point_matrix[i-1][j-1];
         
         Rectangle no = rect_matrix[i-1][j-1];
         Rectangle ne = rect_matrix[i][j-1];
         Rectangle so = rect_matrix[i-1][j];
         Rectangle se = rect_matrix[i][j];
         
         if (pair) {
           fill(col1);
         } else {
           fill(col2);
         }
         triangle(no.x + no.w, no.y + no.h, p.x, p.y, so.x + so.w, so.y);
         if (pair) {
           fill(col3);
         } else {
           fill(col4);
         }
         triangle(ne.x, ne.y + ne.h, p.x, p.y, no.x + no.w, no.y + no.h);
         if (pair) {
           fill(col2);
         } else {
           fill(col1);
         }
         triangle(se.x, se.y, p.x, p.y, ne.x, ne.y + ne.h);
         if (pair) {
           fill(col4);
         } else {
           fill(col3);
         }
         triangle(so.x + so.w, so.y, p.x, p.y, se.x, se.y);
         
         if (pair) {
           fill(col1);
         } else {
           fill(col2);
         }
         quad(no.x, no.y + no.h, no.x + no.w, no.y + no.h, so.x + so.w, so.y, so.x, so.y);
         if (pair) {
           fill(col3);
         } else {
           fill(col4);
         }
         quad(ne.x, ne.y, ne.x, ne.y + ne.h, no.x + no.w, no.y + no.h, no.x + no.w, no.y);
         if (pair) {
           fill(col2);
         } else {
           fill(col1);
         }
         quad(se.x, se.y, se.x + se.w, se.y, ne.x + ne.w, ne.y + ne.h, ne.x, ne.y + ne.h);
         if (pair) {
           fill(col4);
         } else {
           fill(col3);
         }
         quad(so.x + so.w, so.y, so.x + so.w, so.y + so.h, se.x, se.y + se.h, se.x, se.y);
       }
     }
   }
}

void mouseClicked() {
  shouldRandomize = true;
}

class Rectangle {
  public int x;
  public int y;
  public int w;
  public int h;
  public Rectangle(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}

class Point {
  public int x;
  public int y;
  public Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

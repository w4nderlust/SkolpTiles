import processing.pdf.*;
import controlP5.*;

public ControlP5 cp5;

public int viewport_width = 700;
public int viewport_height = 700;

public float shape_x = 0.1;
public float shape_y = 0.1;
public float shape_width = 600;
public float shape_height = 600;
public int matrix_rows = 3; //min 2
public int matrix_cols = 4; // min 2
public int rows = 3; //min 2
public int cols = 4; // min 2

public float padding = 0.1;

public float min_rect_width = 0.2;
public float max_rect_width = 0.6;
public float min_rect_height = 0.2;
public float max_rect_height = 0.6;

public float percent_margin_rect = 0.05;
public float percent_margin_point = 0.15;

public float percent_min_external = 0.1;
public float percent_max_external = 0.5;

public color col1 = color(219, 187, 84);
public float hue1 = 0;
public float saturation1 = 100;
public float brightness1 = 100;

public color col2 = color(93, 52, 64);
public float hue2 = 0;
public float saturation2 = 100;
public float brightness2 = 100;

public color col3 = color(181, 114, 84);
public float hue3 = 0;
public float saturation3 = 100;
public float brightness3 = 100;

public color col4 = color(34, 34, 45);
public float hue4 = 0;
public float saturation4 = 100;
public float brightness4 = 100;

public color colS = color(255, 255, 255);
public float hueS = 0;
public float saturationS = 0;
public float brightnessS = 100;

public color colB = color(192, 192, 192);
public float hueB = 0;
public float saturationB = 0;
public float brightnessB = 75;

public float hue_shift = 180; // between 0 and 360
public int shift_direction = 1; // 1 means to the right, 0 to the left
public int gradient_orientation = 8; // 0 means from top to bottom and then clockwise up to 7
public float vertical_shift_step = 0;
public float horizontal_shift_step = 0;
public int dirX = 1;
public int dirY = 1;

public Rectangle[][] rect_matrix;
public Point[][] point_matrix;

public color white = color(255, 255, 255);
public color black = color(0, 0, 0);
public color grey = color(192, 192, 192);
public color green = color(0, 255, 0);
public boolean shouldRandomize = true;
public boolean recordPDF = false;

public int pdfBorder = 20;
public PShape skolptiles_tag;

public String fileName = "skolptiles";
public int fileNum = 0;
public float shape_border = 10;

public int[] orientationMap = {1, 2, 5, 8, 7, 6, 3, 0, 4};

void setup() {
  size(1080, 700);  
  colorMode(HSB, 360, 100, 100, 1);
  skolptiles_tag = loadShape("skolptiles_tag.svg");
  cp5 = new ControlP5(this);
  cp5.getProperties().setFormat(ControlP5.SERIALIZED);

  Button buttonLoad = cp5.addButton("load")
    .setPosition(710, 10)
      .setSize(140, 20);
  buttonLoad.getCaptionLabel().align(CENTER, CENTER);

  Button buttonSave = cp5.addButton("save")
    .setPosition(870, 10)
      .setSize(140, 20);
  buttonSave.getCaptionLabel().align(CENTER, CENTER);

  cp5.addSlider("hue1")
    .setPosition(710, 50)
      .setSize(300, 15)
        .setRange(0, 360)
          .setValue(0);
  cp5.addSlider("saturation1")
    .setPosition(710, 65)
      .setSize(300, 15)
        .setRange(0, 100)
          .setValue(0);
  cp5.addSlider("brightness1")
    .setPosition(710, 80)
      .setSize(300, 15)
        .setRange(0, 100)
          .setValue(15);

  cp5.addSlider("hue2")
    .setPosition(710, 110)
      .setSize(300, 15)
        .setRange(0, 360)
          .setValue(0);
  cp5.addSlider("saturation2")
    .setPosition(710, 125)
      .setSize(300, 15)
        .setRange(0, 100)
          .setValue(0);
  cp5.addSlider("brightness2")
    .setPosition(710, 140)
      .setSize(300, 15)
        .setRange(0, 100)
          .setValue(60);

  cp5.addSlider("hue3")
    .setPosition(710, 170)
      .setSize(300, 15)
        .setRange(0, 360)
          .setValue(0);
  cp5.addSlider("saturation3")
    .setPosition(710, 185)
      .setSize(300, 15)
        .setRange(0, 100)
          .setValue(0);
  cp5.addSlider("brightness3")
    .setPosition(710, 200)
      .setSize(300, 15)
        .setRange(0, 100)
          .setValue(35);

  cp5.addSlider("hue4")
    .setPosition(710, 230)
      .setSize(300, 15)
        .setRange(0, 360)
          .setValue(0);
  cp5.addSlider("saturation4")
    .setPosition(710, 245)
      .setSize(300, 15)
        .setRange(0, 100)
          .setValue(0);
  cp5.addSlider("brightness4")
    .setPosition(710, 260)
      .setSize(300, 15)
        .setRange(0, 100)
          .setValue(85);

  cp5.addSlider("hueS")
    .setPosition(710, 290)
      .setSize(300, 15)
        .setRange(0, 360)
          .setValue(0);
  cp5.addSlider("saturationS")
    .setPosition(710, 305)
      .setSize(300, 15)
        .setRange(0, 100)
          .setValue(0);
  cp5.addSlider("brightnessS")
    .setPosition(710, 320)
      .setSize(300, 15)
        .setRange(0, 100)
          .setValue(100);

  cp5.addSlider("hueB")
    .setPosition(710, 350)
      .setSize(300, 15)
        .setRange(0, 360)
          .setValue(0);
  cp5.addSlider("saturationB")
    .setPosition(710, 365)
      .setSize(300, 15)
        .setRange(0, 100)
          .setValue(0);
  cp5.addSlider("brightnessB")
    .setPosition(710, 380)
      .setSize(300, 15)
        .setRange(0, 100)
          .setValue(75);
          
  cp5.addSlider("v_width")
    .setPosition(710, 410)
      .setSize(300, 15)
        .setRange(200, 700)
          .setValue(700);
  cp5.addSlider("v_height")
    .setPosition(710, 425)
      .setSize(300, 15)
        .setRange(200, 700)
          .setValue(700);

 cp5.addSlider("rows")
    .setPosition(710, 445)
      .setSize(300, 15)
        .setRange(2, 10)
          .setValue(3);
  cp5.addSlider("cols")
    .setPosition(710, 460)
      .setSize(300, 15)
        .setRange(2, 10)
          .setValue(3);
          
  cp5.addSlider("margin_rect")
    .setPosition(710, 480)
      .setSize(300, 15)
        .setRange(0, 0.5)
          .setValue(0.05);
  cp5.addSlider("margin_point")
    .setPosition(710, 495)
      .setSize(300, 15)
        .setRange(0, 0.5)
          .setValue(0.15);

  Range range_rect_width = cp5.addRange("rect_width")
    .setBroadcast(false) 
      .setPosition(710, 515)
        .setSize(300, 15)
          .setHandleSize(20)
            .setRange(0, 1)
              .setRangeValues(0.2, 0.8)
                .setBroadcast(true);

  Range range_rect_height = cp5.addRange("rect_height")
    .setBroadcast(false) 
      .setPosition(710, 530)
        .setSize(300, 15)
          .setHandleSize(20)
            .setRange(0, 1)
              .setRangeValues(0.2, 0.8)
                .setBroadcast(true);

  cp5.addSlider("padding")
    .setPosition(710, 550)
      .setSize(300, 15)
        .setRange(0, 0.5)
          .setValue(0.1);

  Range range_eternal = cp5.addRange("external")
    .setBroadcast(false) 
      .setPosition(710, 570)
        .setSize(300, 15)
          .setHandleSize(20)
            .setRange(0, 1)
              .setRangeValues(0.1, 0.5)
                .setBroadcast(true);

  cp5.addRadioButton("orientation")
    .setPosition(710, 600)
      .setSize(40, 20)
        .setItemsPerRow(3)
          .setItemHeight(15)
            .setItemWidth(15)
              .setSpacingColumn(25)
                .setNoneSelectedAllowed(false)
                  .addItem("NW", 7)
                    .addItem("N", 0)
                      .addItem("NE", 1)
                        .addItem("W", 6)
                          .addItem("-", 8)
                            .addItem("E", 2)
                              .addItem("SW", 5)
                                .addItem("S", 4)
                                  .addItem("SE", 3)
                                    .activate(4)
                                      ;

  cp5.addSlider("hue_shift")
    .setPosition(840, 600)
      .setSize(170, 15)
        .setRange(0, 360)
          .setValue(180);

  cp5.addRadioButton("direction")
    .setPosition(840, 620)
      .setSize(40, 20)
        .setItemsPerRow(2)
          .setItemHeight(15)
            .setItemWidth(15)
              .setSpacingColumn(25)
                .setNoneSelectedAllowed(false)
                  .addItem("right", 0)
                    .addItem("left", 1)
                      .activate(0)
                        ;

  Button randomize = cp5.addButton("randomize")
    .setPosition(710, 660)
      .setSize(90, 30);
  randomize.getCaptionLabel().align(CENTER, CENTER);
  
  Button generate = cp5.addButton("generate")
    .setPosition(815, 660)
      .setSize(90, 30);
  generate.getCaptionLabel().align(CENTER, CENTER);

  Button export_pdf = cp5.addButton("export_pdf")
    .setPosition(920, 660)
      .setSize(90, 30);
  export_pdf.getCaptionLabel().align(CENTER, CENTER);
}

void draw() {
  background(colB);

  if (shouldRandomize) {
    randomizeShape();
    shouldRandomize = false;
  }
  drawShape();

  //paint ui background and gradients
  fill(color(0, 0, 25));
  rect(700, 0, 380, 700);

  paintGradient(710, 49, 300, 1);
  paintGradient(710, 109, 300, 1);
  paintGradient(710, 169, 300, 1);
  paintGradient(710, 229, 300, 1);
  paintGradient(710, 289, 300, 1);
  paintGradient(710, 349, 300, 1);
}

void randomizeShape() {
  float x0 = (700 - viewport_width) / 2.0;
  float y0 = (700 - viewport_height) / 2.0;
  
  matrix_rows = cols;
  matrix_cols = rows;
  rect_matrix = new Rectangle[matrix_rows][matrix_cols];
  point_matrix = new Point[matrix_rows + 1][matrix_cols + 1];

  float x_range = shape_width / matrix_rows;
  float y_range = shape_height / matrix_cols;

  for (int i = 0; i < matrix_rows; i++) {
    for (int j = 0; j < matrix_cols; j++) {
      float w = random(min_rect_width * x_range, max_rect_width * x_range);
      float h = random(min_rect_height * y_range, max_rect_height * y_range);

      float min_pos_x = x0 + shape_x + (i * x_range) + (percent_margin_rect * (x_range - w));
      float max_pos_x = x0 + shape_x + ((i + 1) * x_range) - w - (percent_margin_rect * (x_range - w));
      float min_pos_y = y0 + shape_y + (j * y_range) + (percent_margin_rect * (y_range - h));
      float max_pos_y = y0 + shape_y + ((j + 1) * y_range) - h - (percent_margin_rect * (y_range - h));

      float ax = random(min_pos_x, max_pos_x);
      float ay = random(min_pos_y, max_pos_y);
      float aw = w;
      float ah = h;
      rect_matrix[i][j] = new Rectangle(ax, ay, aw, ah);

      if (i > 0 && j > 0) {
        Rectangle no = rect_matrix[i-1][j-1];
        Rectangle ne = rect_matrix[i][j-1];
        Rectangle so = rect_matrix[i-1][j];
        Rectangle se = rect_matrix[i][j];

        float min_pos_x_point = max(no.x + no.w, so.x + so.w);
        float max_pos_x_point = min(ne.x, se.x);
        float min_pos_y_point = max(no.y + no.h, ne.y + ne.h);
        float max_pos_y_point = min(so.y, se.y);
        float range_x = max_pos_x_point - min_pos_x_point;
        float range_y = max_pos_y_point - min_pos_y_point;

        point_matrix[i][j] = new Point(
        random(min_pos_x_point + (range_x * percent_margin_point), 
        max_pos_x_point - (range_x * percent_margin_point)), 
        random(min_pos_y_point + (range_y * percent_margin_point), 
        max_pos_y_point - (range_y * percent_margin_point)));

        if (i == 1 && j == 1) {
          float min_range_x = no.x - ((no.x - x0) * percent_max_external);
          float max_range_x = no.x - ((no.x - x0) * percent_min_external);
          float min_range_y = no.y - ((no.y - y0) * percent_max_external);
          float max_range_y = no.y - ((no.y - y0) * percent_min_external);
          point_matrix[0][0] = new Point(
          random(min_range_x, max_range_x), 
          random(min_range_y, max_range_y));
        }
        if (j == 1) {
          float min_range_y = min(no.y, ne.y) - ((min(no.y, ne.y) - y0) * percent_max_external);
          float max_range_y = min(no.y, ne.y) - ((min(no.y, ne.y) - y0) * percent_min_external);
          point_matrix[i][0] = new Point(
          random(no.x + no.w, ne.x), 
          random(min_range_y, max_range_y));
        }
        if (i == matrix_rows - 1 && j == 1) {
          float min_range_x = ne.x + ne.w + ((viewport_width + x0 - (ne.x + ne.w)) * percent_min_external);
          float max_range_x = ne.x + ne.w + ((viewport_width + x0 - (ne.x + ne.w)) * percent_max_external);
          float min_range_y = ne.y - ((ne.y - y0) * percent_max_external);
          float max_range_y = ne.y - ((ne.y - y0) * percent_min_external);
          point_matrix[matrix_rows][0] = new Point(
          random(min_range_x, max_range_x), 
          random(min_range_y, max_range_y));
        }
        if (i == matrix_rows - 1) {
          float min_range_x = max(ne.x + ne.w, se.x + se.w) + ((viewport_width + x0 - max(ne.x + ne.w, se.x + se.w)) * percent_min_external);
          float max_range_x = max(ne.x + ne.w, se.x + se.w) + ((viewport_width + x0 - max(ne.x + ne.w, se.x + se.w)) * percent_max_external);
          point_matrix[matrix_rows][j] = new Point(
          random(min_range_x, max_range_x), 
          random(ne.y + ne.h, se.y));
        }
        if (i == matrix_rows - 1 && j == matrix_cols - 1) {
          float min_range_x = se.x + se.w + ((viewport_width + x0 - (se.x + se.w)) * percent_min_external);
          float max_range_x = se.x + se.w + ((viewport_width + x0 - (se.x + se.w)) * percent_max_external);
          float min_range_y = se.y + se.h + ((viewport_height + y0 - (se.y + se.h)) * percent_min_external);
          float max_range_y = se.y + se.h + ((viewport_height + y0 - (se.y + se.h)) * percent_max_external);
          point_matrix[matrix_rows][matrix_cols] = new Point(
          random(min_range_x, max_range_x), 
          random(min_range_y, max_range_y));
        }
        if (j == matrix_cols - 1) {
          float min_range_y = max(so.y + so.h, se.y + se.h) + ((viewport_height + y0 - max(so.y + so.h, se.y + se.h)) * percent_min_external);
          float max_range_y = max(so.y + so.h, se.y + se.h) + ((viewport_height + y0 - max(so.y + so.h, se.y + se.h)) * percent_max_external);
          point_matrix[i][matrix_cols] = new Point(
          random(so.x + so.w, se.x), 
          random(min_range_y, max_range_y));
        }
        if (i == 1 && j == matrix_cols - 1) {
          float min_range_x = so.x - ((so.x - x0) * percent_max_external);
          float max_range_x = so.x - ((so.x - x0) * percent_min_external);
          float min_range_y = so.y + so.h + ((viewport_height + y0 - (so.y + so.h)) * percent_min_external);
          float max_range_y = so.y + so.h + ((viewport_height + y0 - (so.y + so.h)) * percent_max_external);
          point_matrix[0][matrix_cols] = new Point(
          random(min_range_x, max_range_x), 
          random(min_range_y, max_range_y));
        }
        if (i == 1) {
          float min_range_x = min(so.x, no.x) - ((min(so.x, no.x) - x0) * percent_max_external);
          float max_range_x = min(so.x, no.x) - ((min(so.x, no.x) - x0) * percent_min_external);
          point_matrix[0][j] = new Point(
          random(min_range_x, max_range_x), 
          random(no.y + no.h, so.y));
        }
      }
    }
  }
}

void drawShape() {
  switch (gradient_orientation) { 
  case 0: 
    vertical_shift_step = hue_shift / matrix_rows;
    horizontal_shift_step = 0;
    break;
  case 1: 
    vertical_shift_step = hue_shift / (matrix_rows * 2);
    horizontal_shift_step = hue_shift / (matrix_cols * 2);
    break;
  case 2: 
    vertical_shift_step = 0;
    horizontal_shift_step = hue_shift / matrix_cols;
    break;
  case 3: 
    vertical_shift_step = hue_shift / (matrix_rows * 2);
    horizontal_shift_step = hue_shift / (matrix_cols * 2);
    break;
  case 4: 
    vertical_shift_step = hue_shift / matrix_rows;
    horizontal_shift_step = 0;
    break;
  case 5: 
    vertical_shift_step = hue_shift / (matrix_rows * 2);
    horizontal_shift_step = hue_shift / (matrix_cols * 2);
    break;
  case 6: 
    vertical_shift_step = 0;
    horizontal_shift_step = hue_shift / matrix_cols;
    break;
  case 7: 
    vertical_shift_step = hue_shift / (matrix_rows * 2);
    horizontal_shift_step = hue_shift / (matrix_cols * 2);
    break;
  case 8: 
    vertical_shift_step = 0;
    horizontal_shift_step = 0;
    break;
  }

  noFill();
  noStroke();
  for (int i = 0; i < matrix_rows; i++) {
    for (int j = 0; j < matrix_cols; j++) {
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
          fill(color(rotateHue(col2, i, j), saturation(col2), brightness(col2)));
        } else {
          fill(color(rotateHue(col1, i, j), saturation(col1), brightness(col1)));
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
          fill(color(rotateHue(col4, i, j), saturation(col4), brightness(col4)));
        } else {
          fill(color(rotateHue(col3, i, j), saturation(col3), brightness(col3)));
        }
        beginShape();
        vertex(so.x + so.w, so.y);
        vertex(so.x, so.y);
        vertex(po.x, po.y);
        vertex(no.x, no.y + no.h);
        vertex(no.x + no.w, no.y + no.h);
        vertex(p.x, p.y);
        endShape();

        if (i == matrix_rows - 1) {
          if (pair) {
            fill(color(rotateHue(col3, i, j), saturation(col3), brightness(col3)));
          } else {
            fill(color(rotateHue(col4, i, j), saturation(col4), brightness(col4)));
          }
          beginShape();
          vertex(ne.x, ne.y + ne.h);
          vertex(ne.x + ne.w, ne.y + ne.h);
          vertex(pe.x, pe.y);
          vertex(se.x + se.w, se.y);
          vertex(se.x, se.y);
          vertex(p.x, p.y);
          endShape();
        }

        if (j == matrix_cols - 1) {
          if (pair) {
            fill(color(rotateHue(col1, i, j), saturation(col1), brightness(col1)));
          } else {
            fill(color(rotateHue(col2, i, j), saturation(col2), brightness(col2)));
          }
          beginShape();
          vertex(se.x, se.y);
          vertex(se.x, se.y + se.h);
          vertex(ps.x, ps.y);
          vertex(so.x + so.w, so.y + so.h);
          vertex(so.x + so.w, so.y);
          vertex(p.x, p.y);
          endShape();
        }

        // External
        if (i == 1 && j == 1) {
          Point angle = point_matrix[0][0];
          Point ep = point_matrix[0][j];
          if (pair) {
            fill(color(rotateHue(col1, i, j), saturation(col1), brightness(col1))); 
            ;
          } else {
            fill(color(rotateHue(col2, i, j), saturation(col2), brightness(col2)));
          }
          quad(angle.x, angle.y, ep.x, ep.y, no.x, no.y + no.h, no.x, no.y);
        }
        if (j == 1) {
          Point prev = point_matrix[i-1][0];
          Point ep = point_matrix[i][0];

          if (pair) {
            fill(color(rotateHue(col3, i, j), saturation(col3), brightness(col3)));
          } else {
            fill(color(rotateHue(col4, i, j), saturation(col4), brightness(col4)));
          }
          quad(prev.x, prev.y, ep.x, ep.y, no.x + no.w, no.y, no.x, no.y);
        }
        if (i == matrix_rows - 1 && j == 1) {
          Point angle = point_matrix[matrix_rows][0];
          Point ep = point_matrix[i][0];

          if (pair) {
            fill(color(rotateHue(col4, i, j), saturation(col4), brightness(col4)));
          } else {
            fill(color(rotateHue(col3, i, j), saturation(col3), brightness(col3)));
          }
          quad(ep.x, ep.y, angle.x, angle.y, ne.x + ne.w, ne.y, ne.x, ne.y);
        }
        if (i == matrix_rows - 1) {
          Point prev = point_matrix[matrix_rows][j - 1];
          Point ep = point_matrix[matrix_rows][j];

          if (pair) {
            fill(color(rotateHue(col1, i, j), saturation(col1), brightness(col1))); 
            ;
          } else {
            fill(color(rotateHue(col2, i, j), saturation(col2), brightness(col2)));
          }
          quad(prev.x, prev.y, ep.x, ep.y, ne.x + ne.w, ne.y + ne.h, ne.x + ne.w, ne.y);
        }
        if (i == matrix_rows - 1 && j == matrix_cols - 1) {
          Point angle = point_matrix[matrix_rows][matrix_cols];
          Point ep = point_matrix[matrix_rows][j];

          if (pair) {
            fill(color(rotateHue(col2, i, j), saturation(col2), brightness(col2)));
          } else {
            fill(color(rotateHue(col1, i, j), saturation(col1), brightness(col1))); 
            ;
          }
          quad(ep.x, ep.y, angle.x, angle.y, se.x + se.w, se.y + se.h, se.x + se.w, se.y);
        }
        if (j == matrix_cols - 1) {
          Point prev = point_matrix[i + 1][matrix_cols];
          Point ep = point_matrix[i][matrix_cols];

          if (pair) {
            fill(color(rotateHue(col4, i, j), saturation(col4), brightness(col4)));
          } else {
            fill(color(rotateHue(col3, i, j), saturation(col3), brightness(col3)));
          }
          quad(ep.x, ep.y, prev.x, prev.y, se.x + se.w, se.y + se.h, se.x, se.y + se.h);
        }
        if (i == 1 && j == matrix_cols - 1) {
          Point angle = point_matrix[0][matrix_cols];
          Point ep = point_matrix[i][matrix_cols];

          if (pair) {
            fill(color(rotateHue(col3, i, j), saturation(col3), brightness(col3)));
          } else {
            fill(color(rotateHue(col4, i, j), saturation(col4), brightness(col4)));
          }
          quad(ep.x, ep.y, angle.x, angle.y, so.x, so.y + so.h, so.x + so.w, so.y + so.h);
        }
        if (i == 1) {
          Point prev = point_matrix[0][j + 1];
          Point ep = point_matrix[0][j];

          if (pair) {
            fill(color(rotateHue(col2, i, j), saturation(col2), brightness(col2)));
          } else {
            fill(color(rotateHue(col1, i, j), saturation(col1), brightness(col1))); 
            ;
          }
          quad(ep.x, ep.y, prev.x, prev.y, so.x, so.y + so.h, so.x, so.y);
        }
      }
    }
  }
  for (int i = 0; i < matrix_rows + 1; i++) {
    for (int j = 0; j < matrix_cols + 1; j++) {
      Point p = point_matrix[i][j];
      p.rollover(mouseX, mouseY);
      p.drag(mouseX, mouseY);
      p.display();
    }
  }
  for (int i = 0; i < matrix_rows; i++) {
    for (int j = 0; j < matrix_cols; j++) {
      Rectangle rect = rect_matrix[i][j];
      rect.rollover(mouseX, mouseY);
      rect.drag(mouseX, mouseY);
      rect.resize(mouseX, mouseY);
      rect.display();
    }
  }
}


void drawPdf() {
  float x0 = ((700 - viewport_width) / 2.0) - pdfBorder;
  float y0 = ((700 - viewport_height) / 2.0) - pdfBorder;
  
  fileNum++;
  PGraphics pdf = createGraphics(viewport_width + (pdfBorder * 2), viewport_height + (pdfBorder * 4), PDF, fileName + "-" + fileNum + ".pdf");
  pdf.beginDraw();
  pdf.colorMode(HSB, 360, 100, 100, 1);

  pdf.noFill();
  pdf.noStroke();
  
  // draw background
  pdf.fill(colB);
  pdf.rect(pdfBorder, pdfBorder, viewport_width, viewport_height);
      
  for (int i = 0; i < matrix_rows; i++) {
    for (int j = 0; j < matrix_cols; j++) {

      Rectangle rect = rect_matrix[i][j];
      pdf.fill(colS);
      pdf.rect(rect.x - x0, rect.y - y0, rect.w, rect.h);

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
          pdf.fill(color(rotateHue(col2, i, j), saturation(col2), brightness(col2)));
        } else {
          pdf.fill(color(rotateHue(col1, i, j), saturation(col1), brightness(col1))); 
          ;
        }
        pdf.beginShape();
        pdf.vertex(no.x + no.w - x0, no.y + no.h - y0);
        pdf.vertex(no.x + no.w - x0, no.y - y0);
        pdf.vertex(pn.x - x0, pn.y - y0);
        pdf.vertex(ne.x - x0, ne.y - y0);
        pdf.vertex(ne.x - x0, ne.y + ne.h - y0);
        pdf.vertex(p.x - x0, p.y - y0);
        pdf.endShape();

        if (pair) {
          pdf.fill(color(rotateHue(col4, i, j), saturation(col4), brightness(col4)));
        } else {
          pdf.fill(color(rotateHue(col3, i, j), saturation(col3), brightness(col3)));
        }
        pdf.beginShape();
        pdf.vertex(so.x + so.w - x0, so.y - y0);
        pdf.vertex(so.x - x0, so.y - y0);
        pdf.vertex(po.x - x0, po.y - y0);
        pdf.vertex(no.x - x0, no.y + no.h - y0);
        pdf.vertex(no.x + no.w - x0, no.y + no.h - y0);
        pdf.vertex(p.x - x0, p.y - y0);
        pdf.endShape();

        if (i == matrix_rows - 1) {
          if (pair) {
            pdf.fill(color(rotateHue(col3, i, j), saturation(col3), brightness(col3)));
          } else {
            pdf.fill(color(rotateHue(col4, i, j), saturation(col4), brightness(col4)));
          }
          pdf.beginShape();
          pdf.vertex(ne.x - x0, ne.y + ne.h - y0);
          pdf.vertex(ne.x + ne.w - x0, ne.y + ne.h - y0);
          pdf.vertex(pe.x - x0, pe.y - y0);
          pdf.vertex(se.x + se.w - x0, se.y - y0);
          pdf.vertex(se.x - x0, se.y - y0);
          pdf.vertex(p.x - x0, p.y - y0);
          pdf.endShape();
        }

        if (j == matrix_cols - 1) {
          if (pair) {
            pdf.fill(color(rotateHue(col1, i, j), saturation(col1), brightness(col1))); 
            ;
          } else {
            pdf.fill(color(rotateHue(col2, i, j), saturation(col2), brightness(col2)));
          }
          pdf.beginShape();
          pdf.vertex(se.x - x0, se.y - y0);
          pdf.vertex(se.x - x0, se.y + se.h - y0);
          pdf.vertex(ps.x - x0, ps.y - y0);
          pdf.vertex(so.x + so.w - x0, so.y + so.h - y0);
          pdf.vertex(so.x + so.w - x0, so.y - y0);
          pdf.vertex(p.x - x0, p.y - y0);
          pdf.endShape();
        }

        // External
        if (i == 1 && j == 1) {
          Point angle = point_matrix[0][0];
          Point ep = point_matrix[0][j];
          if (pair) {
            pdf.fill(color(rotateHue(col1, i, j), saturation(col1), brightness(col1))); 
            ;
          } else {
            pdf.fill(color(rotateHue(col2, i, j), saturation(col2), brightness(col2)));
          }
          pdf.quad(angle.x - x0, angle.y - y0, ep.x - x0, ep.y - y0, no.x - x0, no.y + no.h - y0, no.x - x0, no.y - y0);
        }
        if (j == 1) {
          Point prev = point_matrix[i-1][0];
          Point ep = point_matrix[i][0];

          if (pair) {
            pdf.fill(color(rotateHue(col3, i, j), saturation(col3), brightness(col3)));
          } else {
            pdf.fill(color(rotateHue(col4, i, j), saturation(col4), brightness(col4)));
          }
          pdf.quad(prev.x - x0, prev.y - y0, ep.x - x0, ep.y - y0, no.x + no.w - x0, no.y - y0, no.x - x0, no.y - y0);
        }
        if (i == matrix_rows - 1 && j == 1) {
          Point angle = point_matrix[matrix_rows][0];
          Point ep = point_matrix[i][0];

          if (pair) {
            pdf.fill(color(rotateHue(col4, i, j), saturation(col4), brightness(col4)));
          } else {
            pdf.fill(color(rotateHue(col3, i, j), saturation(col3), brightness(col3)));
          }
          pdf.quad(ep.x - x0, ep.y - y0, angle.x - x0, angle.y - y0, ne.x + ne.w - x0, ne.y - y0, ne.x - x0, ne.y - y0);
        }
        if (i == matrix_rows - 1) {
          Point prev = point_matrix[matrix_rows][j - 1];
          Point ep = point_matrix[matrix_rows][j];

          if (pair) {
            pdf.fill(color(rotateHue(col1, i, j), saturation(col1), brightness(col1)));
          } else {
            pdf.fill(color(rotateHue(col2, i, j), saturation(col2), brightness(col2)));
          }
          pdf.quad(prev.x - x0, prev.y - y0, ep.x - x0, ep.y - y0, ne.x + ne.w - x0, ne.y + ne.h - y0, ne.x + ne.w - x0, ne.y - y0);
        }
        if (i == matrix_rows - 1 && j == matrix_cols - 1) {
          Point angle = point_matrix[matrix_rows][matrix_cols];
          Point ep = point_matrix[matrix_rows][j];

          if (pair) {
            pdf.fill(color(rotateHue(col2, i, j), saturation(col2), brightness(col2)));
          } else {
            pdf.fill(color(rotateHue(col1, i, j), saturation(col1), brightness(col1)));
          }
          pdf.quad(ep.x - x0, ep.y - y0, angle.x - x0, angle.y - y0, se.x + se.w - x0, se.y + se.h - y0, se.x + se.w - x0, se.y - y0);
        }
        if (j == matrix_cols - 1) {
          Point prev = point_matrix[i + 1][matrix_cols];
          Point ep = point_matrix[i][matrix_cols];

          if (pair) {
            pdf.fill(color(rotateHue(col4, i, j), saturation(col4), brightness(col4)));
          } else {
            pdf.fill(color(rotateHue(col3, i, j), saturation(col3), brightness(col3)));
          }
          pdf.quad(ep.x - x0, ep.y - y0, prev.x - x0, prev.y - y0, se.x + se.w - x0, se.y + se.h - y0, se.x - x0, se.y + se.h - y0);
        }
        if (i == 1 && j == matrix_cols - 1) {
          Point angle = point_matrix[0][matrix_cols];
          Point ep = point_matrix[i][matrix_cols];

          if (pair) {
            pdf.fill(color(rotateHue(col3, i, j), saturation(col3), brightness(col3)));
          } else {
            pdf.fill(color(rotateHue(col4, i, j), saturation(col4), brightness(col4)));
          }
          pdf.quad(ep.x - x0, ep.y - y0, angle.x - x0, angle.y - y0, so.x - x0, so.y + so.h - y0, so.x + so.w - x0, so.y + so.h - y0);
        }
        if (i == 1) {
          Point prev = point_matrix[0][j + 1];
          Point ep = point_matrix[0][j];

          if (pair) {
            pdf.fill(color(rotateHue(col2, i, j), saturation(col2), brightness(col2)));
          } else {
            pdf.fill(col1);
          }
          pdf.quad(ep.x - x0, ep.y - y0, prev.x - x0, prev.y - y0, so.x - x0, so.y + so.h - y0, so.x - x0, so.y - y0);
        }
      }
    }
  }

  pdf.shapeMode(CENTER);
  pdf.shape(skolptiles_tag, (viewport_width / 2.0) + pdfBorder, viewport_height + (2.5 * pdfBorder));
  
  pdf.dispose();
  pdf.endDraw();
}


float rotateHue(color col, int i, int j) {
  float val = (hue(col)
    + (((matrix_cols + (j * dirY)) % matrix_cols) * shift_direction * vertical_shift_step)
    + (((matrix_rows + (i * dirX)) % matrix_rows) * shift_direction * horizontal_shift_step))
    % 360;
  if (val < 0) {
    val += 360;
  }
  return val;
}

/*
void keyPressed() {
 shouldRandomize = true;
 }
 */

void mousePressed() {
  for (int i = 0; i < matrix_rows; i++) {
    for (int j = 0; j < matrix_cols; j++) {
      rect_matrix[i][j].clicked(mouseX, mouseY);
    }
  }
  for (int i = 0; i < matrix_rows + 1; i++) {
    for (int j = 0; j < matrix_cols + 1; j++) {
      point_matrix[i][j].clicked(mouseX, mouseY);
    }
  }
}

void mouseReleased() {
  for (int i = 0; i < matrix_rows; i++) {
    for (int j = 0; j < matrix_cols; j++) {
      rect_matrix[i][j].stopDragging();
      rect_matrix[i][j].stopResizing();
    }
  }
  for (int i = 0; i < matrix_rows + 1; i++) {
    for (int j = 0; j < matrix_cols + 1; j++) {
      point_matrix[i][j].stopDragging();
    }
  }
}




class Rectangle {
  public float x;
  public float y;
  public float w;
  public float h;

  boolean dragging = false; // Is the rectangle being dragged?
  boolean rollover = false; // Is the mouse over the rectangle?
  boolean resizing_top = false;
  boolean rollover_top = false;
  boolean resizing_right = false;
  boolean rollover_right = false;
  boolean resizing_bottom = false;
  boolean rollover_bottom = false;
  boolean resizing_left = false;
  boolean rollover_left = false;

  float offsetX, offsetY; // Mouseclick offset

  Rectangle(float x, float y, float w, float h) {
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
      stroke(green);
      strokeWeight(5);
    } else {
      noStroke();
    }
    fill(colS);
    rect(x, y, w, h);
    noStroke();
    if (resizing_top || rollover_top) {
      stroke(green);
      strokeWeight(5);
      line(x, y, x + w, y);
      noStroke();
    }
    if (resizing_right || rollover_right) {
      stroke(green);
      strokeWeight(5);
      line(x + w, y, x + w, y + h);
      noStroke();
    }
    if (resizing_bottom || rollover_bottom) {
      stroke(green);
      strokeWeight(5);
      line(x, y + h, x + w, y + h);
      noStroke();
    }
    if (resizing_left || rollover_left) {
      stroke(green);
      strokeWeight(5);
      line(x, y, x, y + h);
      noStroke();
    }
  }

  // Is a point inside the rectangle (for click)?
  void clicked(float mx, float my) {
    if (mx > x + (shape_border / 2) && mx < x + w - (shape_border / 2) && my > y + (shape_border / 2) && my < y + h - (shape_border / 2)) {
      dragging = true;
      // If so, keep track of relative location of click to corner of rectangle
      offsetX = x-mx;
      offsetY = y-my;
    } else if (mx > x && mx < x + w && my > y - (shape_border / 2)  && my < y + (shape_border / 2) ) {
      // top
      resizing_top = true;
      offsetY = y-my;
    } else if (mx > x + w - (shape_border / 2) && mx < x + w + (shape_border / 2) && my > y&& my < y + h) {
      // right
      resizing_right = true;
      offsetX = x+w-mx;
    } else if (mx > x && mx < x + w && my > y + h - (shape_border / 2)  && my < y + h + (shape_border / 2) ) {
      // bottom
      resizing_bottom = true;
      offsetY = y+h-my;
    } else if (mx > x - (shape_border / 2) && mx < x + (shape_border / 2) && my > y&& my < y + h) {
      // left
      resizing_left = true;
      offsetX = x-mx;
    }
  }

  // Is a point inside the rectangle (for rollover)
  void rollover(float mx, float my) {
    if (!resizing_top && !resizing_right && !resizing_bottom && !resizing_left && mx > x + (shape_border / 2) && mx < x + w - (shape_border / 2) && my > y + (shape_border / 2) && my < y + h - (shape_border / 2)) {
      rollover = true;
      rollover_top = false;
      rollover_right = false;
      rollover_bottom = false;
      rollover_left = false;
    } else if (mx > x && mx < x + w && my > y - (shape_border / 2)  && my < y + (shape_border / 2) ) {
      // top
      rollover = false;
      rollover_top = true;
      rollover_right = false;
      rollover_bottom = false;
      rollover_left = false;
    } else if (mx > x + w - (shape_border / 2) && mx < x + w + (shape_border / 2) && my > y&& my < y + h) {
      // right
      rollover = false;
      rollover_top = false;
      rollover_right = true;
      rollover_bottom = false;
      rollover_left = false;
    } else if (mx > x && mx < x + w && my > y + h - (shape_border / 2)  && my < y + h + (shape_border / 2) ) {
      // bottom
      rollover = false;
      rollover_top = false;
      rollover_right = false;
      rollover_bottom = true;
      rollover_left = false;
    } else if (mx > x - (shape_border / 2) && mx < x + (shape_border / 2) && my > y&& my < y + h) {
      // left
      rollover = false;
      rollover_top = false;
      rollover_right = false;
      rollover_bottom = false;
      rollover_left = true;
    } else {
      rollover = false;
      rollover_top = false;
      rollover_right = false;
      rollover_bottom = false;
      rollover_left = false;
    }
  }

  // Stop dragging
  void stopDragging() {
    dragging = false;
  }

  void stopResizing() {
    resizing_top = false;
    resizing_right = false;
    resizing_bottom = false;
    resizing_left = false;
  }

  // Drag the rectangle
  void drag(float mx, float my) {
    if (dragging) {
      x = mx + offsetX;
      y = my + offsetY;
    }
  }

  // Resize the rectangle
  void resize(float mx, float my) {
    if (resizing_top) {
      float oldY = y;
      y = my + offsetY;
      h = h - y + oldY;
    } else if (resizing_right) {
      w = mx - x + offsetX;
    } else if (resizing_bottom) {
      h = my - y + offsetY;
    } else if (resizing_left) {
      float oldX = x;
      x = mx + offsetX;
      w = w - x + oldX;
    }
  }
}

class Point {
  public float x;
  public float y;

  boolean dragging = false; // Is the rectangle being dragged?
  boolean rollover = false; // Is the mouse over the rectangle?

  float offsetX, offsetY; // Mouseclick offset

  public Point(float x, float y) {
    this.x = x;
    this.y = y;
    offsetX = 0;
    offsetY = 0;
  }

  // Method to display
  void display() {
    if (dragging || rollover) {
      stroke(green);
      strokeWeight(5);
      noFill();
      ellipse(x, y, 20, 20);
      noStroke();
    }
  }

  // Is a point inside the rectangle (for click)?
  void clicked(float mx, float my) {
    if (mx > x - 10 && mx < x + 10 && my > y - 10 && my < y + 10) {
      dragging = true;
      // If so, keep track of relative location of click to corner of rectangle
      offsetX = x-mx;
      offsetY = y-my;
    }
  }

  // Is a point around the point (for rollover)
  void rollover(float mx, float my) {
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
  void drag(float mx, float my) {
    if (dragging) {
      x = mx + offsetX;
      y = my + offsetY;
    }
  }
}




// Controls
void paintGradient(float x, float y, float w, float h) {
  for (int i = 0; i < w; ++i) {
    float hue = map(i/w, 0, 1, 0, 360);
    stroke(hue, 100, 100);
    strokeWeight(1);
    line(x+i, y, x+i, y+h);
  }
}

void load() {
  selectInput("Select a parameters file to load", "load_callback");
}

void load_callback(File selection) {
  if (selection != null && selection.getName().toLowerCase().endsWith(".ser")) {
    cp5.loadProperties(selection.getAbsolutePath());
    int loaded_orientation = (int) cp5.get("orientation").getValue();
    gradient_orientation = loaded_orientation;
    orientation(gradient_orientation);
    generate();
  }
}

void save() {
  selectOutput("Select a parameters file to save to", "save_callback");
}

void save_callback(File selection) {
  if (selection != null) {
    cp5.saveProperties(selection.getAbsolutePath());
  }
}

void hue1(float number) {
  hue1 = number;
  col1 = color(hue1, saturation1, brightness1);
}

void saturation1(float number) {
  saturation1 = number;
  col1 = color(hue1, saturation1, brightness1);
}

void brightness1(float number) {
  brightness1 = number;
  col1 = color(hue1, saturation1, brightness1);
}

void hue2(float number) {
  hue2 = number;
  col2 = color(hue2, saturation2, brightness2);
}

void saturation2(float number) {
  saturation2 = number;
  col2 = color(hue2, saturation2, brightness2);
}

void brightness2(float number) {
  brightness2 = number;
  col2 = color(hue2, saturation2, brightness2);
}

void hue3(float number) {
  hue3 = number;
  col3 = color(hue3, saturation3, brightness3);
}

void saturation3(float number) {
  saturation3 = number;
  col3 = color(hue3, saturation3, brightness3);
}

void brightness3(float number) {
  brightness3 = number;
  col3 = color(hue3, saturation3, brightness3);
}

void hue4(float number) {
  hue4 = number;
  col4 = color(hue4, saturation4, brightness4);
}

void saturation4(float number) {
  saturation4 = number;
  col4 = color(hue4, saturation4, brightness4);
}

void brightness4(float number) {
  brightness4 = number;
  col4 = color(hue4, saturation4, brightness4);
}

void hueS(float number) {
  hueS = number;
  colS = color(hueS, saturationS, brightnessS);
}

void saturationS(float number) {
  saturationS = number;
  colS = color(hueS, saturationS, brightnessS);
}

void brightnessS(float number) {
  brightnessS = number;
  colS = color(hueS, saturationS, brightnessS);
}

void hueB(float number) {
  hueB = number;
  colB = color(hueB, saturationB, brightnessB);
}

void saturationB(float number) {
  saturationB = number;
  colB = color(hueB, saturationB, brightnessB);
}

void brightnessB(float number) {
  brightnessB = number;
  colB = color(hueB, saturationB, brightnessB);
}

void rows(int number) {
  rows = number;
}

void cols(int number) {
  cols = number;
}

void v_width(int number) {
  viewport_width = number;
  shape_x = viewport_width * padding;
  shape_width = viewport_width - (2 * shape_x);
  shouldRandomize = true;
}

void v_height(int number) {
  viewport_height = number;
  shape_y = viewport_height * padding;
  shape_height = viewport_height - (2 * shape_y);
  shouldRandomize = true;
}

void margin_rect(float number) {
  percent_margin_rect = number;
}

void margin_point(float number) {
  percent_margin_point = number;
}

void padding(float number) {
  padding = number;
  shape_x = viewport_width * padding;
  shape_y = viewport_height * padding;
  shape_width = viewport_width - (2 * shape_x);
  shape_height = viewport_height - (2 * shape_y);
}

void controlEvent(ControlEvent event) {
  // min and max values are stored in an array.
  // access this array with controller().arrayValue().
  // min is at index 0, max is at index 1.
  if (event.isFrom("rect_width")) {
    min_rect_width = event.getController().getArrayValue(0);
    max_rect_width = event.getController().getArrayValue(1);
  } else if (event.isFrom("rect_height")) {
    min_rect_height = event.getController().getArrayValue(0);
    max_rect_height = event.getController().getArrayValue(1);
  } else if (event.isFrom("external")) {
    percent_min_external = event.getController().getArrayValue(0);
    percent_max_external = event.getController().getArrayValue(1);
  }
}

void orientation(int num) {
  gradient_orientation = num;
  if (num >= 1 && num <= 3) {
    dirX = -1;
  }
  if (num >= 3 && num <= 5) {
    dirY = -1;
  }
  if (num >= 5 && num <= 7) {
    dirX = 1;
  }
  if (num >= 0 && num <= 1 || num == 7) {
    dirY = 1;
  }
}

void hue_shift(float num) {
  hue_shift = num;
}

void direction(int num) {
  if (num == 0) {
    shift_direction = 1;
  } else {
    shift_direction = -1;
  }
}

void randomize() {
  cp5.getController("hue1").setValue(random(0, 360));
  cp5.getController("saturation1").setValue(random(0, 100));
  cp5.getController("brightness1").setValue(random(0, 100));
  cp5.getController("hue2").setValue(random(0, 360));
  cp5.getController("saturation2").setValue(random(0, 100));
  cp5.getController("brightness2").setValue(random(0, 100));
  cp5.getController("hue3").setValue(random(0, 360));
  cp5.getController("saturation3").setValue(random(0, 100));
  cp5.getController("brightness3").setValue(random(0, 100));
  cp5.getController("hue4").setValue(random(0, 360));
  cp5.getController("saturation4").setValue(random(0, 100));
  cp5.getController("brightness4").setValue(random(0, 100));
  cp5.getController("hueS").setValue(random(0, 360));
  cp5.getController("saturationS").setValue(random(0, 100));
  cp5.getController("brightnessS").setValue(random(0, 100));
  cp5.getController("hueB").setValue(random(0, 360));
  cp5.getController("saturationB").setValue(random(0, 100));
  cp5.getController("brightnessB").setValue(random(0, 100));

  cp5.getController("rows").setValue(random(2, 10));
  cp5.getController("cols").setValue(random(2, 10));

  cp5.getController("v_width").setValue(random(200, 700));
  cp5.getController("v_height").setValue(random(200, 700));
  
  cp5.getController("margin_rect").setValue(random(0, 0.5));
  cp5.getController("margin_point").setValue(random(0, 0.5));

  float r_rect_width_min = random(0, 1);
  float r_rect_width_max = random(r_rect_width_min, 1);
  ((Range) cp5.getController("rect_width")).setRangeValues(r_rect_width_min, r_rect_width_max);

  float r_rect_height_min = random(0, 1);
  float r_rect_height_max = random(r_rect_height_min, 1);
  ((Range) cp5.getController("rect_height")).setRangeValues(r_rect_height_min, r_rect_height_max);

  cp5.getController("padding").setValue(random(0, 0.5));

  float r_external_min = random(0, 1);
  float r_external_max = random(r_external_min, 1);
  ((Range) cp5.getController("external")).setRangeValues(r_external_min, r_external_max);

  int r_orientation = (int) random(0, 9);
  ((RadioButton) cp5.get("orientation")).activate(orientationMap[r_orientation]);
  orientation(r_orientation);

  cp5.getController("hue_shift").setValue(random(0, 360));

  int r_direction = (int) random(0, 2);
  ((RadioButton) cp5.get("direction")).activate(r_direction);
  direction(r_direction);
  
  shouldRandomize = true;
}

void generate() {
  shouldRandomize = true;
}

void export_pdf() {
  drawPdf();
}
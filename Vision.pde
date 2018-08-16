PImage src, hueImage, colorFilteredImage, colorFilteredImageB;
ArrayList<Contour> contours = new ArrayList<Contour>(0);

//Range of Hue values for our filter
int hueAColorLow = 170;
int hueAColorHigh = 180;
int hueBColorLow = 100;
int hueBColorHigh = 110;

Rectangle rA = new Rectangle();
Rectangle rB = new Rectangle();

void vision() {
  rectMode(CORNER);
  // <2> Load the new frame of our movie in to OpenCV
  opencv.loadImage(cam); 

  // Tell OpenCV to use color information
  opencv.useColor();
  opencv.flip(OpenCV.HORIZONTAL);
  src = opencv.getSnapshot();

  image(src, 0, 0); // <8> Display background images

  opencv.useColor(HSB); // <3> Tell OpenCV to work in HSV color space.
  opencv.setGray(opencv.getH().clone()); // <4> Copy the Hue channel of our image into the gray channel
  hueImage = opencv.getSnapshot();
  //opencv.loadImage(hueImage);
  opencv.erode();
  opencv.erode();
  opencv.erode();
  opencv.erode();
  opencv.erode();
  opencv.erode();
  rA =  processColor(hueAColorLow, hueAColorHigh);   // <5> Filter the image based on the range of hue values 

 // image(colorFilteredImage, src.width, 0);

  opencv.loadImage(hueImage);
  //opencv.useColor(HSB);
  opencv.erode();
  opencv.erode();
  opencv.erode();
  opencv.erode();
  opencv.erode();
  opencv.erode();
  rB =  processColor(hueBColorLow, hueBColorHigh); 

  //image(colorFilteredImage, src.width, src.height);

  // <11> Draw the bounding box of our object
  noFill(); 
  strokeWeight(2); 
  stroke(255, 0, 0);
  if (modo == 0)
    rect(rA.x, rA.y, rA.width, rA.height);
  //ellipse(r.x + r.width/2, r.y + r.height/2, r.width, r.height);
  noStroke(); 
  fill(255, 0, 0);
  ellipse(rA.x + rA.width/2, rA.y + rA.height/2, rCircle, rCircle); // <12> Draw a dot in the middle 

  // <11> Draw the bounding box of our object
  noFill(); 
  strokeWeight(2); 
  stroke(0, 0, 255);
  if (modo == 0)
    rect(rB.x, rB.y, rB.width, rB.height);
  //ellipse(r.x + r.width/2, r.y + r.height/2, r.width, r.height);
  noStroke(); 
  fill(0, 0, 255);
  ellipse(rB.x + rB.width/2, rB.y + rB.height/2, rCircle, rCircle); // <12> Draw a dot in the middle
}

Rectangle processColor(int hueLow, int hueHigh) {
  Rectangle r = new Rectangle();
  contours = new ArrayList<Contour>(0);

  opencv.inRange(hueLow, hueHigh);
  // <6> Get the processed image for reference.
  colorFilteredImage = opencv.getSnapshot();
  contours = opencv.findContours(true, true);   // <7> Find contours in our range image.'true' sorts descending   

  // <9> Check to make sure we've found any contours
  if (contours.size() > 0) {
    // <9> Get the first contour, which will be the largest one
    Contour biggestContour = contours.get(0);

    // <10> Find the bounding box of the largest contour, and hence our object.     
    r = biggestContour.getBoundingBox();
  }
  return r;
}

void updateAColor() {
  color c = get(int(objA.x), int(objA.x));
  colorA = c;
  println(" Color detectado: R: " + red(c) + " G: " + green(c) + " B: " + blue(c));

  int hue = int(map(hue(c), 0, 255, 0, 180));
  println(" Hue a detectar: " + hue);

  hueAColorLow = hue - 10;
  hueAColorHigh = hue + 10;
}

void updateBColor() {
  color c = get(int(objB.x), int(objB.x));
  colorB = c;
  println(" Color detectado: R: " + red(c) + " G: " + green(c) + " B: " + blue(c));

  int hue = int(map(hue(c), 0, 255, 0, 180));
  println(" Hue a detectar: " + hue);

  hueBColorLow = hue - 10;
  hueBColorHigh = hue + 10;

}
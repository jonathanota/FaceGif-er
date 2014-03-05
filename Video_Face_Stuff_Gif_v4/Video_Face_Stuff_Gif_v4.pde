import processing.video.Movie;
import gab.opencv.*;
import processing.video.*;
import org.opencv.highgui.Highgui;
import org.opencv.highgui.VideoCapture;
import java.awt.*;

Capture video;
OpenCV opencv;
Movie movie;
VideoCapture videoCapture;
PImage face, img, vidImg;
int faceNum, nextFrame, nextFaceSet;


ArrayList frames = new ArrayList();

void setup() {
  size(1280, 720);
  background(0);
  nextFrame = 0;
  nextFaceSet = 0;

  //video = new Capture(this, width, height);
  movie = new Movie(this, "biebs.mov");
  opencv = new OpenCV(this, width, height);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
  

  movie.play();
  imageMode(CENTER);

}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  background(0);

  // movie stuff
  movie.speed(.25);
  movie.loadPixels();

  vidImg = createImage(width, height, RGB);
  arrayCopy(movie.pixels, vidImg.pixels);
  image(vidImg, width/4, height/2, width/2, height/2);

  //start openCV analysis
  opencv.loadImage(vidImg);

  //create PImage to store video frames
  img = createImage(width, height, RGB);
  //video.loadPixels();

  //this detects faces
  Rectangle[] faces = opencv.detect();
  faceNum = faces.length;

  if (faceNum > 0) {
    println(faces.length);

    //copys video pixels to the PImage "img"
    // arrayCopy(video.pixels, img.pixels);
    arrayCopy(vidImg.pixels, img.pixels);

    //This grabs the face location
    for (int i = 0; i < faces.length; i++) {
      println(faces[i].x + "," + faces[i].y + "," + faces[i].width + "," + faces[i].height);  
      face = img.get(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
      image(face, width - width/4, height/2);
      face.resize(300,300);
      face.save("Face Set: " + nextFaceSet + "Face Number: " + faces.length + "_face_" + nextFrame + ".jpg");
      nextFrame = nextFrame+1;
    }
      
    
    nextFaceSet++;
  }
}


void captureEvent (Capture c) {

  //reads current video frame
  c.read();

  //adds the resulting PImage to the "frames" arraylist
  //  frames.add(img);
  //
  //  if (frames.size() > height/4) {
  //    frames.remove(0);
  //  }
}



void keyPressed() {
}

import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
FFT fft;
AudioInput in;

String songName;
String songPath;
boolean songLoaded = false;
boolean songPlaying = false;

PShape poly;
int sides;
float r;
float mult;

float audio;
float angle;
float z;
float x;
float y;
    
int colorIndex;
color currentColor;
color[] colors = {
  color(255, 255, 255),
  color(255, 0, 0),
  color(0, 255, 0),
  color(0, 0, 255)
};

float arr;
FloatList floatX;
ArrayList<FloatList> floats;

int vizWidth;
int lines;

void setup() {
  floats = new ArrayList<FloatList>();
  if (sketchFullScreen()) {
    size(displayWidth, displayHeight, P2D); 
  } else {
    size(500, 500, P2D);
  }
  minim = new Minim(this);
  songPath = "./jd.mp3";
  songName = songPath;
  songLoaded = true;
  sides = 360;
  r = 100;
  mult = 100;
  colorIndex = 0;
  currentColor = colors[colorIndex];
  background(0);
  lines = 30;
}


void draw() {
  if (songLoaded) {
    if (!songPlaying) {
      song = minim.loadFile(songName, width);
//      song.mute();
      song.play();
     
      songPlaying = true;
    }
    audioViz();
  }
}


void audioViz() {
  vizWidth = 400;
  background(0);
  
  floatX = new FloatList();
  for (int i = 0; i < vizWidth; i++) {
      audio = song.mix.get(i);
      z = r + (audio * mult) + 30;
      floatX.append(z);
  }
  if (floats.size() == lines) {
    floats.remove(0);
  }
  floats.add(floatX);
  
  for(int i=0; i < floats.size(); i++) {
    poly = createShape();
    poly.beginShape();
    for (int j = 0; j < vizWidth; j++) {
        arr = floats.get(i).get(j);
        poly.fill(0, 0, 0);
        poly.stroke(currentColor);
        if (j == vizWidth-1 || j == vizWidth-2) {
          poly.stroke(0);
        }
        poly.vertex(j, arr);
    }
    
    poly.vertex(vizWidth, height);
    poly.vertex(0, height);
    poly.endShape();
    shape(poly, (width - vizWidth)/2, i*7);
  }
  println(frameRate);
}


boolean sketchFullScreen() {
  return false;
}

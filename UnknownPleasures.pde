import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
FFT fft;

float mult;
float audio;
ArrayList<PShape> waves;
int vizWidth;
int lines;
float xOffset;
float yOffset;
PShape wave;

float[] multArr;
int ctr;

void setup() {
	if (sketchFullScreen()) {
		size(displayWidth, displayHeight, P2D);
	} else {
		size(500, 500, P2D);
	}
	background(0);
	waves = new ArrayList<PShape>();
	mult = 100;
	lines = 30;
	vizWidth = 300;
	xOffset = (width - vizWidth)/2;
	yOffset = 100;
	minim = new Minim(this);
	song = minim.loadFile("./jd.mp3", vizWidth);
	// song.mute();
	song.play();
	multArr = new float[vizWidth];
	for (int i = 0; i < vizWidth; i++) {
		if (i >= vizWidth/2) {
			ctr--;
		} else {
			ctr++;
		}
		multArr[i] = ctr;
	}
}


void draw() {
	background(0);
	wave = createShape();
	wave.beginShape();
	for (int i = 0; i < vizWidth; i++) {
		wave.stroke(255);
		if (i == vizWidth-1 || i == vizWidth-2) wave.noStroke();
		wave.fill(0);
		audio = song.mix.get(i) * (multArr[i] / 1.3);
		wave.vertex(i, audio);
	}
	wave.stroke(0);
	wave.vertex(vizWidth, height);
	wave.vertex(0, height);
	wave.endShape();

	if (waves.size() == lines) {
		waves.remove(0);
	}
	waves.add(wave);

	if (waves.size() == lines) {
		for (int i = 0; i < lines; i++) {
			shape(waves.get(i), xOffset, yOffset+(i*7));
		}
	}
	println(frameRate);
}


boolean sketchFullScreen() {
	return false;
}

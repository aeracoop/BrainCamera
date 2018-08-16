import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;
import com.dhchoi.CountdownTimer;
import com.dhchoi.CountdownTimerService;

//CountdownTimer timer;
//CountdownTimer goal;
//final int idTimer;// = 0;
//int idGoal = 1;

// Timer that has been configured to trigger onTickEvents every 1s and run for 4m
CountdownTimer  timer = CountdownTimerService.getNewCountdownTimer(this).configure(1000, 240000);
CountdownTimer  goal = CountdownTimerService.getNewCountdownTimer(this).configure(100, 1000);
final int idTimer = timer.getId();
final int idGoal = goal.getId();

String timerCallbackInfo = "[ Tiempo restante: 4:00 ]";
int sEnd=0;              //Segundos para el final del ejercicio.
int mEnd=0;              //Minutos para el final del ejercicio;

int nivel = 1;           //Nivel del juego, 1, 2 o 3
int modo = 0;            //Modo de pantalla 0 Bienvenida, 1 Juego, 2 Salida

//int tDesanso = 400;      //Miliegundos de descanso entre ejercicios

String palabraActual=""; //Palabra del ejercicio actual
int tipoPalabra=0;       //Tipo de ejercicio: 0, Dos manos, 1 Izquierda, 2 Derecha
int ejActual=1;          //Numero de ejercicio
//int ejTotal=0;           //Numero de ejercicios realizados
int nAciertos=0;        //Numero de ejercicios acertados
//int ejFallados=0;        //Numero de ejercicios fallados

int minDistancia = 100;  //Distancia minima para considerar un acierto
int rCircle = 80;       //Radio del círculo de las manos
int rGoal = 200;

PVector objA;            //Posicion objetivo A Izquierda
PVector objB;            //Posicion objetivo B Derecha
PVector detA;            //Posicion detectada A Izquierda
PVector detB;            //Posicion detectada B Derecha
color colorA;
color colorB;

//OpenCV section
Capture cam;
OpenCV opencv;

int sWidth = 1280;      //Resolucion horizontal
int sHeight = 720;        //Resolucion vertical

//boolean drawGame = true;

void setup() {
  size(1280, 720);//1280x720
  //fullScreen();

  objA = new PVector (sWidth/4, sHeight/4);
  objB = new PVector (3*(sWidth/4), sHeight/4);
  colorA = color(250, 0, 0);
  colorB = color(0, 0, 250);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, 1280, 720, 30);// cameras[11]);//11 - 1280 x 720
    cam.start();
  }    

  opencv = new OpenCV(this, cam.width, cam.height);
  contours = new ArrayList<Contour>();
  //imageMode(CENTER);

  textSize(38);
  textAlign(CENTER, CENTER);

  ellipseMode(CENTER);
}

void draw() {
  if (cam.available() == true) {
    cam.read();    
    vision();
  }

  switch(modo)
  {
  case 0:
    drawBienvenida();
    break;
  case 1:
    drawJuego();
    break;
  case 2:
    drawSalida();
    break;
  }
}

void onTickEvent(CountdownTimer t, long timeLeftUntilFinish) {

  if (t.getId() == idTimer) {
    sEnd = int(timeLeftUntilFinish / 1000);
    mEnd = int (sEnd/60);
    timerCallbackInfo = "[ Tiempo restante: " + mEnd+" : "+ sEnd%60+ " ]";
  }
  if (t.getId() == idGoal) {
    rGoal = rGoal - 20;
    if (!sobreAcierto()){
      rGoal = 200;
      goal.reset(CountdownTimer.StopBehavior.STOP_IMMEDIATELY);
    }
  }
}

void onFinishEvent(CountdownTimer t) {
  if (t.getId() == idTimer) {
    timerCallbackInfo = "[ Finalizado 0:00 ]";
    goSalida();
  }
  if (t.getId() == idGoal){
    rGoal = 200;
    acierto();
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      updateAColor();
    } else if (keyCode == RIGHT) {
      updateBColor();
    }
  } else if (keyCode == ENTER) {
    switch(modo)
    {
    case 0:
      goJuego();
      break;
    case 1:
      goSalida();
      break;
    case 2:
      goBienvenida();
      break;
    }
  } else if (keyCode == ESC) {
    timer.stop(CountdownTimer.StopBehavior.STOP_AFTER_INTERVAL);
    exit();
  }
}

/*
import gohai.glvideo.*;
 GLCapture video;
 
 void setup() {
 size(320, 240, P2D);
 
 String[] devices = GLCapture.list();
 println("Devices:");
 printArray(devices);
 if (0 < devices.length) {
 String[] configs = GLCapture.configs(devices[0]);
 println("Configs:");
 printArray(configs);
 }
 
 // this will use the first recognized camera by default
 video = new GLCapture(this);
 
 // you could be more specific also, e.g.
 //video = new GLCapture(this, devices[0]);
 //video = new GLCapture(this, devices[0], 640, 480, 25);
 //video = new GLCapture(this, devices[0], configs[0]);
 
 video.start();
 }
 
 void draw() {
 background(0);
 if (video.available()) {
 video.read();
 }
 image(video, 0, 0, width, height);
 }
 */

/*
var capture;
 
 function setup() {
 createCanvas(390, 240);
 capture = createCapture(VIDEO);
 capture.size(320, 240);
 //capture.hide();
 }
 
 function draw() {
 background(255);
 image(capture, 0, 0, 320, 240);
 filter('INVERT');
 }
 
 */
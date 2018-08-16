
void goJuego() {
  timer.start();
  modo = 1;
  nAciertos=0;
  ejActual = 1;
  generarItem();
}

void acierto() {
  nAciertos++;
  ejActual++;
  generarItem();

  fill(255, 255);
  rectMode(CENTER);
  rect(sWidth/10, 5* (sHeight/6), 240, 150, 20);
}

void generarItem() {
  palabraActual = "";
  //Generamos una letra
  char c = (char) int(random(65, 90)); 
  int n = 0;
  switch(nivel) {
  case 1:
    palabraActual = str(c);
    break;
  case 2:
    n = int(random(0, 9));
    palabraActual = str(c) + str(n);
    break;
  }

  tipoPalabra = int(random(0, 3));
  // println("Item: " + palabraActual);
}

//Pantalla de Juego
void drawJuego() {
  stroke (255, 125);
  fill(255, 128);
  rectMode(CENTER);
  rect(sWidth/2, 20, 500, 70, 20);
  fill(0, 255);
  text(timerCallbackInfo, sWidth/2, 20);

  fill(255, 100);
  rect(sWidth/10, 5* (sHeight/6), 240, 150, 20);
  fill(0, 255);
  text( "Aciertos: "+ nAciertos, sWidth/10, 5* (sHeight/6), 240, 150);

  drawEsferas();
  drawPalabra();
  processPoints();
}


void drawPalabra() {
  rectMode(CENTER);
  fill(255, 200);
  stroke (255, 125);
  rect(sWidth/2, (sHeight/2)-80, 80, 80, 20);
  fill(0, 255);
  text(palabraActual, sWidth/2, (sHeight/2)-80, 100, 100);

  switch(tipoPalabra) {
  case 0:
    fill(colorA, 250);
    ellipse((sWidth/2)-60, (sHeight/2)+60, 80, 80);
    fill(colorB, 255);
    ellipse((sWidth/2)+60, (sHeight/2)+60, 80, 80);
    break;
  case 1:
    fill(colorA, 250);
    ellipse((sWidth/2), (sHeight/2)+60, 80, 80);
    break;
  case 2:
    fill(colorB, 250);
    ellipse((sWidth/2), (sHeight/2)+60, 80, 80);
  }
}

void drawEsferas() {

  //fill(colorA, 100);
  noFill();
  strokeWeight(5);
  stroke(colorA, 250);
  if (sobreA() && (tipoPalabra == 1 || tipoPalabra == 0))
    ellipse(objA.x, objA.y, rGoal, rGoal);
  else
    ellipse(objA.x, objA.y, 200, 200);

  //fill(colorB, 100);
  stroke(colorB, 250);
  if (sobreB() && (tipoPalabra == 2 || tipoPalabra == 0))
    ellipse(objB.x, objB.y, rGoal, rGoal);
  else
    ellipse(objB.x, objB.y, 200, 200);

  //}
}

void processPoints() {

  if (sobreA() && !sobreB() && tipoPalabra == 1)
  goal.start();

  if (sobreB() && !sobreA() && tipoPalabra == 2)
  goal.start();

  if (sobreA() && sobreB() && tipoPalabra == 0)
  goal.start();
}

boolean sobreAcierto() {
  if (sobreA() && tipoPalabra == 1)
  return true;

  if (sobreB() && tipoPalabra == 2)
  return true;

  if (sobreA() && sobreB() && tipoPalabra == 0)
  return true;

  return false;
}

boolean sobreA() {
  detA = new PVector (rA.x + rA.width/2, rA.y + rA.height/2);
  if (objA.dist(detA)< minDistancia)
  return true;
  else
    return false;
}

boolean sobreB() {
  detB = new PVector (rB.x + rB.width/2, rB.y + rB.height/2);
  if (objB.dist(detB)< minDistancia)
  return true;
  else
    return false;
}


//goal.start();   isRunning() == false
/*
void aciertoA() {
 if (!goal.isRunning())
 goal.start();
 generarItem();
 }*/
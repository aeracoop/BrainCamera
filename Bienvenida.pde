
String instrucciones = "Colocate a una distancia de la cámara suficiente para alcanzar cada círculo con cada mano.";
//Para reconocer las pelotas, coloca la pelota izquierda sobre el círculo izquierdo y pulsa flecha izquierda.
//Después, coloca la pelota derecha sobre el círculo derecho y pulsa flecha derecha.  ";
String instrIzq = "Flecha izquierda para calibrar la pelota izquierda.";
String instrDer = "Flecha derecha para calibrar la pelota derecha.";
String instrIntro = "ENTER para comenzar el juego.";

void goBienvenida() {
  modo = 0;
}

//Pantalla de Bienvenida
void drawBienvenida() {
  // image(cam, 0, 0);//width/2, height/2);//,width,height);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);

  drawEsferas();
  //ellipse(objA.x,objA.y,100,100);
  drawInstrucciones();
}

void drawInstrucciones() {
  stroke (255,125);
  fill(255, 100);
  rectMode(CENTER);
  rect(sWidth/2, sHeight/2, 900, 140, 20);
  fill(0, 255);
  text( instrucciones, sWidth/2, sHeight/2, 900, 140);

  /*fill(255, 100);
  rect(sWidth/6, 4* (sHeight/5), 400, 200, 20);
  fill(0, 255);
  text( instrIzq, sWidth/6, 4* (sHeight/5), 400, 200);

  fill(255, 100);
  rect(5 * (sWidth/6), 4* (sHeight/5), 400, 200, 20);
  fill(0, 255);
  text( instrDer, 5 * (sWidth/6), 4* (sHeight/5), 400, 200);*/

  fill(255, 100);
  rect((sWidth/2), 4* (sHeight/5), 400, 200, 20);
  fill(0, 255);
  text( instrIntro, (sWidth/2), 4* (sHeight/5), 400, 200);
}
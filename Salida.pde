
String instrVolver = "Pulsa ENTER para volver a jugar.";
String instrSalir = "Pulsa ESCAPE para salir.";


void goSalida() {
  timer.stop(CountdownTimer.StopBehavior.STOP_AFTER_INTERVAL);
  modo = 2;
}

//Pantalla de Salida
void drawSalida() {
  rectMode(CENTER);
  fill(255, 100);
  rect(sWidth/2, (sHeight/3), 600, 300, 20);
  fill(0, 255);
  text("Has obtenido "+nAciertos+", de un total de "+ejActual+" jugadas.", sWidth/2, sHeight/3, 600, 300);

  fill(255, 100);
  rect(sWidth/6, 4* (sHeight/5), 400, 200, 20);
  fill(0, 255);
  text( instrVolver, sWidth/6, 4* (sHeight/5), 400, 200);

  fill(255, 100);
  rect(5 * (sWidth/6), 4* (sHeight/5), 400, 200, 20);
  fill(0, 255);
  text( instrSalir, 5 * (sWidth/6), 4* (sHeight/5), 400, 200);
}
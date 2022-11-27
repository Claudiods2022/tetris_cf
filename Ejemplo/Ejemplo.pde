boolean test=true;



int l, h, DX, DY, L, H, i, j, DADO, t=0, x=0, y=0, mx=0, my=0;
float r, g, b;
int sensores[]=new int[10];
boolean giro=false, nuevapieza=false;
int M[][]= new int [10][20];
int P[][]= new int [4] [4];

void setup () {
  frameRate(2);
  size (600, 600);
  background (255);
  DX = (width* 25)/ 100;
  DY = (height * 5)/ 100;
  L = width - 2 * DX;
  H = height - 2 * DY; /* pantalla azul rect grande */
  l = L / 10; /* ancho y largo de cuadrados chiquitos */
  h = H / 20; /* L --> long, H --> high */

  limpiar();
  limpiarpieza();
  nuevapieza=true;
}


void draw () {
  //  pantalla ();
  background(0);
  fondo();
  if (test==true) Jugador();
  sensados();
  mensajes();

  
}


void sensados(){
   pushMatrix();
    fill(255);
    textSize(30);
    for(int c=0;c<10;c++)
    {
      text(1,DX+5+l*c,h*21);
    }
   popMatrix();
}

void mensajes()
{
  textSize(30);
  text("("+mx+","+(h*t)+")", 0, 20);
}



void limpiar () {
  for (i=0; i<20; i++) {
    for (j=0; j<10; j++) {
      M[j][i] = 0;
    }
  }
}

void limpiarpieza() {
  for (i=0; i<4; i++) {
    for (j=0; j<4; j++) {
      P[j][i] = 0;
    }
  }
}


void fondo() {
  fill (155);
  quad (DX-20, DY-20, DX+L+20, DY-20, DX+L+20, DY+H+20, DX-20, DY+H+20);
  for (i = 0; i < 10*l; i = i +l) { /* for para dibujar cada columna*/
    for (j=0; j<20 *h; j = j + h) {/* for para dibujar cada fila */
      if (M [i/l] [j/h] == 0) { /* si es == 0 es porque no hay una pieza ahi. */
        fill (0);
        stroke (130);
        rect (DX + i, DY+j, l, h);
      }
    }
  }
}

void Jugador() {
  if (nuevapieza==true)
  {
    DADO = int (random (0, 7));
    nuevapieza=false;

    switch (DADO) {
    case 0: // pieza en L E1(naranja)

      P[1][0] = 1;
      P[1][1] = 1;
      P[1][2] = 1;
      P[2][2] = 1;
      r = 255;
      g = 164;
      b = 32;
      break;

      //// pieza L invertida (azul)
    case 1: // E1
      P[2][0] = 1;
      P[2][1] = 1;
      P[2][2] = 1;
      P[1][2] = 1;
      r= 0;
      g = 0;
      b = 255;
      break;

      // Z Invertida roja
    case 2: // pieza Z invertida E1(roja)
      P[0][1] = 1;
      P[1][1] = 1;
      P[1][0] = 1;
      P[2][0] = 1;
      r = 255;
      g = 0;
      b = 0;
      break;


      // T violeta
    case 3: // pieza T E1(violeta)
      P[0][1] = 1;
      P[1][1] = 1;
      P[1][0] = 1;
      P[2][1] = 1;
      r = 255;
      g = 0;
      b = 255;
      break;


      // pieza | (palito) E1(celeste)
    case 4:
      P[1][0] = 1;
      P[1][1] = 1;
      P[1][2] = 1;
      P[1][3] = 1;
      r = 81;
      g = 209;
      b = 246;
      break;


      // pieza cuadrado # E1 (es un cuadrado el hastag) (amarrillo)
    case 5:
      P[1][0] = 1;
      P[2][0] = 1;
      P[1][1] = 1;
      P[2][1] = 1;
      r = 255;
      g = 255;
      b = 0;
      break;
    }
  }
  dibujapieza(r, g, b);
  t++;
}

void dibujapieza(float rojo, float verde, float azul) {

  if (h*t<=513)
  {
    pushMatrix();

    translate(l*mx, h*t);
    if (giro==true)
    {
      rotate(90);
      giro=false;
    }
    for (i=0; i<4; i++) {
      for (j=0; j<4; j++) {

        if (P[i][j]==1) {
          fill(rojo, verde, azul);
        }
        rect(DX, DY, l*i, h*j);
      }
    }
    popMatrix();
  } else {
    t=-1;
    nuevapieza=true;
    test=false;
  }
}

void keyPressed() {
  if ((key =='w') || (key =='W')) giro=true;
  else if ((key =='A') || (key =='a')) mx--;
  else if ((key =='d') || (key =='D')) mx++;

  delimitadores();
}


void delimitadores()
{
  if (mx<=0) mx=0;
  if (mx>=9) mx=9;
}

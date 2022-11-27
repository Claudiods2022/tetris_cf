//variables dimensionales
int l, h, DX, DY, L, H;
int P[][]=new int[4][4];
int M[][]= new int [10][20];

// variables usuario;
int mx=0,my=0,t=0;
float r=0, g=0, b=0;
boolean nuevapieza=false; 

// variables pruebas
boolean test=true;
boolean giro=false;
int sensores[]={1,2,0,0,0,0,0,0,0,0};





void setup () {
  frameRate(8);
  size (600, 600);
  background (255);
  DX = (width* 25)/ 100;
  DY = (height * 5)/ 100;
  L = width - 2 * DX;
  H = height - 2 * DY; /* pantalla azul rect grande */
  l = L / 10; /* ancho y largo de cuadrados chiquitos */
  h = H / 20; /* L --> long, H --> high */

  limpiar();
  nuevapieza=true;
}


void draw () {
  //  pantalla ();
  if(test==true)
  {
    background(0);
    fondo();  
    if (test==true) Jugador();
    sensados();
    mensajes();
  }
}


void sensados(){
   pushMatrix();
    fill(255);
    textSize(30);
    for(int c=0;c<10;c++)
    {
      if (test==true) text("T",DX+5+l*c,h*(21-sensores[c]));
      else text("F",DX+5+l*c,h*l*c,h*(21-sensores[c]));
    }
   popMatrix();
}

void mensajes()
{
  textSize(30);
  text("("+mx+","+(h*t)+")", 0, 20);
}



void limpiar () {
  
  for (int i=0; i<20; i++) {
    for (int j=0; j<10; j++) {
      M[j][i] = 0;
    }
  }
}



void fondo() {
  fill (155);
  quad (DX-20, DY-20, DX+L+20, DY-20, DX+L+20, DY+H+20, DX-20, DY+H+20);
  for (int i = 0; i < 10*l; i = i +l) { /* for para dibujar cada columna*/
    for (int j=0; j<20 *h; j = j + h) {/* for para dibujar cada fila */
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
    int DADO = int (random (0, 7));
    DADO=0;
    nuevapieza=false;

    switch (DADO) {
      
      case 0: // pieza en L E1(naranja)

      P[1][0] = 1;
      P[1][1] = 1;
      P[1][2] = 1;
      P[2][2] = 1;
      r= 0;
      g = 0;
      b = 255;
      break;
      
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

  if (h*t<=h*18)
  {
    pushMatrix();

    if (giro==true)
    {
      rotate(90);
      giro=false;
    }
    translate(l*mx, h*t);
    
    for (int i=0; i<4; i++) {
      for (int j=0; j<4; j++) {
        fill(255);
        if (P[i][j]==0)
        {
              text("0",DX+l*i,h*j);
        }else{
              fill(rojo, verde, azul);
              text("1",DX+l*i,h*j);
        }  
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
  else if ((key=='s') || (key=='s')) my=2;
  delimitadores();
}


void delimitadores()
{
  if (mx<=0) mx=0;
  if (mx>=9) mx=9;
}

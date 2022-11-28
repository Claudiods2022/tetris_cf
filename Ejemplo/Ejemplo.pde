//variables dimensionales
int l, h, DX, DY, L, H;
int P[][]=new int[4][4];
int M[][]= new int [10][20];

// variables usuario;
int mx=0,t=0,giro=0;
float r=0,g=0, b=0,vy=1;
boolean nuevapieza=false; 


// variables pruebas
boolean test=true;
int sensores[]={21,21,21,21,21,21,21,21,21,21};





void setup () {
  frameRate(8);
//  smooth();
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
    
    background(0);
    fondo();
    sensado();

    if(test==true) Jugador();
    else dibutest();            //dibujo estatico de la pieza
    mensajes(); 
    
     
}

void dibutest()
{
   pushMatrix();
         translate(DX+l*mx,DY+h*(t-2));
         rotate(PI/2*r);   
     
      for (int i=0; i<4; i++) 
      {
        
        for (int j=0; j<4; j++) 
        {
            
              if (P[i][j]==1) fill(100);
              text(P[i][j],l*i,h*j);
              if(P[i][j]==1) rect (l*i, h*j, l, h);
              
        }   
      }
      
    popMatrix();      
}

boolean sensado(){

    pushMatrix();
    boolean toque=false;
    fill(255);
    textSize(30);
    for(int c=0;c<10;c++)
    {
      if (test==true) text("T",DX+5+l*c,h*(sensores[c]));
      else text("F",DX+5+l*c,h*l*c,h*(sensores[c]));
         
         
      //Solucion temporal por que se debe analizar una solucion mas compleja donde intervienen las formas de las piezas;
      toque=false;
      if(h*sensores[c]==h*t)
      {
         toque=true;
         break;
      }
    }
   popMatrix();

   return toque;
   
}

void mensajes()
{
  pushMatrix();
  fill(255);
  textSize(30);
  text("("+mx+","+(h*t)+")", 0, 20);
  popMatrix();
}



void limpiar () {  
  for (int i=0; i<20; i++) {
    for (int j=0; j<10; j++) {
      M[j][i] = 0;
    }
  }
}



void fondo() {
  pushMatrix();
  translate(0,0);
  fill (155);
  quad (DX-20, DY-20, DX+L+20, DY-20, DX+L+20, DY+H+20, DX-20, DY+H+20);
  for (int i = 0; i < 10*l; i = i +l) { /* for para dibujar cada columna*/
    for (int j=0; j<20 *h; j = j + h) {/* for para dibujar cada fila */
      if (M [i/l] [j/h] == 0) { 
        fill (0);
        stroke (130);
        rect (DX + i, DY+j, l, h);
      }
    }
  }
  popMatrix();
}

void Jugador() {
  if (nuevapieza==true)
  {
     int DADO =(int) random (0, 5);
    
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

void dibujapieza(float rojo, float verde, float azul) 
{
   if(sensado()==false)
    { 
       pushMatrix();
         translate(5+DX+l*mx,DY+h*t*vy);
         rotate(PI/2*giro);   
     
      for (int i=0; i<4; i++) 
      {
        
        for (int j=0; j<4; j++) 
        {
            fill(255);
            
              if (P[i][j]==1) fill(rojo, verde, azul);
              text(P[i][j],l*i,h*j);
              if(P[i][j]==1) rect (l*i, h*j, l, h);
              
        }   
      }
      
       popMatrix();      
    
  }else
  {
    //t=-1;
    vy=0;
    nuevapieza=true;
    test=false;
  }
  
  
  
}

void keyReleased() {
  if ((key =='w') || (key =='W'))giro++;
  if(giro==4) giro=0;
  vy=1;
}

void keyPressed()
{
  if ((key =='A') || (key =='a')) mx--;
  else if ((key =='d') || (key =='D')) mx++;
  else if ((key=='s') || (key=='S')) vy=2;
  delimitadores();
 
}


void delimitadores()
{
  if (mx<=0) mx=0;
  if (mx>=9) mx=9;
}

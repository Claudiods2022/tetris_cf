//variables dimensionales
int P[][]=new int[4][4];
int l, h, DX, DY, L, H;


// variables usuario;

int mx=0,t=0,giro=0;
float r=0,g=0, b=0,vy=1;
boolean nuevapieza=false; 


// variables pruebas
boolean test=true;
int sensores[]={21,21,21,21,21,21,21,21,21,21};

int noventa[][]={{1, 0,0,0},
                 {0, 0,1,0},
                 {0,-1,0,1}
                 };





void setup () {
  
  size (600, 600);
  smooth();
  background (255);
  DX = (width* 25)/ 100;
  DY = (height * 5)/ 100;
  L = width - 2 * DX;
  H = height - 2 * DY; /* pantalla azul rect grande */
  l = L / 10; /* ancho y largo de cuadrados chiquitos */
  h = H / 20; /* L --> long, H --> high */


  nuevapieza=true;
}


void draw () {
    
    if(frameCount%8==0)
    {
      background(0);
      fondo();
      if(test==true) Jugador();
      else dibutest();            
    }
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
          
        if(get(DX+c*l,DY+sensores[c]*h)!=#FF000000)
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
  
// text(hex(get(DX+1*l,DY+sensores[1]*h)),0,60);
  popMatrix();
}




void fondo() {
  pushMatrix();
  translate(0,0);
  fill (155);
  quad (DX-20, DY-20, DX+L+20, DY-20, DX+L+20, DY+H+20, DX-20, DY+H+20);
  for (int i = 0; i < 10*l; i = i +l) { /* for para dibujar cada columna*/
    for (int j=0; j<20 *h; j = j + h) {/* for para dibujar cada fila */
        fill (0);
        stroke (130);
        rect (DX + i, DY+j, l, h);     
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
   pushMatrix();
         translate(DX+l*mx,DY+h*t*vy);
         rotate(PI/2*giro);   
     
        for (int i=0; i<4; i++) 
        {
        
          for (int j=0; j<4; j++) 
          {
            fill(255);
            
              if (P[i][j]==1) fill(rojo, verde, azul);
              text(P[i][j],l*i,h*j);
              if(P[i][j]==1) rect (l*i, h*(j-1), l, h);
              
          }   
        }
      
   popMatrix();      
    
   if(sensado()==true)
   { 
    t=t-1;
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


boolean multimatiz(int[][] a,int[][] b)
{
  int[][] c=new int[3][3];
  for(int i=0;i<3;i++){    
    for(int j=0;j<3;j++){    
      c[i][j]=0;      
      for(int k=0;k<3;k++)      
      {      
        c[i][j]+=a[i][k]*b[k][j];      
      }  
    }  
       
  }
  return false;
}  

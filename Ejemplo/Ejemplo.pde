//variables dimensionales
int P[][]=new int[4][4];
int l, h, DX, DY, L, H;

//variable de juego
int st;

// variables usuario;
int mx=0,t=0,giro=0,vy=1;
float r,g,b;
 
boolean nuevapieza=false; 


// variables pruebas
boolean test=true;
int sensores[]={21,21,21,21,21,21,21,21,21,21};

float R[][]={ { 0, 0, 1, 0},
              { 0, 1, 0, 0},
              { 1, 0, 0, 0},
              { 0, 0, 0, 1}};





void setup () {
  
  size (600, 600);
  smooth();
  background (255);
  DX = (width* 25)/ 100;
  DY = (height * 5)/ 100;
  L = width - 2 * DX;
  H = height - 2 * DY;   l = L / 10; 
  h = H / 20; 


  nuevapieza=true;
}


void draw () {
    
    background(0);
    fondo();
    if(test==true) Jugador();
    else dibutest();            
    mensajes();

    if(frameCount%10==0) t++;
     
}



void dibutest()
{
   pushMatrix();
      translate(DX+l*mx,DY+h*(st-1));   
      
      for (int i=0; i<4; i++) 
      {
        
        for (int j=0; j<4; j++) 
        {
            
              if (P[i][j]==1) fill(100);
              text(P[i][j],l*i,h*(j-1));
              if(P[i][j]==1) rect (l*i, h*j, l, h);
              
        }   
      }
      
    popMatrix();      
}

boolean sensado(){
  
   boolean toque=false;
   
   pushMatrix();
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
  text("("+mx+","+(h*t*vy)+")", 0, 20);
  text(giro, 0, 60);
  
  popMatrix();
}




void fondo() {
  pushMatrix();
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
    int DADO =(int) random(0, 5);
    nuevapieza=false;
    vy=1;
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
  

}

void dibujapieza(float rojo, float verde, float azul) 
{
   pushMatrix();
   translate(DX+l*mx,DY+h*t*vy);
   for (int i=0; i<4; i++) 
   { 
     for (int j=0; j<4; j++) 
     {
    
       fill(255);
       if (P[i][j]==1)
       {
         fill(rojo, verde, azul);
         rect(l*i, h*(j-1), l, h);
       }
       if (test==true)text(P[i][j],l*i,h*j);       
     }   
   }   
   popMatrix();      
    
   if(sensado()==true)
   { 
    st=t-1;
    nuevapieza=true;
    test=false;
   }
  
  
  
}

void keyReleased() {
  if ((key =='w') || (key =='W'))
  {
    switch(giro)
    {
      case 0:
        
        P=Tmat(P);
        giro=1;
        break;
      case 1:
        P=Rmat(P);
        giro=0;
        break;
    }
  }
  
}

void keyPressed()
{
  if ((key =='A') || (key =='a')) mx--;
  else if ((key =='d') || (key =='D')) mx++;
  else if ((key=='s') || (key=='S')) vy=2;
  else vy=1;
  delimitadores();
 
}


void delimitadores()
{
  if (mx<=0) mx=0;
  if (mx>=6) mx=6;
}


int[][] Rmat(int[][] a)
{
  int[][] c=new int[4][4];
  for(int i=0;i<4;i++){    
    for(int j=0;j<4;j++){    
      c[i][j]=0;      
      for(int k=0;k<4;k++)      
      {      
        c[i][j]+=R[i][k]*a[k][j];      
      }  
    }  
       
  }
  return c;
}  

int[][] Tmat(int[][] a)
{
  int[][] c=new int[4][4];
  for(int i=0;i<4;i++){    
    for(int j=0;j<4;j++)
    {                
        c[i][j]+=a[j][i];      
     }    
       
  }
  return c;
}  

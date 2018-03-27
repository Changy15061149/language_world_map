final int SCREENX = 600;
final int SCREENY = 600;
final int MARGIN = 10;
final int backgroundcolor = 128;
final int deathrate = 80;
final int bornrate = 126;
int nofx = 600;
int nofy = 350;
int nofz = 50;
final int allResarch = 90;
float sx = 0.6;
float sy = 0.4;
float sx1 = 0.4;
float sy1 = 0.6;
float ck = 0.035;
float cv = 1.0;
float a = 1.0;
float CC = 0.035;////////////////////////C
int SUMNET = 10;
int maxh = 0;
int lang[] = new int[1000];
float SS[] = new float[1000] ;
int sumpopulation = 0;
int migra = 0;
float mig[][] = new float[20][20];

void newhuman(human h[],int con,int x,int y,int ll1,int ll2,int inij)
{
  h[maxh] = new human(con,x,y,ll1,ll2,inij);
  sumpopulation ++;
  if(ll1 != -1)lang[ll1] ++;
  if(ll2 != -1)lang[ll2] ++;
  maxh ++;
}
void modifypop(int ll1,int ll2)
{
  sumpopulation --;
  if(ll1 != -1)lang[ll1] --;
  if(ll2 != -1)lang[ll2] --;
}
continent cont[];
color col(int a,int b)
{
  if(b == -1 )
  {
    if(a >= 20)return color(200);
    if(a == 1)return color(127,255,0);
    else if(a == 2)return color(238,230,133);
    else if(a == 3)return color(238,99,99);
    else if(a == 4)return color(138,43,226);
    else if(a == 5)return color(205,183,158);
    else if(a == 6)return color(139,0,0);
    else if(a == 7)return color(0,0,128);
    else if(a == 8)return color(255,255,0);
    else return color(205,205,0);
    //return color((a % 13) * 20,   (a%3) * 100, 255 - (a % 12) * 18);
  }
  else 
  {
   // println("YES!");
    return color(0,0,0);
  }
}
class human
{
  int con;
  int x;
  int y;
  int lang1;
  int lang2 = -1;
  int jump;
  int inij;
  int live = 1;
  int SH = 0;
  human(int c,int xx,int yy,int l1,int l2,int j)
  {
    con = c;
    x = xx;
    y = yy;
    lang1 = l1;
    lang2 = l2;
    jump = j;
    inij = j;
  }
  void jum()
  {
    if(migra == 0)
    {
    int cc = con;
    con = (int)random(0,9);
    if(cont[con].OK != 0 && cont[cc].OK != 0)
    {
    x = (int) random(cont[con].lx,cont[con].rx);
    y = (int) random(cont[con].ly,cont[con].ry);
    jump --;
    }
    else con = cc;
    }
    else
    {
      if(random(0,100) < cont[con].mr)
      {
        jump --;
        float cc = random(0,100)/ 100;int jj;
        for(jj = 0;jj < 9;jj ++)if(cc < mig[con][jj])break;
        con = jj;
        x = (int) random(cont[con].lx,cont[con].rx);
        y = (int) random(cont[con].ly,cont[con].ry);
      }
    }
    
  }
  void dead()
  {
    float bb = cont[con].dr * 10.0;
    if(random(0,1000) < bb)
    {live = 0;modifypop(lang1,lang2);}
  }
  void born(human h[])
  {
    float bb = cont[con].br * 10.0;
    //if(con == 0)bb *= 1.3;
    if(random(0,1000) < bb)
    {
      int ll1,ll2,jj;
      if(lang2 == -1)
      {
        ll1 = lang1;
        ll2 = lang2;
      }
      else
      {
        float a1 = CC * SS[lang1]*1000;
        float a2 = CC * SS[lang2]*1000;
        if(random(0,1000) < a1){ll1 = lang1;ll2 = -1;} 
        else if(random(0,1000) < a2){ll1 = lang2;ll2 = -1;}
        else
        {
          ll1 = lang1;
          ll2 = lang2;
        }
        
      }
      newhuman(h,con,x,y,ll1,ll2,inij);
    }
  }
  void move()
  {
    x += random(-2,2);
    y += random(-2,2);
    if(x < cont[con].lx)x = cont[con].lx;
    if(y < cont[con].ly)y = cont[con].ly;
    if(x > cont[con].rx)x = cont[con].rx;
    if(y > cont[con].ry)y = cont[con].ry;
    
  }
  void learn(human h[])
  {
    int summ = 0;
    for(int i = 0;i < maxh;i ++)
    {
      if((h[i].con == con||SH != 0)&& ((h[i].x - x)*(h[i].x - x) + (h[i].y - y)*(h[i].y - y)) < ((SH == 0)?3000:1000000) && h[i].live != 0 && h[i].lang1 != lang1)
      summ ++;
    }
    for(int i = 0;i < maxh;i ++)
    {
      
      if((h[i].con == con||SH != 0)&& ((h[i].x - x)*(h[i].x - x) + (h[i].y - y)*(h[i].y - y)) < ((SH == 0)?3000:1000000) && h[i].live != 0 && h[i].lang1 != lang1)
      {
        int ll = h[i].lang1;
        //println("ll");
        //println(ll);
        float a1 = CC*SS[ll]*1000/summ;
       // println(a1);
        if(random(0,1000) < a1){lang2 = ll;}
      }
    }
  }
  void draw(human h[])
  {
    if(live != 0)
    {
        move();
        if(lang2 == -1)
        learn(h);
        born(h);
        dead();
        if(migra == 0){
        if(random(0,1000) < 7 && jump > 0)jum();}
        else jum();
        
    for(int i = 0;i < maxh;i ++)
    {
      if((h[i].con == con||SH != 0) && (h[i].x - x)*(h[i].x - x) + (h[i].y - y)*(h[i].y - y) <((SH == 0)? 3000:10000) && h[i].live != 0)
      {
        
       // fill(255);
       if(SH == 0)
        stroke(0,255 - ((h[i].x - x)*(h[i].x - x) +  (h[i].y - y)*(h[i].y - y))/15 );//- (h[i].x - x)*(h[i].x - x) - (h[i].y - y)*(h[i].y - y));
        line( x, y, h[i].x, h[i].y );
      }
    }
    fill(col(lang1,lang2));
    ellipse(int(x), int(y), 5,5);
    }
  }
}
class continent
{
  int OK = 1;
  int lx,rx,ly,ry;
  int initialpopulation;
  int lla;
  float br;
  float dr;
  float mr;
  continent(int x1,int x2,int y1,int y2,int pop)
  {
   lx = x1;rx = x2;
   ly = y1;ry = y2;
   initialpopulation = pop; 
   
  }
}
human h[];
void settings(){
size(SCREENX, SCREENY + 30);
}
void setup(){
  
  SS[1] = 0.0002;//chinese
  SS[2] = 0.0002;//russian
  SS[3] = 0.0002;//Italian
  SS[4] = 0.0002;// Portuguese;
  SS[5] = 0.00008;//German;
  SS[6] = 0.000037;//Span
  SS[7] = 0.024;//French
  SS[8] = 0.054;//Hindi
  SS[9] = 0.74;//English
  SS[10] = 0.0002;//Japanese
  
  h = new human[20000];
  cont = new continent[10];
  cont[0] = new continent(0,199,0,199,138*2);//china
  cont[0].br = 0.705;
 cont[0].dr = 0.71;
  cont[1] = new continent(0,199,200,399,14*2);
  cont[1].br = 1.0;
  cont[1].dr = 1.3;
  cont[2] = new continent(0,199,400,599,74*2);//
  cont[2].br = 1.05;
  cont[2].dr = 1.0;
  cont[3] = new continent(200,399,0,199,131*2);
  cont[3].br = 1.19;
  cont[3].dr = 0.73;
  cont[4] = new continent(200,399,200,399,13*2);
   cont[4].br = 0.05;
   cont[4].dr = 0.85;
  cont[5] = new continent(200,399,400,599,36*2);//
   cont[5].br = 0.88;
  cont[5].dr = 0.82;
  cont[6] = new continent(400,599,0,199,121*2);//
   cont[6].br = 5.06;
 cont[6].dr = 3.4;
  cont[7] = new continent(400,599,200,399,64*2);//
   cont[7].br = 1.7;
 cont[7].dr = 0.7;
  cont[8] = new continent(400,599,400,599,4*2);//
   cont[8].br = 1.5;
 cont[8].dr = 0.7;
  for(int i = 0;i < 9;i ++){int jkjk = 0;
   for(int j = 0;j < cont[i].initialpopulation;j ++)
   
   {
     int jjk = 0;
     /*
     if(i == 0){if(random(0,14) <= 9)jjk = 1;else jjk = (int)random(50,100);}
     if(i == 1){jjk = 2;}
     if(i == 2){int cc = (int)random(0,83); if(cc <= 7)jjk = 3;else if(cc <= 27) jjk = 4; else if(cc <= 40)jjk = 5; else if(cc <= 60)jjk = 6; else if(cc <= 74) jjk = 7;else jjk = 4; }
     if(i == 3){if(random(0,14) <= 1) jjk = 8;else if(random(0,14) <= 1) jjk = 9; else jjk = (int)random(20,50);}
     if(i == 4){jjk = 10;}
     if(i == 5){if(random(0,100) < 70)jjk = 9;else if(random(0,100)< 30) jjk = 7; else jjk = (int)random(20,50);}
     if(i == 6){jjk = (int)random(20,50);}
     if(i == 7){int cc = (int)random(0,100); if(cc < 20)jjk = 6;else jjk = (int)random(20,50);}
     if(i == 8){if(random(0,100) < 70)jjk = 9;else if(random(0,100)< 30) jjk = 7; else jjk = (int)random(20,50);}*/
     
     if(i == 0){if(j < 85*2) jjk = 1; else jjk = (int)random(20,50);}
     if(i == 1){jjk = 2;}
     if(i == 2){if(j < 6*2) jjk = 3; else if(j < 15*2) jjk = 4; else if(j < 24 * 2) jjk = 5; else if(j < 33 * 2)jjk = 6; else if(j < 37 * 2) jjk = 7;else jjk = (int)random(50,80);}
     if(i == 3){if(j < 7*2) jjk = 8;else if(j < 14*2) jjk = 9; else jjk = (int)random(80,100);}
     if(i == 4){jjk = 10;}
     if(i == 5){if(j < 23*2) jjk = 9; else jjk = (int)random(120,150);}
     if(i == 6){jjk = (int)random(150,180);}
     if(i == 7){if(j < 26*2) jjk = 6;else if(j < 39*2) jjk = 4; else if(j < 40*2) jjk = 7;else jjk = (int)random(180,200);}
     if(i == 8){if(j < 3*2) jjk = 9;else if(j < 4*2) jjk = 7; else jjk = (int)random(200,220);}
     
    newhuman(h,i,(int)random(cont[i].lx,cont[i].rx),(int)random(cont[i].ly,cont[i].ry),jjk,-1,1);
    //lang[jjk] ++;
    jkjk = jjk;
    
   }
     newhuman(h,i,(int)random(cont[i].lx,cont[i].rx),(int)random(cont[i].ly,cont[i].ry),jkjk,-1,1);
     h[maxh-1].SH = 1;
   }
   
   
  
}
int sum = 0;
void draw()
{
  sum += 100;
  if(sum % 100 == 0 && sum <= 5000)
  {
  background(255);
  for(int i = 0;i < maxh;i ++)
  {
    //print(h[i].con);
    h[i].draw(h);
  }
  //for(int ii = 1;ii < 11;ii ++)println(lang[ii]/2);
  for(int ii = 0;ii < 9;ii ++)if(cont[ii].br - cont[ii].dr > 0.05)cont[ii].br -= 0.02;
 // print("year:");
 // println(2018 + sum/50);
 // println("_____________________");
 // println(sumpopulation);
 fill(0);
 text(sum/100,50,SCREENY + 15);
 int maxx = 0;
 int popo = 0;
 for(int i = 20;i < 250;i ++){if(lang[i]/2 > maxx){maxx = lang[i];popo = i;}}
 println((double)maxx/4.0);
   //print(' ');//println(popo);
  }
  
}
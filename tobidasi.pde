
PFont myFont;    //フォント用変数
String titleA = "ばねを系に含めない場合";
String titleB = "ばねを系に含める場合";
float[] value = {0, 0, 0};
String[] s = {"運動E", "弾性力E", "力学的E"};
float barW;  //バーの横幅
float barH;
float t = 0;
boolean keiFlag = true;

int w = 1000;
int h = 600;

float springX;
int springH = 50;
float ballX;

int ballY = 100;
int ballr = 100;
int ballX0 = 500;
int springA = 200;
int giza = 10;
float gizaX;

void setup() {
  size(1000, 600);
  background(255);
  myFont = createFont("Osaka", 12);    //フォント作成
  textFont(myFont, 30);  //テキストのサイズを設定
  textAlign(CENTER);
}

void draw() {  
  
  background(255);
  fill(0);    //グレーで描画
  ellipse(ballX0, ballY + springH + 20, 10, 10); //X0point
  
  arrow(30, ballY + springH + 20, w - 100, ballY + springH + 20, 0, 0, 0);
  //ばねの描画
  springX  = ballX0 + springA * - 1 *  cos(t);
  if (t < PI / 2) {
    ballX = springX;} else {ballX  = ballX + 3;}
  
  gizaX = (springX / giza) / 4;
  for (int i = 1; i < giza + 1; i ++) {
    line(gizaX * 4 * (i - 1), ballY, gizaX * 4 * (i - 1) + gizaX, ballY + springH);
    line(gizaX * 4 * (i - 1) + gizaX, ballY + springH, gizaX * 4 * (i - 1) + 2 * gizaX, ballY);
    line(gizaX * 4 * (i - 1) + 2 * gizaX, ballY, gizaX * 4 * (i - 1) + 3 * gizaX, ballY - springH);
    line(gizaX * 4 * (i - 1) + 3 * gizaX, ballY - springH, gizaX * 4 * (i - 1) + 4 * gizaX, ballY);
  }
  fill(255, 0, 0);    //赤で描画
  ellipse(ballX + ballr / 2, ballY, ballr, ballr);//ボールの描画
  
  barW = 80;  //バーの横幅を40ピクセルにする
  barH = 200;
  
  //バーとテキストを描画
  for (int i = 0; i < value.length; i ++) {  //value.lenghは配列の要素数を返す
    if (t < PI / 2) {
      value[0] = barH * pow(sin(t), 2);
      if(keiFlag) {value[1]  = 0;}
      else{
        value[1] = barH * pow(cos(t), 2);}
      value[2] = round(value[1] + value[0]);
    }
    //バーのx座標, y座標を計算
    float x = barW * (1.5 * i) + 100;
    float y = height - value[i] - 100;
    
    fill(127);    //グレーで描画
    rect(x, y, barW, value[i]);
    
    //テキスト表示
    fill(255, 0, 0);    //赤で描画
    if (keiFlag && i ==  1) {fill(255);} //弾性Eを系から出す
    
    text(s[i], x + barW / 2, height - 50);
    //text(s[i] + " = " + nf(value[i] * 100/barH, 1 ,1), x + barW/2, height - 50);
  }
  arrow(w - 930,h - 80,w - 930,h - 350,0,0,0);
  line(w - 950,h - 100,w - 550,h - 100);
  if (keiFlag) {
    fill(0);    //黒で描画
    text(titleA, w - 300, height - 200);
  }
  else
  {  fill(0);    //黒で描画;
    text(titleB, w - 300, height - 100);}
  t = t + 0.01;
  if (t > 2 * PI) {t = 0;}
}

void mousePressed() {
  if (keiFlag) { 
    keiFlag = false;}
  else
  {keiFlag = true;} 
}


void arrow(int x1, int y1, int x2, int y2, int Color1, int Color2, int Color3)
{
  int arrowLength = 10;
  float arrowAngle = 0.5;
  float angle = atan2(y2 - y1, x2 - x1);
  stroke(Color1, Color2, Color3);
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  rotate(angle);
  line(0, 0, -arrowLength * cos(arrowAngle), arrowLength * sin(arrowAngle));
  line(0, 0, -arrowLength * cos(arrowAngle), -arrowLength * sin(arrowAngle));
  popMatrix();
}

int[] pigment ;//可以用的八种色彩
float x = 0 ;//笔刷动效所用到变量的初始值
float[] loc = new float[5] ;//标签的竖直位置
int drawcolor ;//画笔颜色
float mx = 0 , my = 0 ;//储存上一个随机铅笔
float[] a = new float[20] ;//刷子笔刷的毛
int type ;//当前笔刷





void setup() {
  size(1280,720) ;
  background(15,25,60) ;
  
  fill(240) ;/*画布没有那么白*/
  rect(width/8+45 , height/4+60 , width/8*7-75 , height/4*3-60) ;//画布
  
  colorElement() ;//提取颜色信息
  for (int i = 0 ; i < 20 ; i++) {
    a[i] = 255 ;
  }
}





void draw() {
  homePage() ;//主页基本结构
  colorPlate();//颜色选取按钮
  patternNote();//画笔标签
  type() ;
  
  if (mousePressed) {
    if (type == 0) {
      pencil() ;
    }
    if (type == 1) {
      ink() ;
    }
    if (type == 2) {
      brush() ;
    }
    if (type == 3) {
      pastel() ;
    }
    if (type == 4) {
      mark() ;
    }
  }
  
  help() ;
  
  savepng() ;
}





void homePage() {
  fill(140,125,175) ;
  noStroke() ;
  rect(0 , height/3 , width/8 , height/4*3) ;
  ellipse(width/8 , height/3+15 , 30 , 30) ;
  rect(0 , height/3+15 , width/8+15 , height/4*3) ;//笔刷区
  
  rect(width/8+60 , 30 , width/8*6-90 , height/4) ;
  ellipse(width/8+60 , 45 , 30 , 30) ;
  ellipse(width/8+60 , 15+height/4 , 30 , 30) ;
  ellipse(width/8*7-30 , 45 , 30 , 30) ;
  ellipse(width/8*7-30 , 15+height/4 , 30 , 30) ;
  rect(width/8+45 , 45 , width/8*6-60 , height/4-30) ;//调色盘
  
  ellipse(width-60 , 60 , 60 , 60) ;
  fill(255) ;
  textAlign(CENTER,CENTER) ;
  textSize(48) ;
  text('?' , width-59 , 55) ;//指南按钮
  
  PImage screenCut ;
  fill(140,125,175) ;
  ellipse(width-60 , 135 , 60 , 60) ;
  screenCut = loadImage("save.png") ;
  imageMode(CENTER) ;
  image(screenCut , width-60 , 132 , 34 , 35) ;//导出按钮
}





void colorElement() {
  PImage palette ;
  palette = loadImage("palette.png") ;
  pigment = new int[8] ;
  palette.loadPixels() ;
  for (int i = 0 ; i < 8 ; i++) {
    pigment[i] = palette.pixels[i] ;
  }
  /*
  fill(pigment[]) ;
  ellipse(width/2,height/2,100,100) ;
  测试用
  0为白色，1为浅红，2为浅绿，3为浅蓝，4为黑色，5为深红，6为深绿，7为深蓝
  */
}




void colorPlate() {
    float[] loc ;
    loc = new float[8] ;
  for (int i = 0 ; i < 8 ; i++) {
    loc[i] = map(i , 0 , 7 , width/8+120 , width/8*7-90) ;
    fill(pigment[i]) ;
    strokeWeight(6) ;
    stroke(240) ;
    ellipse(loc[i] , 30+height/8 , 80 , 80) ;
    if (dist(mouseX , mouseY , loc[i] , 30+height/8) <= 40) {
      noStroke() ;
      ellipse( loc[i] , 30+height/8 , 84 , 84) ;
      if (mousePressed) {
        drawcolor = get(mouseX,mouseY) ;
        /*println(drawcolor) ;//测试用*/
      }
    }
  }
}





void patternNote() {
  PShape note ;//建立标签图形
  note = createShape() ;
  note.beginShape() ;
  note.fill(15,25,60) ;
  note.noStroke() ;
  note.vertex(0 , 0) ;
  note.vertex(120 , 0) ;
  note.vertex(135 , 30) ;
  note.vertex(120 , 60) ;
  note.vertex(0 , 60) ;
  note.endShape(CLOSE) ;
  
  PImage[] pattern ;//提取标签上的图示
  pattern = new PImage[5] ;
  pattern[0] = loadImage("pencil.png") ;
  pattern[1] = loadImage("ink.png") ;
  pattern[2] = loadImage("brush.png") ;
  pattern[3] = loadImage("pastel.png") ;
  pattern[4] = loadImage("mark.png") ;

  for (int i = 0 ; i < 5 ; i++) {//绘制收缩时的标签
    loc[i] = map(i , 0 , 4 , height/3+30 , height-90) ;
    shape(note , -120 , loc[i]) ;
    }
        
    float targetX = 120 ;//标签动效
    float speed = 0.3 ;
    String[] patternName ;
    patternName = loadStrings("note.txt") ;
    PFont myFont = createFont("微软雅黑" , 24) ;
    textFont(myFont) ;
    fill(255) ;
    imageMode(CENTER) ;
    if ((mouseX < 135) && (mouseY > loc[0]) && (mouseY < loc[0]+60)) {
      x = x + (targetX - x) * speed ;
      shape(note , -120 + x , loc[0]) ;
      image(pattern[0] , -80 + x , loc[0]+30 , 50 , 50) ;
      text(patternName[0] , -25 + x , loc[0]+25) ;
    }
    else if ((mouseX < 135) && (mouseY > loc[1]) && (mouseY < loc[1]+60)) {
      x = x + (targetX - x) * speed ;
      shape(note , -120 + x , loc[1]) ;
      image(pattern[1] , -80 + x , loc[1]+30 , 50 , 50) ;
      text(patternName[1] , -25 + x , loc[1]+25) ;
    }
    else if ((mouseX < 135) && (mouseY > loc[2]) && (mouseY < loc[2]+60)) {
      x = x + (targetX - x) * speed ;
      shape(note , -120 + x , loc[2]) ;
      image(pattern[2] , -80 + x , loc[2]+30 , 50 , 50) ;
      text(patternName[2] , -25 + x , loc[2]+25) ;
    }
    else if ((mouseX < 135) && (mouseY > loc[3]) && (mouseY < loc[3]+60)) {
      x = x + (targetX - x) * speed ;
      shape(note , -120 + x , loc[3]) ;
      image(pattern[3] , -80 + x , loc[3]+30 , 50 , 50) ;
      text(patternName[3] , -25 + x , loc[3]+25) ;
    }
    else if ((mouseX < 135) && (mouseY > loc[4]) && (mouseY < loc[4]+60)) {
      x = x + (targetX - x) * speed ;
      shape(note , -120 + x , loc[4]) ;
      image(pattern[4] , -80 + x , loc[4]+30 , 50 , 50) ;
      text(patternName[4] , -25 + x , loc[4]+25) ;
    }
    else {
      x = 0 ;
    }
}





void pencil() {
  float pmx , pmy ;
  pmx = mx ;
  pmy = my ;
  mx = random(mouseX-30 , mouseX+30) ;
  my = random(mouseY-30 , mouseY+30) ;
  pmx = constrain(pmx , width/8+45 , width-30) ;
  pmy = constrain(pmy , height/4+60 , height) ;
  mx = constrain(mx , width/8+45 , width-30) ;
  my = constrain(my , height/4+60 , height) ;
  stroke(drawcolor,200) ;
  strokeWeight(1) ;
  line(pmx,pmy,mx,my) ;
}





void ink() {
  float target = dist(mouseX, mouseY, pmouseX, pmouseY);
  float v = 0 ;
  float easing = 0.01 ;
  v = v + (target - v) * easing ;
  fill(drawcolor) ;
  noStroke() ;
  mx = mouseX ;
  my = mouseY ;
  mx = constrain(mx , width/8+45 , width-30) ;
  my = constrain(my , height/4+60 , height) ;
  ellipse(mx , my , 0.5/v , 0.5/v) ;
}





void brush() {
  float pmx , pmy ;
  strokeWeight(2) ;
  for (int i = 0 ; i < 20 ; i++) {
    a[i] = a[i]-random(10) ;
    stroke(drawcolor,a[i]) ;
    mx = mouseX+i ;
    my = mouseY+i ;
    pmx = pmouseX+i ;
    pmy = pmouseY+i ;
    mx = constrain(mx , width/8+45 , width-30) ;
    my = constrain(my , height/4+60 , height) ;
    pmx = constrain(pmx , width/8+45 , width-30) ;
    pmy = constrain(pmy , height/4+60 , height) ;
    line(mx , my , pmx , pmy) ;
  }
}





void pastel() {
  stroke(drawcolor) ;
  strokeWeight(1.5) ;
  mx = mouseX+10*randomGaussian() ;
  my = mouseY+10*randomGaussian() ;
  mx = constrain(mx , width/8+55 , width-40) ;
  my = constrain(my , height/4+70 , height) ;
  point(mx , my) ;
}





void mark() {
  float pmx , pmy ;
  strokeCap(SQUARE) ;
  stroke(drawcolor,50) ;
  strokeWeight(20) ;
  mx = mouseX ;
  my = mouseY ;
  pmx = pmouseX ;
  pmy = pmouseY ;
  mx = constrain(mx , width/8+45 , width-30) ;
  my = constrain(my , height/4+60 , height) ;
  pmx = constrain(pmx , width/8+45 , width-30) ;
  pmy = constrain(pmy , height/4+60 , height) ;
  line(mouseX,mouseY,pmouseX,pmouseY) ;
}





void type() {
  for (int i = 0 ; i < 5 ; i++)
    if ((mouseX < 135) && (mouseY > loc[i]) && (mouseY < loc[i]+60)) {
      if (mousePressed) {
        type = i ;
        /*println(type) ;//测试用*/
      }
    }
}





void help() {
  if (dist(mouseX , mouseY , width-60 , 60) <= 30) {
    fill(15,25,60,200) ;
    noStroke() ;
    rect(0,0,width,height) ;
    fill(240) ;
    rect(width/8+45 , height/4+60 , width/8*7-75 , height/4*3-60) ;
    String[] manual ;
    manual = loadStrings("help.txt") ;
    PFont myFont = createFont("微软雅黑" , 16) ;
    textFont(myFont) ;
    textAlign(CORNER,CORNER) ;
    fill(255) ;
    for (int i = 0 ; i < manual.length ; i++) {
      text(manual[i] , width/6+15 , 18*i+60) ;
    }
  }
}





void savepng() {
  if ((dist(mouseX , mouseY , width-60 , 135) <= 30) && mousePressed) {
    save("picture"+".jpg") ;
    delay(500) ;
  }
}

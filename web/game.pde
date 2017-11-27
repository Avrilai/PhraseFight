var castle1;
var castle2;
var healthBar1;
var healthBar2;
var manna1;
var manna2;
var x = false;
PFont fontArial;

ArrayList p1Units;
ArrayList p2Units;

void setup(){
    size(1300,450);
    background(65,195,235);
    castle1 = new Castle(100,200);
    castle2 = new Castle(1000,200);
    healthBar1 = new HealthBar(100, 300);
    healthBar2 = new HealthBar(1000, 300);
    //spell1 = new Spell(100, 250, 1);
    manna1 = new Manna(100,350);
    manna2 = new Manna(1000, 350);
    fontArial = loadFont("arial");
    p1Units = new ArrayList();
    p2Units = new ArrayList();
}

void draw(){
    background(65,195,235);
    castle1.drawCastle();
    castle2.drawCastle();
    healthBar1.drawBar();
    healthBar1.updateHealth();
    healthBar2.drawBar();
    healthBar2.updateHealth();

    manna1.drawBar();
    manna1.updateManna();
    manna2.drawBar();
    manna2.updateManna();
    if(keyPressed){
        spell1.check();
        if(key == CODED){
            if(keyCode == ALT){
                if(y == true){
                    document.getElementById("mycanvas").blur();
                    document.getElementById("input").focus();
                    y = false;
                }
                else{
                    document.getElementById("input").blur();
                    document.getElementById("mycanvas").focus();
                    y = true;
                }
            }
        }
    }
    if(x == true){
        spell1.drawSpell();
        spell1.moveSpell();
    }
    for (int i = 0; i < p1Units.size(); i++) {
        ((Animation)p1Units.get(i)).display();
    }
    for (int i = 0; i < p2Units.size(); i++) {
        ((Animation)p2Units.get(i)).display();
    }

    for (int i = 0; i < p1Units.size(); i++) {
        Animation one = ((Animation)p1Units.get(i));
        for (int j = 0; j < p2Units.size(); j++) {
            Animation two = ((Animation)p2Units.get(j));
            if (abs(1000 - ((int)one.x + (int)two.x)) < 10) {
                one.speedX = 0;
                two.speedX = 0;
            } else {
                one.speedX = one.initSpeedX;
                two.speedX = two.initSpeedX;

            }
        }
    }

    for (int i = 0; i < p1Units.size(); i++) {
        Animation one = ((Animation)p1Units.get(i));
        text(p1Units.get(i).getHealth()
        if(abs(1000 - ((int)one.x + 100) < 10)){
            one.speedX = 0;
        }
    }
    for (int j = 0; j < p2Units.size(); j++) {
        Animation two = ((Animation)p2Units.get(j));
        if(abs(1000 - ((int)two.x + 100) < 10)){
            two.speedX = 0;
        }
    }

}
class HealthBar{
    var xPos;
    var yPos;
    var life;
    HealthBar(x, y){
        xPos = x;
        yPos = y;
        life = 180;
    }
    void drawBar(){
        noStroke();
        fill(0);
        rect(xPos, yPos, 200, 40)
        fill(255, 0, 0);
        rect(xPos + 10, yPos + 10, life , 20);
        textSize(15);
        text((int)life, xPos + 208, yPos + 25);
    }
    void updateHealth(){
        //if(mousePressed && life >= 0){
        //    life -= 5;
        //}
        if(life <= 0){
            life = 0;
        }
    }
}
class Manna{
    var xPos;
    var yPos;
    var manna;
    var name = "";

    Manna(x, y){
        xPos = x;
        yPos = y;
        manna = 0;
    }
    void drawBar(){
        noStroke();
        fill(0);
        rect(xPos, yPos, 200, 40)
        fill(0, 60, 255);
        rect(xPos + 10, yPos + 10, manna , 20);
        textSize(15);
        fill(0);
        text(name, xPos, yPos + 70);
        text(manna, xPos + 208, yPos + 25);
    }
    void updateManna(){
        //if(mousePressed && manna <= 180){
        //    manna += 5;
        //}
        if(manna >= 180){
            manna = 180;
        }
    }

    void setName(_name) {
        name = _name;
    }
}
class Castle {
    var xPos;
    var yPos;
    var spells = [];

    Castle(x, y){
        xPos = x;
        yPos = y;
    }
    void drawCastle(){
        noStroke();
        fill(255, 255, 255);
        rect(xPos, yPos - 100, 200, 200);
        rect(xPos, yPos - 150, 40, 150);
        rect(xPos + 80, yPos - 150, 40, 150);
        rect(xPos + 160, yPos - 150, 40, 150);
    }
}
class Spell{
    var xPos;
    var yPos;
    var type;
    var r;
    var g;
    var b;
    var move;
    Spell(x, y, t){
        xPos = x;
        yPos = y;
        type =  t;
        move = 0;
        if(t == 1){
            r = 155;
            g = 81;
            b = 229;
        }
        else if(t == 2){
            r = 235;
            g = 34;
            b = 34;
        }
        else{
            r = 0;
            g = 0;
            b = 0;
        }
    }
    void moveSpell(){
        //var x = event.keyCode;
        if(x == true && xPos + move <= 850){
            move += 10;
        }
        else{
            x = false;
            move = 0;
        }
    }
    void drawSpell(){
        if(x == true && xPos + move <= 850){
            noStroke();
            fill(r, g, b);
            ellipse(xPos + move + 200, yPos, 50, 50);
        }
    }
    void check(){
        //if(key == 'a'){
        //    x = true;
        //}
    }
}

class Animation {
    PImage[] images;
    var imageCount;
    var frame = 0;
    var x;
    var y;
    var speedX;
    var initSpeedX;
    var uuid;
    var offset;
    Animation(String imagePrefix, var count, var _x, var _y, var _speedX, var _uuid, var _offset) {
        x = _x;
        y = _y;
        speedX = _speedX;
        initSpeedX = speedX;
        imageCount = count;
        images = new PImage[imageCount];
        uuid = _uuid;
        offset = _offset;
        for (var i = 0; i < imageCount; i++) {
            String filename = imagePrefix + i + ".gif";
            images[i] = loadImage(filename);
        }
    }
    void display() {
         x += speedX;
         speedX = initSpeedX;
         clamp(x, 100, 1100);
         frame = (frame + .1) % imageCount;
         if (offset) {
            image(images[(int)frame], 1100 - x, y);
         } else {
            image(images[(int)frame], x, y);
         }
    }
}


void addMana(player, mana) {
    if (player == 1) {
        manna1.manna += mana;
    } else {
        manna2.manna += mana;
    }
}

void setName(player, name) {
    if (player == 1) {
        manna1.name = name;
    } else {
        manna2.name = name;
    }
}

void buyUnit(player, unitId, unitSpeed, uuid) {
    if (player == 1) {
        Animation an = new Animation("knight", 5, 100, 150, unitSpeed, uuid, false);
        p1Units.add(an);
    } else {
        Animation an = new Animation("knightflip", 5, 100, 150, unitSpeed, uuid, true);
        p2Units.add(an);
    }
}

void buySpell(player) {

}

void updateHealth(player, val) {
    if (player == 1) {
        healthbar1 = val;
    } else {
        healthbar2 = val;
    }
}

var clamp(var val, var left, var right) {
  if (val < left) {
    val = left;
  }
  if (val > right) {
    val = right;
  }
  return val;
}

void removeUnit(player, id) {
    for(int k = 0; k < 3; k++) {
        if (player == 1) {
            for(int i = p1Units.size() - 1; i >= 0; i--) {
                if(p1Units.get(i).uuid == id) {
                    p1Units.remove(i);
                }
            }
        } else {
            for(int i = p2Units.size() - 1; i >= 0; i--) {
                if(p2Units.get(i).uuid == id) {
                    p2Units.remove(i);
                }
            }
        }
    }
}

void setCastleHealth(player, val) {
    if (player == 1) {
        healthBar1.life = val;
    } else {
        healthBar2.life = val;
    }
}

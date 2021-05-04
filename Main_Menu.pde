//main menu window with all its objects

PImage left_arrow;
PImage right_arrow;

float timeInterval_Main_Menu;
float timePast_Main_Menu;
int textAlpha_Main_Menu = 100;
int textFade_Main_Menu = 2;

void setupMainMenu(){
  timePast_Main_Menu = millis();
  timeInterval_Main_Menu = 1000.0f;
  left_arrow=loadImage("data/left_arrow.png");
  right_arrow=loadImage("data/right_arrow.png");
  image(loadImage("data/right_arrow.png"),450,200);
}
void drawMainMenu(){
  left_arrow();
  right_arrow();
  
  draw_p();
  
  draw_c();
  
  press_any_key_to_play();
}

// draw left arrow
void left_arrow(){
  image(left_arrow,100,200);
  textSize(25);
  fill(255);
  text("move left", 180, 320);
}

//draw right arrow
void right_arrow(){
  image(right_arrow,450,200);
  textSize(23);
  fill(255);
  text("move right", 451, 319);
}

//draw letter P
void draw_p(){
  fill(209);
  textSize(150);
  text("P",120,130);
  
  fill(255);
  textSize(32);
  text("pause",150,122);
}

// draw letter c
void draw_c(){
  fill(209);
  textSize(150);
  text("C",450,130);
  
  fill(255);
  textSize(32);
  text("continue",500,90);
}

// prints the string "press_any_key_to_play"
void press_any_key_to_play(){
  if(millis() > timeInterval_Main_Menu + timePast_Main_Menu){
    timePast_Main_Menu = millis();
    textFade_Main_Menu *= -1;
  }
  textAlpha_Main_Menu += textFade_Main_Menu;
  fill(textAlpha_Main_Menu);
  text("press any key to play",210,500);
}

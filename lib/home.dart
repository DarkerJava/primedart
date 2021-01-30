import 'package:bird/screens/login/login.dart';
import 'package:bird/startButton.dart';
import 'package:bird/lost-view.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'homeView.dart';
import 'lost.dart';
import 'routes.dart';
import 'package:vibration/vibration.dart';
import 'home.dart';
import 'dart:io';
import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_box_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/effects/effects.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/palette.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'app_drawer.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import "package:normal/normal.dart";
import "package:flame/time.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'app_drawer.dart';

Color COLOR = const Color.fromRGBO(0,0,0, 0.5);
Color COLOR2 = const Color.fromRGBO(215, 44, 32, 1);
const COLOR3 = const Color.fromRGBO(255, 204, 0, 1);
const COLOR4 = const Color.fromRGBO(0,0,0, 0.3);


var colours = [
  Color.fromRGBO(210, 0, 0, 1),
  Color.fromRGBO(0, 51, 204, 1),
  Color.fromRGBO(0, 153, 51, 1),
  Color.fromRGBO(148,0,211, 1),
  Color.fromRGBO(215, 123, 31, 1)
 ];

const SIZE = 52.0;
const GRAVITY = 200.0;
const BOOST = -150;
var score = 0;
bool updateScore = false;
bool stopAttempts = false;
bool start = false;
int highScore = 0;
int changedMultiple = -1;
MyGame game;
double tempHeight = 0;
bool updateLives  =false;
bool hasLives = true;
double statusWidth = 200;
bool style = false;
bool masterGameStart = true;
bool newDeck = true;
bool spinNew = false;
bool debug = false;
bool globalShrink = false;
bool visible = false;
bool updateMenu = false;
bool hideMenu = false;
BuildContext contexts;
var x;
var y;

//Building APK --> flutter build apk --split-per-abi
double height = AppBar().preferredSize.height;
var count = new List(4);

class Home extends StatelessWidget {
  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    contexts = context;
    SystemChrome.setEnabledSystemUIOverlays([]);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return
      //Scaffold(
       // drawer: AppDrawer(),
   // body:
      Stack(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/603788db98e51342825c0d36649dbe12.jpg"),
                      fit: BoxFit.cover)
              ),
              child: game.widget,
            ),

          ]);;//);
    }
  }


double tempX = 0;
double heightPos = 0;
int lives = 3;
var table = List.generate(10, (i) => List(7), growable: false);
var ctable = List.generate(10, (i) => List(7), growable: false);
var dtable = List.generate(10, (i) => List(7), growable: false);
double stopInc =0;




class Multiple extends TextComponent with Tapable{

  Rect pauseRect1;
  TapDownDetails m;
  double height = AppBar().preferredSize.height;
  void onTapDown(TapDownDetails details) {

    m= details;
  }
  static final Paint _paint = Paint()
    ..color = COLOR;
  bool collectedItem = false;
  double speedX = 100.0;
  double posX, posY;
  bool collectPrime = false;
  double accel = 1;
  int value1 = 0;
  bool returned = false;
  double column;
  double row;

  bool rand = false;
  bool fall = true;
  bool shrink = false;
  bool shrinkCollect = false;
  double sizeF = 25.0.sp;
  int genColourComp;
  Paint _paint12;
  int counter = 0;
  Multiple(String text, TextConfig textConfig, double Column, double Row, double top) : super(text) {
    pauseRect1 = Rect.fromLTWH(0,0,0,0);
    this.config = textConfig;
    this.anchor = Anchor.center;
    this.x = (tempWidth/7)*Column;
    this.y = 0;
    column = Column;
    row = Row;

    var rng1 = new Random();
    genColourComp = rng1.nextInt(5);
    _paint12 = Paint()
      ..color = colours[genColourComp];
    ctable[row.toInt()][(column-1).toInt()] = genColourComp+1;
  }
  @override
  bool destroy() {
    return returned;
  }
bool bottomFall = false;
  @override
  void update(double tt){


    if (fall && !shrink){

      ctable[row.toInt()][(column-1).toInt()] = 0;
      if ((this.y + 10) >= positionArray[row.toInt()]){
          fall = false;
          ctable[row.toInt()][(column-1).toInt()] = genColourComp+1;
          table[(row).toInt()][(column-1).toInt()] = true;
          accel = 1;
          this.y =  positionArray[row.toInt()];
        }
      else {
        this.y += 10;
        ctable[row.toInt()][(column-1).toInt()] = 0;
      }}



    if (row != 9 && !fall){
      if (table[(row+1).toInt()][(column-1).toInt()] == false){
        table[(row).toInt()][(column-1).toInt()] = false;
        table[(row+1).toInt()][(column-1).toInt()] = true;
        ctable[(row).toInt()][(column-1).toInt()] = 0;
        rand = true;
        row++;

      }
    }

    if (dtable[(row).toInt()][(column-1).toInt()] == true && !fall && !newDeck) {
      HapticFeedback.lightImpact();
      dtable[row.toInt()][(column-1).toInt()] = false;

      this.config = TextConfig(color: Colors.blueGrey, fontSize: 25.0.sp, fontFamily: "fontNum");
      text = '+2';
      _paint12 = Paint()
        ..color = Color.fromRGBO(255,215,0, 1);

      collectPrime = true;
      shrinkCollect = true;
    }

    if (rand == true){
      if ((this.y+5) <=  positionArray[(row).toInt()]){
        this.y += 5;
        ctable[(row).toInt()][(column-1).toInt()] = 0;
        accel++;
      }
      else {
        rand = false;
        accel = 1;
        this.y =  positionArray[row.toInt()];
        ctable[(row).toInt()][(column-1).toInt()] = genColourComp+1;
        table[(row).toInt()][(column-1).toInt()] = true;
      }
    }

    if (shrink){

      if (sizeF < 0){
        destroy();
        shrink = false;
        returned = true;
        table[(row).toInt()][(column-1).toInt()] = false;
        ctable[row.toInt()][(column-1).toInt()] = 0;


      }

      else{
        TextConfig comp = TextConfig(color: Colors.white, fontSize: sizeF, fontFamily: "fontNum");
        this.config =comp;
        sizeF -= 2.5;
        ctable[row.toInt()][(column-1).toInt()] = 0;
      }

    }

    if (shrinkCollect){
      counter ++;
      if (counter < 40){
        globalShrink = true;
      } else {
        globalShrink = false;
      }

      if (sizeF < 0){
        globalShrink = false;
        destroy();
        shrinkCollect = false;
        returned = true;
        table[(row).toInt()][(column-1).toInt()] = false;
        ctable[row.toInt()][(column-1).toInt()] = 0;


      }

      else{
        if (counter > 40) {

          TextConfig comp = TextConfig(
              color: Colors.black, fontSize: sizeF, fontFamily: "fontNum");
          this.config = comp;
          sizeF -= 2.5;
          ctable[row.toInt()][(column - 1).toInt()] = 0;
        }
      }


    }

    if (m != null && !shrink && !globalShrink){
      if (pauseRect1.contains(m.globalPosition)){



        shrink = true;
        collectPrime = true;

      }}

    if (collectPrime){
      score ++;

      updateScore = true;
      collectPrime = false;
    }
    if (paused){
      this.x = -20000;
    }
    double dist = 50;
    pauseRect1 = Rect.fromLTWH((tempWidth/7)*column-(tempWidth/15),(this.y-5)-(this.height/2),(tempWidth/15)*2,this.height+10);


    //if (this.x <-30 || this.y<0){
     // returned = true;
     // destroy();

    //}


    super.update(tt);

    if (changedMultiple == 1){

     destroy();
     returned = true;
     game.add(new FastMultiple(this.text, this.x, this.y));

    }




  }

  @override
  void render(Canvas c) {

    c.drawRRect(RRect.fromRectAndRadius((pauseRect1),Radius.circular(8.0)),_paint12);
    super.render(c);

  }
}


class NotMultiple extends TextComponent  with Tapable{

  Rect pauseRect1;
  TapDownDetails m;
  double height = AppBar().preferredSize.height;
  void onTapDown(TapDownDetails details) {

    m= details;
  }
  static final Paint _paint = Paint()
    ..color = COLOR;
  bool collectedItem = false;
  double speedX = 100.0;
  double posX, posY;
  bool collectNot = false;
  double accel = 1;
  int value1 = 0;
  int inc = 0;
  bool returned = false;
  double column;
  double row;
  bool topV;
  bool shrink = false;
  bool rand = false;
  bool fall = true;
  Paint _paint12;
  bool collectPrime = false;
  double sizeF = 25.0.sp;
  int genColourComp;
  int counter = 0;
  bool shrinkCollect = false;
  NotMultiple(String text, TextConfig textConfig, double Column, double Row, double top) : super(text) {
    pauseRect1 = Rect.fromLTWH(0,0,0,0);
    this.config = textConfig;
    this.anchor = Anchor.center;
    this.x = (tempWidth/7)*Column;
    this.y = 0;
    column = Column;
    row = Row;

    var rng2 = new Random();
    genColourComp = rng2.nextInt(5);
    _paint12 = Paint()
      ..color = colours[genColourComp];
    ctable[row.toInt()][(column-1).toInt()] = genColourComp+1;
  }
  @override
  bool destroy() {
    return returned;
  }
  bool bottomFall = false;
  @override
  void update(double tt){

    if (fall && !shrink){

      ctable[row.toInt()][(column-1).toInt()] = 0;
      if ((this.y + 10) >= positionArray[row.toInt()]){
        fall = false;
        ctable[row.toInt()][(column-1).toInt()] = genColourComp+1;
        table[(row).toInt()][(column-1).toInt()] = true;
        accel = 1;
        this.y =  positionArray[row.toInt()];
      }
      else {
        this.y += 10;
        ctable[row.toInt()][(column-1).toInt()] = 0;
      }}




    if (row != 9 && !fall){
      if (table[(row+1).toInt()][(column-1).toInt()] == false){
        table[(row).toInt()][(column-1).toInt()] = false;
        table[(row+1).toInt()][(column-1).toInt()] = true;
        ctable[(row+1).toInt()][(column-1).toInt()] = 0;
        rand = true;
        row++;

      }
    }

    if (dtable[(row).toInt()][(column-1).toInt()] == true && !fall && !newDeck) {

      this.config = TextConfig(color: Colors.blueGrey, fontSize: 25.0.sp, fontFamily: "fontNum");
      text = '+2';
      dtable[row.toInt()][(column-1).toInt()] = false;
       _paint12 = Paint()
         ..color = Color.fromRGBO(255,215,0, 1);
      collectPrime = true;
      shrinkCollect = true;
    }

    if (rand == true){
      if ((this.y+5) <=  positionArray[(row).toInt()]){
        this.y += 5;
        ctable[(row).toInt()][(column-1).toInt()] = 0;
        accel++;
      }
      else {
        rand = false;
        accel = 1;
        this.y =  positionArray[row.toInt()];
        ctable[(row).toInt()][(column-1).toInt()] = genColourComp+1;
        table[(row).toInt()][(column-1).toInt()] = true;
      }
    }

    if (shrink){
      if (sizeF < 0){

        destroy();
        shrink = false;
        returned = true;
        table[(row).toInt()][(column-1).toInt()] = false;
        ctable[row.toInt()][(column-1).toInt()] = 0;


      }

      else{
        TextConfig comp = TextConfig(color: Colors.white, fontSize: sizeF, fontFamily: "fontNum");

        this.config =comp;
        sizeF -= 2.5;
        ctable[row.toInt()][(column-1).toInt()] = 0;
      }

    }

    if (shrinkCollect){
      counter ++;

      if (counter < 40){
        globalShrink = true;
      } else {
        globalShrink = false;
      }

      if (sizeF < 0){
        globalShrink = false;
        destroy();
        shrinkCollect = false;
        returned = true;
        table[(row).toInt()][(column-1).toInt()] = false;
        ctable[row.toInt()][(column-1).toInt()] = 0;


      }

      else{
        if (counter > 40) {

          TextConfig comp = TextConfig(
              color: Colors.black, fontSize: sizeF, fontFamily: "fontNum");
          this.config = comp;
          sizeF -= 2.5;
          ctable[row.toInt()][(column - 1).toInt()] = 0;
        }
      }

    }

    if (m != null && !collectNot && !globalShrink){
      if (pauseRect1.contains(m.globalPosition)){

        _paint12 = Paint()
          ..color = Color.fromRGBO(80, 80, 80, 0.9);
        inc++;
        this.config = TextConfig(color: Colors.grey, fontSize: 25.0.sp, fontFamily: "fontNum");
        ctable[row.toInt()][(column-1).toInt()] = 0;

        text = 'X';

      }}
    if (inc == 1){
      if (score>0) {
        score --;

      }
      updateScore = true;

    }
    if (paused){
      this.x = -20000;
    }
    double dist = 50;
    pauseRect1 = Rect.fromLTWH((tempWidth/7)*column-(tempWidth/15),(this.y-5)-(this.height/2),(tempWidth/15)*2,this.height+10);

    if (collectPrime){
      score ++;

      updateScore = true;
      collectPrime = false;
    }
    //if (this.x <-30 || this.y<0){
    // returned = true;
    // destroy();

    //}
    super.update(tt);

    if (changedMultiple == 1){

      destroy();
      returned = true;
      game.add(new FastMultiple(this.text, this.x, this.y));

    }




  }

  @override
  void render(Canvas c) {

    c.drawRRect(RRect.fromRectAndRadius((pauseRect1),Radius.circular(8.0)),_paint12);
    super.render(c);

  }}


double updateStatus = 0;
class FastMultiple extends TextComponent{
  double height = AppBar().preferredSize.height;

  bool collectedItem = false;
  double speedX = 150.0;
  double posX, posY;
  bool collectPrime = false;
  double accel = 0;
  int value1 = 0;
  bool returned = false;
  TextConfig notValid = TextConfig(color: Colors.grey, fontSize: 35, fontFamily: "fontNum");
  FastMultiple(String text, double posX, double posY) : super(text) {
   this.config = notValid;
    this.anchor = Anchor.center;
    this.x = posX;
    this.y = posY;


  }
  @override
  bool destroy() {
    return returned;
  }
  @override
  void update(double tt){
    if (paused){
      this.x = -20000;
    }

    if (this.x <-50 ){
      returned = true;
      destroy();
    }
    accel++;
    super.update(tt);
    this.x -= 2*accel;

  }
}





class EndMenu extends TextComponent with Tapable {
  double height = AppBar().preferredSize.height;

  bool collectedItem = false;
  double speedX = 150.0;

  bool collectPrime = false;
  double accel = 0;
  int value1 = 0;
  bool returned = false;
  Paint _paint12 = Paint()
    ..color = Colors.yellow;
  TextConfig notValid = TextConfig(color: Colors.grey, fontSize: 35, fontFamily: "fontNum");
  TapDownDetails m;
  Rect startRect = Rect.fromLTWH(0, 0, 100, 100);
  void onTapDown(TapDownDetails details) {

    m = details;
  }
  EndMenu  (String text) : super(text) {
    //masterGameStart = true;
    this.config = notValid;
    this.anchor = Anchor.center;
    this.x = 50;
    this.y = 50;


  }
  @override
  bool destroy() {
    return returned;
  }
  @override
  void update(double tt){
    if (m != null){
      if (startRect.contains(m.globalPosition)){
        _paint12 = Paint()
          ..color = Colors.blue;
        updateScore = true;
        print("touched");
        newDeck = true;
        masterGameStart = true;
        stopInc == 0;
        stopAttempts = false;
        returned = true;
        destroy();
      }}

    super.update(tt);


  }
  @override
  void render(Canvas c) {

    c.drawRRect(RRect.fromRectAndRadius((startRect),Radius.circular(8.0)),_paint12);

    super.render(c);

  }
}
double tempWidth = 0;
String message;
bool specialMessage = false;
bool eliminateScoreFlash = false;
bool spikeDeath = false;
bool frozen = true;

bool paused = false;
double heightApp = AppBar().preferredSize.height;

int tempUpdate = 0;
double statusBox = 0;
int currentMultiple = 2;
var positionArray = new List(10);
class MyGame extends BaseGame  with HasTapableComponents{



  double timerPrime = 0;
  double timerComp = 0;

  Multiple multiple;

  EndMenu endMenu;
  NotMultiple notMultiple;
  var multiples = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  var subtrators = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];


  var counter = 0;
  TextPainter textPainterScore;
  TextPainter textPainterLives;
  TextPainter textPainterScoreText;
  TextPainter textPainterLivesText;
  TextPainter textPainterNoMoreLives;

  TextPainter textPainterNumType;
  Offset positionScore;
  Offset positionLives;
  Offset positionScoreText;
  Offset positionLivesText;
  Offset positionNoMoreLives;
  Offset positionNumType;

  @override
  Color backgroundColor() => const Color.fromRGBO(	0, 0,0, 0.5);
  var count1 = new List(4);

  var count2 = new List(6);

  double previousPos = 0.0;
  var yPositions = new List(8);


  MyGame(Size size) {


    for (int a = 0; a < 9; a++) {
      for (int b = 0; b < 6; b++) {
        table[a][b] = false;
        ctable[a][b] = 0;
        dtable[a][b] = false;
      }
    }

    positionArray[0] = 3 * (tempHeight / 14);
    positionArray[1] = 4 * (tempHeight / 14);
    positionArray[2] = 5 * (tempHeight / 14);
    positionArray[3] = 6 * (tempHeight / 14);
    positionArray[4] = 7 * (tempHeight / 14);
    positionArray[5] = 8 * (tempHeight / 14);
    positionArray[6] = 9 * (tempHeight / 14);
    positionArray[7] = 10 * (tempHeight / 14);
    positionArray[8] = 11 * (tempHeight / 14);
    positionArray[9] = 12 * (tempHeight / 14);



    add(Bg());
    statusBox = 360;
    updateStatus = tempWidth*0.14/2000;

    for (int i = 0; i < 3; i++) {
      yPositions[i] = ((tempWidth) / 3) * (i + 1);
    }

    textPainterNoMoreLives = TextPainter(text: TextSpan(
        text: "" ,
        style: TextStyle(
            color: Color(0xFFFF0000), fontSize: 32)),
        textDirection: TextDirection.ltr);
    textPainterNoMoreLives.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    positionNoMoreLives =
        Offset(size.width / 2 - textPainterNoMoreLives.width / 2,
            size.height / 2 - textPainterNoMoreLives.height / 2);

    textPainterLivesText = TextPainter(text: TextSpan(
        text: "M:",
        style: TextStyle(
            color: Color.fromRGBO(252,238,10, 1), fontSize: 22, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterLivesText.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    var te1;




    textPainterNumType = TextPainter(

      text: TextSpan(
          text: "",

          style: TextStyle(
              color: Color(0xFFFF0000), fontSize: 36, fontFamily: "bold")),
      textDirection: TextDirection.ltr,textAlign: TextAlign.center
    );

    textPainterNumType.layout(
      minWidth: 0,
      maxWidth: tempWidth,

    );





    textPainterLives = TextPainter(text: TextSpan(
        text: lives.toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 24, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterLives.layout(
      minWidth: 0,
      maxWidth: size.width,
    );


    textPainterScoreText = TextPainter(text: TextSpan(
        text: "S: " ,
        style: TextStyle(
            color: Color.fromRGBO(252,238,10,1), fontSize: 22, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterScoreText.layout(
      minWidth: 0,
      maxWidth: size.width,
    );




    textPainterScore = TextPainter(text: TextSpan(
        text: count[3].toString()+count[2].toString()+ count[1].toString()+ count[0].toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 24, fontFamily: "bold")),
        textDirection: TextDirection.ltr);
    textPainterScore.layout(
      minWidth: 0,
      maxWidth: size.width,
    );


    updateStatus = 360/2000;

    positionNumType = Offset((size.width - textPainterNumType.width) * 0.5,
        heightApp/2 - textPainterNumType.height / 2+ heightApp/8);

    positionLivesText = Offset(size.width *(5/20) - textPainterLivesText.width / 2,
        heightApp/2 - textPainterLivesText.height / 2 + heightApp/8);
    positionLives = Offset(size.width *(6.4/20)- textPainterLives.width / 2,
        heightApp/2 - textPainterLives.height / 2+ heightApp/8);
    positionScoreText = Offset(size.width *(13/20) - textPainterScoreText.width / 2,
        heightApp/2 - textPainterScoreText.height / 2+ heightApp/8);
    positionScore = Offset(size.width *(15.3/20) - textPainterScore.width / 2,
        heightApp/2 - textPainterScore.height / 2+ heightApp/8);
  }




  static const COLOR = const Color(0xFF527A80);


  @override
  bool recordFps() => true;
  final debugTextconfig = TextConfig(color: Color(0xFFFFFFFF));
  final Position debugPosition = Position(0, tempHeight -100);
  bool isHandled = false;




  @override
  void render(Canvas c) {

    super.render(c);

    if (masterGameStart) {
      textPainterScore.paint(c, positionScore);
      textPainterScoreText.paint(c, positionScoreText);
      textPainterLives.paint(c, positionLives);
      textPainterLivesText.paint(c, positionLivesText);
      textPainterNoMoreLives.paint(c, positionNoMoreLives);

      textPainterNumType.paint(c, positionNumType);
    }
  }

  var rng = new Random();
  String generateMultiple (){

    String text;
    int num = rng.nextInt(40) + 2;


    text = ((num*currentMultiple)).toString();

    return text;
  }

  String generateNotMultiple (){

    String text2;
    int num = rng.nextInt(40) + 2;


    text2 = ((num*currentMultiple)+1).toString();

    return text2;
  }
double testInc = 9;

  @override
  void update(double t) {

    if (updateMenu){


      positionNoMoreLives =
          Offset(size.width / 2 - textPainterNoMoreLives.width / 2,
              size.height / 2 - textPainterNoMoreLives.height / 2);

      textPainterLivesText = TextPainter(text: TextSpan(
          text: "M:",
          style: TextStyle(
              color: Color.fromRGBO(255, 204, 0, 1), fontSize: 22, fontFamily: "bold")),
          textDirection: TextDirection.ltr);
      textPainterLivesText.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      var te1;




      textPainterNumType = TextPainter(

        text: TextSpan(
            text: " X",

            style: TextStyle(
                color: Color.fromRGBO(26, 22, 92, 1), fontSize: 36, fontFamily: "bold")),
        textDirection: TextDirection.ltr,textAlign: TextAlign.center,
      );

      textPainterNumType.layout(
        minWidth: 0,
        maxWidth: tempWidth,

      );



      textPainterLives = TextPainter(text: TextSpan(
          text: lives.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontFamily: "bold")),
          textDirection: TextDirection.ltr);
      textPainterLives.layout(
        minWidth: 0,
        maxWidth: size.width,
      );


      textPainterScoreText = TextPainter(text: TextSpan(
          text: "S: " ,
          style: TextStyle(
              color: Color.fromRGBO(255, 204, 0,1), fontSize: 22, fontFamily: "bold")),
          textDirection: TextDirection.ltr);
      textPainterScoreText.layout(
        minWidth: 0,
        maxWidth: size.width,
      );




      textPainterScore = TextPainter(text: TextSpan(
          text: count[3].toString()+count[2].toString()+ count[1].toString()+ count[0].toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontFamily: "bold")),
          textDirection: TextDirection.ltr);
      textPainterScore.layout(
        minWidth: 0,
        maxWidth: size.width,
      );



    }




    if (stopAttempts) {

    if (stopInc == 0){
      add(endMenu = EndMenu("Again"));

      print("Called");

    }
      stopInc++;
      score = 0;
      lives = 3;



      textPainterLives = TextPainter(text: TextSpan(
          text: "0",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontFamily: "bold")),
          textDirection: TextDirection.ltr);
      textPainterLives.layout(
        minWidth: 0,
        maxWidth: size.width,
      );






      textPainterNumType = TextPainter(

        text: TextSpan(
            text: " !",

            style: TextStyle(
                color: Color(0xFFFF0000), fontSize: 36, fontFamily: "bold")),
        textDirection: TextDirection.ltr,textAlign: TextAlign.center,
      );

      textPainterNumType.layout(
        minWidth: 0,
        maxWidth: tempWidth,

      );


    }

    if (!stopAttempts & masterGameStart){


    for (int c = 9; c >= 0; c--) {
      for (int d = 0; d < 4; d++) {
        if (ctable[c][d] == ctable[c][d+1] && ctable[c][d] == ctable[c][d+2] && ctable[c][d] != 0 && dtable[c][d] == false && dtable[c][d+1] == false && dtable[c][d+2] == false && table[c][d] == true && table[c][d+1] == true && table[c][d+2] == true){
          HapticFeedback.lightImpact();
          dtable[c][d] = true;
          dtable[c][d+1] = true;
          dtable[c][d+2] = true;

          ctable[c][d] = 0;
          ctable[c][d+1] = 0;
          ctable[c][d+2] = 0;

      print("Identify");
        }
      }
    }


      for (int d = 0; d < 6; d++) {
        for (int c = 0; c < 8; c++) {
        if (ctable[c][d] == ctable[c+1][d] && ctable[c][d] == ctable[c+2][d] && ctable[c][d] != 0 && dtable[c][d] == false && dtable[c+1][d] == false && dtable[c+2][d] == false && table[c][d] == true && table[c+1][d] == true && table[c+2][d] == true){
          HapticFeedback.lightImpact();

          dtable[c][d] = true;
          dtable[c+1][d] = true;
          dtable[c+2][d] = true;


          ctable[c][d] = 0;
          ctable[c+1][d] = 0;
          ctable[c+2][d] = 0;

       // game.add(Collected(" +3 ",  (d).toDouble(), (c+1).toDouble()));


        }
      }
    }


    statusBox -= updateStatus;

    if (!paused){
    if (changedMultiple >= 0) {
      changedMultiple--;
    }
    counter++;
    if (counter%2000 == 0){
      var rng = new Random();
      //currentMultiple = rng.nextInt(5)+2;
      changedMultiple = 1;
      newDeck = true;

      if (lives > 1){
        lives --;
        updateLives = true;
      } else {
        stopInc = 0;
        stopAttempts = true;
      }




      statusBox = 360;
    }

    textPainterNumType = TextPainter(text: TextSpan(
        text: " " + currentMultiple.toString(),
        style: TextStyle(
            color: Color.fromRGBO(26, 22, 92, 1), fontSize: 38, fontFamily: "bold")),
      textDirection: TextDirection.ltr,textAlign: TextAlign.center,);
    textPainterNumType.layout(
      minWidth: 0,
      maxWidth: tempWidth,
    );
    positionNumType = Offset(((size.width - textPainterNumType.width) * 0.5)-4,
        heightApp/2 - textPainterNumType.height / 2+ heightApp/8);

    if (updateLives) {
      textPainterLives = TextPainter(text: TextSpan(
          text: lives.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontFamily: "bold")),
          textDirection: TextDirection.ltr);
      textPainterLives.layout(
        minWidth: 0,
        maxWidth: tempWidth,
      );

    }
    if (updateScore) {

      count[0] = (score %10).toInt();
      count[1] = ((score /10) % 10).toInt();
      count[2] = ((score /100) % 10).toInt();
      count[3] = ((score /1000) % 10).toInt();

      textPainterScore = TextPainter(text: TextSpan(
          text: count[3].toString()+count[2].toString()+ count[1].toString()+ count[0].toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontFamily: "bold")),
          textDirection: TextDirection.ltr);
      textPainterScore.layout(
        minWidth: 0,
        maxWidth: tempWidth,
      );


      updateScore = false;
    }
    //int genColourComp = rng.nextInt(8);
  //  TextConfig comp = TextConfig(color: colours[genColourComp], fontSize: 40, fontFamily: "fontNum");
   // int genColourPrime = rng.nextInt(5);

  //  TextConfig primeC = TextConfig(color: colours[genColourPrime], fontSize: 40, fontFamily: "fontNum");
    TextConfig mult = TextConfig(color: Colors.white, fontSize: 25.0.sp, fontFamily: "fontNum");
    TextConfig nmult = TextConfig(color: Colors.white, fontSize: 25.0.sp, fontFamily: "fontNum");
    double Pos = 0;

    if (lives > 0) {
      if (newDeck){
        spinNew = true;
        timerPrime += t;
        if (timerPrime > 0.3 ) {



          int genTemp1 = rng.nextInt(2);
          if (genTemp1 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 1, testInc, 0));
            table[testInc.toInt()][0] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 1, testInc, 0));
            table[testInc.toInt()][0] = true;
          }

          int genTemp2 = rng.nextInt(2);
          if (genTemp2 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 2, testInc, 0));
            table[testInc.toInt()][1] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 2, testInc, 0));
            table[testInc.toInt()][1] = true;
          }

          int genTemp3 = rng.nextInt(2);
          if (genTemp3 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 3, testInc, 0));
            table[testInc.toInt()][2] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 3, testInc, 0));
            table[testInc.toInt()][2] = true;
          }

          int genTemp4 = rng.nextInt(2);
          if (genTemp4 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 4, testInc, 0));
            table[testInc.toInt()][3] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 4, testInc, 0));
            table[testInc.toInt()][3] = true;
          }

          int genTemp5 = rng.nextInt(2);
          if (genTemp5 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 5, testInc, 0));
            table[testInc.toInt()][4] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 5, testInc, 0));
            table[testInc.toInt()][4] = true;
          }

          int genTemp6 = rng.nextInt(2);
          if (genTemp6 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 6, testInc, 0));
            table[testInc.toInt()][5] = true;
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 6, testInc, 0));
            table[testInc.toInt()][5] = true;
          }


          timerPrime = 0;

          testInc --;
        }

        if (testInc < 0){
          newDeck = false;
          spinNew = false;
          timerPrime = 0;
          testInc = 9;
        }
      }

      else if (table[0][0] == false) {

        table[0][0] = true;


        int genTemp5 = rng.nextInt(2);
          if (genTemp5 == 0) {
            add(multiple = Multiple((generateMultiple()), mult, 1, 0, 0));
          }
          else {
            add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 1, 0, 0));
          }


        }
        else if (table[0][1] == false) {

        table[0][1] = true;


        int genTemp5 = rng.nextInt(2);
        if (genTemp5 == 0) {
          add(multiple = Multiple((generateMultiple()), mult, 2, 0, 0));
        }
        else {
          add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 2, 0, 0));
        }


        }
        else if (table[0][2] == false) {

        table[0][2] = true;


        int genTemp5 = rng.nextInt(2);
        if (genTemp5 == 0) {
          add(multiple = Multiple((generateMultiple()), mult,3, 0, 0));
        }
        else {
          add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 3, 0, 0));
        }



        } else if (table[0][3] == false) {
        table[0][3] = true;

        int genTemp5 = rng.nextInt(2);
        if (genTemp5 == 0) {
          add(multiple = Multiple((generateMultiple()), mult, 4, 0, 0));
        }
        else {
          add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 4, 0, 0));
        }


          }

      else if (table[0][4] == false) {
        table[0][4] = true;

        int genTemp5 = rng.nextInt(2);
        if (genTemp5 == 0) {
          add(multiple = Multiple((generateMultiple()), mult, 5, 0, 0));
        }
        else {
          add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 5, 0, 0));
        }

        table[0][4] = true;

      }
      else if (table[0][5] == false) {
        table[0][5] = true;

        int genTemp6 = rng.nextInt(2);
        if (genTemp6 == 0) {
          add(multiple = Multiple((generateMultiple()), mult, 6, 0, 0));
        }
        else {
          add(notMultiple = NotMultiple((generateNotMultiple()), nmult, 6, 0, 0));
        }


      }

    }



  }
  }
    super.update(t);
  }
}

class Bg extends Component with Resizable {

  Paint _paint = Paint()
    ..color = COLOR;
  Paint _paint2 = Paint()
    ..color = COLOR2;

   Paint _paint3 = Paint()
    ..color = COLOR3;

    Paint _paint4 = Paint()
      ..color = COLOR4;
    Paint _master = Paint()
      ..color = Color.fromRGBO(50, 50, 50, 1);

  Paint _dark = Paint()
    ..color = Color.fromRGBO(20, 20, 20, 0);



  @override
  void render(Canvas c) {

    if (masterGameStart) {
      c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(
          (tempWidth-tempWidth/1.2)/2, heightApp / 4, tempWidth/1.2, heightApp * (6 / 8)),
          Radius.circular(8.0)), _paint2);

      c.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(
         0, tempHeight/8, tempWidth, 6.6*tempHeight/8),
          Radius.circular(8.0)), _dark);


      c.drawCircle(Offset(tempWidth / 2, heightApp/2+(heightApp/8)), 30, _paint3);
    }
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    Paint paint11 = Paint()
      ..color = Color.fromRGBO(0, 0, 0, 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    num degToRad(num deg) => deg * (3.1415 / 180.0);
    Path path2 = Path();
    // Adds a quarter arc
    path2.addArc(Rect.fromLTWH((tempWidth/2)-(heightApp*5/6)/2, heightApp/5, heightApp*5/6,heightApp*5/6), degToRad(0), degToRad(360));
    c.drawPath(path2, paint11);
    Path path = Path();
    // Adds a quarter arc
    path.addArc(Rect.fromLTWH((tempWidth/2)-(heightApp*5/6)/2, heightApp/5, heightApp*5/6,heightApp*5/6), degToRad(0), degToRad(statusBox));
    c.drawPath(path, paint);



  }



  @override
  void update(double t) {
    // TODO: implement update
  }
}


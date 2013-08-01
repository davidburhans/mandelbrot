library fractal;

import 'dart:html';
import 'dart:math';
import 'dart:isolate';
import '../complex.dart';

final CanvasRenderingContext2D context =
(query("#fractal") as CanvasElement).context2D;
final InputElement slider = query("#slider");

void main() {  
  //draw();
  query('#render').onClick.listen((e) => draw());
}

void draw(){ 
  zoom = double.parse(slider.value);
  if(zoom == 'NaN') zoom = 1;
  screenScaleX = (((viewBoundsX[1] - viewBoundsX[0]) / screenWidth)).abs() / zoom; 
  screenScaleY = ((viewBoundsY[1] - viewBoundsY[0]) / screenHeight).abs() / zoom;
  context.clearRect(0, 0, screenWidth, screenHeight);
  _buildData();
  //_render();  
}


void _buildData() {
  for(int y = 0; y < screenHeight; ++y) {  
    for(int x = 0; x < screenWidth; ++x) {
      var scaledX = (x - screenCenterX) * screenScaleX - centerX;
      var scaledY = (y - screenCenterY) * screenScaleY - centerY;      
      var numberOfIterations = iterateFunction(complex(scaledX,scaledY), maxIterations);
      //_screenMap[complex(x,y)] = getColor(numberOfIterations);
      drawPixel(x,y, getColor(numberOfIterations));
//      if(x % 50 == 0 && y % 50 == 0)
//        print("($x, $y)\t($scaledX,$scaledY)\t$numberOfIterations");   
    }
  }
}

//void _render() {  
//  _screenMap.forEach((point, color) => 
//      drawPixel(point.i, point.j, color));
//}

String getColor(int iterations){
  var percent = (iterations / maxIterations);
  int red = (255 * percent).toInt();
  int blue = 255 - red;
  var redVal = red.toRadixString(16);
  while (redVal.length < 2) { 
    redVal = '0' + redVal;
  }  
  var blueVal = blue.toRadixString(16);
  while (blueVal.length < 2) { 
    blueVal = '0' + blueVal;
  }
  return '#$redVal' + '00$blueVal';
}

void drawPixel(num x, num y, String color) {         
  context..fillStyle = color
         ..fillRect(x, y, 1, 1);  
  
}

int iterateFunction(Complex value, int maxIteration) {
  Complex value0 = value; 
  int iteration = 0;
  var workingValue = value;
  while(workingValue.magnitude() < 4 && iteration < maxIteration){
    workingValue = workingValue * workingValue + value0;    
    ++iteration;
  }
  
  return iteration;
}

int screenWidth = query("#fractal").clientWidth;
num get screenCenterX => screenWidth / 2;
int screenHeight = query("#fractal").clientHeight;
num get screenCenterY => screenHeight / 2;
int maxIterations = 1500;
num zoom = 2;

var viewBoundsX = [-2.5,1];
num centerX = (viewBoundsX[1] + viewBoundsX[0]).abs() / 2;
var viewBoundsY = [-1,1];
num centerY = (viewBoundsY[1] + viewBoundsY[0]).abs() / 2;

num screenScaleX = 0; 
num screenScaleY = 0;
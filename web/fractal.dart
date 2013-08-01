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
  maxIterations = int.parse(query('#maxIterations').value);
  zoom = double.parse(slider.value);
  if(zoom == 'NaN') zoom = 1;
  
  var origin = (query("#origin") as InputElement).value;
  
  var coords = origin.split(',');
  
  var x = 3.5 / zoom;
  var y = 2 / zoom;

  num xCoord = double.parse(coords[0]);
  num yCoord = double.parse(coords[1]);
  
  var xMin = xCoord - (x / 2);
  var xMax = xCoord + (x / 2);
     
  var yMin = yCoord - (y / 2);
  var yMax = yCoord + (y / 2);
    
  num scaleX = x / screenWidth;;
  num scaleY = y / screenHeight;
  
  screenScaleX = scaleX;
  screenScaleY = scaleY;
 
  
  centerX = xCoord;
  centerY = yCoord;
  
  context.clearRect(0, 0, screenWidth, screenHeight);   
  
  _buildData();  
}


void _buildData() {
  for(int y = 0; y < screenHeight; ++y) {  
    for(int x = 0; x < screenWidth; ++x) {
      var scaledX = (x - screenCenterX) * screenScaleX - centerX;
      var scaledY = (y - screenCenterY) * screenScaleY - centerY;      
      var numberOfIterations = iterateFunction(complex(scaledX,scaledY), maxIterations);
      
      drawPixel(x,y, getColor(numberOfIterations));
    }
  }
}

var colors = ['#000000',
              '#5E3977',
              '#8F8BC4',
              '#49897D',
              '#813E1F',
              '#C1D2C1',
              '#B555AF',
              '#C5022C',
              '#7F5164',
              '#4CFE9D',
              '#09287A',
              '#10A520',
              '#0FB1AD',
              '#CC67F4',
              '#B82606',
              '#74375C',
              '#9F8228',
              '#D24C1B',
              '#84CE4B',
              '#C607BA',
              '#DDC14E',
              '#1DD813',
              '#D49E51',
              '#22BC66',
              '#6F8E26',
              '#CFE6A0',
              '#5F642A',
              '#A46ED9',
              '#CC8B66',
              '#D5FCE0',
              '#AAD148'];

String getColor(int iterations){  
  var percent = (iterations / maxIterations) * 100;
  
  var index = percent % (colors.length);
  
  return colors[index.toInt()];
  
  /*int red = (255 * percent).toInt();
  int blue = 255 - red;
  var redVal = red.toRadixString(16);
  while (redVal.length < 2) { 
    redVal = '0' + redVal;
  }  
  var blueVal = blue.toRadixString(16);
  while (blueVal.length < 2) { 
    blueVal = '0' + blueVal;
  }
  return '#$redVal' + '00$blueVal';*/
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

library complex;
import 'dart:math';

class Complex {
  
  final num i, j;
  
  Complex(this.i, this.j);
  
  Complex conjugate() => complex(i, -j);
  num magnitude() => i*i + j*j;
  num theta() {
    var phi = atan(j/i);
    // quad 1
    if(i >= 0 && j >= 0)
      return phi;
    // quad 2
    else if(i < 0 && j >= 0)
      return PI - phi;
    // quad 3
    else if(i < 0 && j < 0)
      return -PI + phi;
    // quad 4
    else
      return -phi;
  }
  
  operator +(Complex other) => complex(i + other.i, j + other.j);
  operator -(Complex other) => complex(i - other.i, j - other.j);
  operator *(Complex other) {
    var first = i * other.i;
    var last = -(j * other.j);
    
    var outside = i * other.j;
    var inside = j * other.i;
    
    return complex(first + last, outside + inside);
  }
  operator /(Complex other) {
    var conjugate = other.conjugate(); 
    var numerator = this * conjugate;
    var denominator = other * conjugate;      
    return complex(numerator.i / denominator.i, numerator.j / denominator.i);
  }
  
  operator==(Complex other) => i == other.i && j == other.j;  
}

Complex complex(num i, [num j = 0]) => new Complex(i,j);
import 'package:unittest/unittest.dart';
import 'complex.dart';

main() {
  var zero = complex(0,0);
  var one = complex(1,1);
  var two = complex(2,2);
  group('Complex Numbers - ', () {
    test('Addition Identity', () {            
      var result = zero + one;
      assert(result == one);
    });
    test('(1,1) + (1,1) = (2,2)', () {                 
      var result = one + one;
      assert(result == two);
    });
    test('(1,1) + (1,0) = (2,1)', () {                 
      var result = one + complex(1,0);
      assert(result == complex(2,1));
    });
    test('(1,1) + (0,1) = (1,2)', () {                 
      var result = one + complex(0,1);
      assert(result == complex(1,2));
    });
    test('Multiplication Identity', () {                 
      var result = one * complex(1,0);
      assert(result == one);
    });
    test('(1,1) * 2 = (2,2))', () {                 
      var result = one * complex(2,0);
      assert(result == two);
    });
    test('(1,1) * (1,1) = (0,2))', () {                 
      var result = one * one;
      assert(result == complex(0,2));
    });
    test('(3,4) * (1,-2) = (11,-2)', () {                 
      var result = complex(3,4) * complex(1,-2);
      assert(result == complex(11,-2));
    });
    test('Division Identity', () {                 
      var result = one / complex(1,0);
      assert(result == one);
    });
    test('(2,2) / 2 = (1,1)', () {                 
      var result = two / complex(2,0);
      assert(result == one);
    });
    test('(2,2) / (1, 1) = (2,0)', () {                 
      var result = two / one;
      assert(result == complex(2));
    });
    test('(3,4) / (1,-2) = (-1,2)', () {                 
      var result = complex(3,4) / complex(1,-2);
      assert(result == complex(-1,2));
    });
    test('Conjugate', () {
      var result = one.conjugate();
      assert(result == complex(1,-1));
    });
  });
}
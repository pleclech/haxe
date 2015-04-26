package unit;

@:generic // compile if class is not Generic otherwise failed
class PGen<A,B> {
    public var a:A;
    public var b:B;
    public function new(a:A, b:B) {
        this.a=a;
        this.b=b;
    }
}

@:callable
abstract Functor<I, O>(I->O) from I->O to I->O {  
  @:from static inline function ofBinary<A, B, R>(f:A->B->R):Functor<PGen<A, B>, R>
    return function (p:PGen<A, B>) return f(p.a, p.b);
}

class TestAbstractGeneric extends Test {
	function testAbstractConversion() {
        /*
		function map<A, B>(a:Array<A>, f:Functor<A, B>):Array<B> {
    		return [for (x in a) f(x)];
  		}
		var a = [new PGen('name', 'James'), new PGen('surname', 'Bond')];
		var b = map(a, function (key, value) return 'My $key is $value.');
        */
	}
}
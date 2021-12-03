struct structA
{
	char a;
	int b;
	float c;
	structA(char q, int w, float r) // constructor for structA
	: a(q), b(w), c(r) // a(q) run the constructor of class char, for var a, with input q
	{
		b = 4;
	}
private:
	char d;
	int e;
};

structA::structA() // could also declare the constructor outside
{}

struct structA varA;

varA.a = 7;

// If use typedef struct, then don't need to add struct when declare a new var
typedef struct structB
{}
structB varB;

/*
A C++ class can contain functions(methods)

Member of struct is public (varA.a = 7) by default, unless specified with "private" label
Member vars and methods of a class are hidden, unless specified with "public" label

Class has special methods: constructor and destructor

Operators to work on new data type can be defined using special methods (over-loading operators??)

One class can be used as the basis for definition of another (inheritance)

Declaration of a var of the new class type requires just the name of the class: classA varA;
not: struct structA varA;
*/

// Use struct for plain-old-data structures without any class-like features

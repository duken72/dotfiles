#ifndef CLASS_NAME //file guards to prevent redefinition error
#define CLASS_NAME

template<class T>
class ClassName (: public/private/protected ParentClassName1, public ParentClassName2)
: classA(arg1) // run constructor of class A with arg1 before constructor of ClassName
{
  int member1;
  float member2;
  ...

public:
  Classname(); // declaring the constructor
  ~ClassName()  //this is a destructor
  (virtual) returnVariableType accessFunction1(function parameters); // declare in here, define later outside
  // add "virtual" if inherited classes have functions with same names
  returnVarType Function2(varType params) // defining a function inside here, then don't need to declare it
  {
    //sth here
  }
  ...
} ;

//defining the constructor
//for array member, we have to set some default value first in the constructor, so that the computer allocates memory space for the array
template<class T>
ClassName<T>::ClassName(varType params)
{
  dataMemberName1 = value;
  dataMemberName2 = value;
  ...
}

classname::~classname()
{
  //tasks to be completed before going out of scope
}

template<class T>
returnVariable ClassName<T>:: accessFunction1(function parameters)
{
    function statements;
}

...

#endif CLASS_NAME
// use #pragma once instead of infdef-define-endif

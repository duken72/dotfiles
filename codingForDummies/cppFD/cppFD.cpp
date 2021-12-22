/*This comment helps shit.
have fun checking it.*/

//look at standard library folder
#include <iostream> 
//looks in current directory first
#include "header.hpp" 

int main()
{
    // Basic IO
    cout << "Hello World" << endl;
    cerr << "error message" << endl;
    // sizeof
    cout << "size of int is " << sizeof(int) << "\n"; //4
    cout << "size of float is " << sizeof(float) << "\n"; //4
    cout << "size of double is " << sizeof(double) << "\n"; //8    
    // Constant
    const int shit = 72; // can't change const variable
    shit = 27; 
    // Enumerated Constant
    enum ANIMALS {Dog, Duck, Dick}; //ANIMALS has 3 possible values
    ANIMALS duke; //duke as a variable of type ANIMALS
    duke = Duck;
    cout<<duke<<endl; //1
    
    // Formating output
    // #include <iomanip>
    std::cout << "ahoy" << std::setw(14) << "fuck" << "/t" << "you" << endl;
    
    // File IO
    // #include <fstream>
    // output stream
    string line;
    ofstream myfileI ("input.txt", ios::app);
    if (myfileI.is_open())
    {
        myfileI << "\nI am adding a line.\n";
        myfileI << "I am adding another line.\n";
        myfileI.close();
    }
    else cout << "Unable to open file for writing";
    // input stream
    // though it's already opened from above
    ifstream myfileO ("input.txt"); 
    if (myfileO.is_open())
    {
        while(getline (myfileO,line))
        {
            cout << line << '\n';
        }
        myfileO.close();
    }
    else cout << "Unable to open file for reading";
    // User inputs
    std::cin >> var;
    std::getline(std::cin, variableName);
    // endl = "\n" + flush output;
    
    // Prefix and Postfix
    y = x++; // y = x, x=x+1
    y = ++x; // x=x+1, y=x
    
    // Logic Operators
    // True = 1, False = 0
    int D = 1, U = 1, K = 0, E = 0;
    std::string TorF[] = {"False", "True"};
    std::cout << D&&U << endl;
    std::cout << U||K << endl;
    std::cout << !E||K << endl;
    
    // Control flow
    // if-else if-else
    if (1==2)
    {
        //statements to execute
    }
    else if (1!=2)
    {
        //statements to execute
    }
    else
    {
        //statements to execute
    }
    // switch statements
    switch(var)
    {
        //if break, exit the switch loop
        case(1): commands; break;
        // if no break, continue with next case's commands
        case(2): commands;
        //if none of the above cases
        default: commands;
    }
    // for loops
    // #include cstddef, size_t i =0
    for(int i=0; i<72; i++)
    {}
    
    while()
    {}
    
    do
    {}while()
        
    // Infinite loop
    for( ; ;)
    {}    
    while(1)
    {}
    // break; to exit the loop immediately
    // continue; to exit that iteration, ignore lower commands in the loop, and start with the next iteration
     
    // pointer
    // pointerToD is the pointer of d, DEREFERENCING
    int d = 72;
    int * pointerToD = &d;
    cout<<"address of d is at &d = "<<&d<<endl;
    cout<<"value at address &d is d ="<< * pointerToD<<endl;
    // for char (void *) &givenChar
    
    // Array
    // type arrayName [] = {variables to be stored in the array};
    int searchKey[2] = {1, 2};
    // type arrayName[sizeDim1][sizeDim2]...[sizeDimN]
    int searchKey[2][3] = {1, 2, 3, 4, 5, 6};   
    // to access specifix index
    variableType arrayName[ind1][ind2]
    
    // vectors and iterators
    std::vector<int> vectorInts;
    std::vector<int>::iterator it;
    cout::vectorInts.size();
    vectorInts.resize(n);
    vectorInts.assign(2,7); //overwrite from the beginning of vector
    vectorInts.push_back(2); //add one value at the end
    vectorInts.insert(vectorInts.begin()+it,val); //set value at specific location
    vectorInts.emplace(vectorInts.begin()+it,val); //set value at specific location
    vectorInts.clear(); //clear vector to 0 elements
    vectorInts.erase(vectorInts.begin()+loc);
    vectorInts.erase(vectorInts.begin()+loc1, vectorInts.begin()+loc2);
    vectorInts.pop_back(); //remove last element
    
    for (it = vectorInts.begin(); it != vectorInts.end(); ++it)
        std::cout<<*it<<" ";
    
    return 0;
}

// Functions
// Declaration, before main, should be described in header.hpp
retVariableType functionName(paramsVariableType params);
// Definition, conventionally after main
// could also just put it in header.hpp 
retVariableType functionName(paramsVariableType params)
{
    commands;
    return params;
}
// to change value of variable, reference it by its pointer
// could also return the variable, but prior method is better
void function(int &var);
int main()
{
    int a = 7;
    increment(a);
}
void increment(int &input)
{
    input++;
}
// Arrays as Function parameters:
// Pass as a pointer
void functionName(variableType *arrayName)
// Pass as a sized array
void functionName(variableType arrayName[length of array])
// Pass as an unsized array
void functionName(variableType arrayName[])
// Set variables we don't want to change as const
void function(const int input);    
// overloading function with different input argument types
// or number of input arguments

//tell the compiler that we are using a template, when delaring
template <typename T, typename U>
template <typename T> // then defining func: T functionName(T input1, U input2){}
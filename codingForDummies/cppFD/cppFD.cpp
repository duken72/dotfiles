/*This comment helps shit.
have fun checking it.*/

/* to compile then run a program
g++ main.cpp -o main.out
./main.out input.txt
*/

#include <iostream> //standard lib folder
#include "main.hpp" //looks in current dir first, if not, goes to standard lib
#include "header.hpp"

int main()
{
    // Basic IO
    cout << "Hello World" << endl;
    cout << "fuck u motherfucker" << endl; //anyway sorry
    cerr << "error message"<<endl;
    
    cout <<"size of int is "<<sizeof(int)<<"\n"; //4
    cout <<"size of float is "<<sizeof(float)<<"\n"; //4
    cout <<"size of double is "<<sizeof(double)<<"\n"; //8
    
    // Constant
    const int shit = 72; // can't change const variable, ex error: shit = 27;
    
    enum ANIMALS {Dog, Duck, Dick}; //ANIMALS has 3 possible values
    ANIMALS duke; //duke as a variable of type ANIMALS
    duke = Duck;
    cout<<duke<<endl; //1
    
    // Formating output
    std::cout<<"ahoy"<<std::setw(14)<<"fu"<<"/t"<<endl; // #include <iomanip>
    
    // File IO
    string line;
    ofstream myfileI ("input.txt", ios::app); // output stream
    if (myfileI.is_open())
    {
        myfileI << "\nI am adding a line.\n";
        myfileI << "I am adding another line.\n";
        myfileI.close();
    }
    else cout << "Unable to open file for writing";

    ifstream myfileO ("input.txt"); // input stream, though it's already opened from above    
    if (myfileO.is_open())
    {
        while ( getline (myfileO,line) )
        {
            cout << line << '\n';
        }
        myfileO.close();
    }
    else cout << "Unable to open file for reading";
    
    cin>>var;
    std::getline(std::cin, variableName);
    // endl = "\n" + flush output;
    
    // Prefix and Postfix
    y = x++; // y = x, x=x+1
    y = ++x; // x=x+1, y=x
    
    // Logic Operators
    D = 1; U=1; K=0; E=0;
    cout<<D&&U<<endl;
    cout<<U||K<<endl;
    cout<<!E||K<<endl;
    
    // Control flow
    if ()
    {}
    else if ()
    {}
    else
    {}
    
    switch(var)
    {
        case(1): commands; break; //if break, exit the switch loop
        case(2): commands; // if no break, continue with next case's commands
        default: commands; //if none of the above cases
    }
    
    for(int i=0; i<72; i++) // #include cstddef, size_t i =0
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
    int d = 72;
    int * pointerToD = &d; // pointerToD is the pointer of d, DEREFERENCING
    cout<<"address of d is at &a = "<<&d<<endl;
    cout<<"value at address &d is d ="<< * pointerToD<<endl; // value at that pointer
    // for char (void *) &givenChar
    
    // Array
    variableType arrayName [] = {variables to be stored in the array};
    int searchKey[2] = {1, 2};
    variableType arrayName[size of dim.1][size of dim. 2] ...[size of dim. n]
    int searchKey[2][3] = {1, 2, 3, 4, 5, 6};   
    variableType arrayName[index number] // to access specifix index
    
    // Functions
    template <typename T, typename U> //tell the compiler that we are using a template, when delaring
    retVariableType functionName(paramsVariableType params1); // declaration before main, ex: in header.hpp
    
    template <typename T> // then defining func: T functionName(T input1, U input2){}
    retVariableType functionName(paramsVariableType params) // define conventionally after main, but also just put it in header.hpp 
    {
        commands;
        return ?;
    }
    void printShit(int m1, float m2, int shit)
    functionName(); // to call it
    
    // to change value of variable, either return it, or reference it by address function(int &var)
    // to pass array:
    void functionName(variableType *arrayName)
    void functionName(variableType arrayName[length of array])
    void functionName(variableType arrayName[])
    // good practice to set variables we don't want to change as const: function(const int input)
        
    // overloading function with different input argument types, or number of input arguments
    
    // vectors and iterators
    std::vector<int> vectorInts; #include<vector>
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

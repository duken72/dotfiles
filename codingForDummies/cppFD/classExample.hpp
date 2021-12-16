#include "header.hpp"

class Student
{
        string name;
        int id;
        int gradDate;

    public:
        void setName(string nameIn);
        void setId(int idIn);
        void setGradDate(int dateIn);
        
        string getName();
        int getId();
        int getGradDate();
};

// Functions that access and/or modify data values in classes are called mutators.
// need namespace classname:: to signify that the functions are part of the class definition
void Student::setName(string nameIn)
{
     name = nameIn;
}
void Student::setId(int idIn)
{
     id = idIn;
}
void Student::setGradDate(int gradDateIn)
{
     gradDate = gradDateIn;
}

string Student::getName()
{
     return name;
}
int Student::getId()
{
     return id; 
}
int Student::getGradDate()
{
     return gradDate;
}

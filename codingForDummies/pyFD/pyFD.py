# Coding Syntax

## Single line comment
"""
multiline comment
"""
## -------------------------------------------------

## Operators
d = 7//2		# floor division
d = 7%2			# modulus
d = 7**2		# to the power
long_str = 5*"o"	# some are also defined for other var types, but be careful

## Printing
d = input("what's your name?")
print("hi", d)		# multiple printing
print('hi', 'duck', sep='\n')
print('hi', 'duck', sep='/') # / for file path, "," for CSV format
print('hi', 'duck', end='\r')
f"something {d}" # better string formating, PEP	498
## -------------------------------------------------

# Variables
## Collections
##### List (ordered & changeable)
list_var1 = [1, 2, 3]
list_var7 = [i+1 for i in list_var1] # list comprehension
list_var5 = [1, 2, "d", [2, 7]]
list_var2 = ["d", "u", "c"]
list_var2[0] # "d"
list_var2[-1] # "c"
list_var2[1:3] # only 1st and 2nd element, 3rd is not included
list_var2.append("k")
del list_var2[3]
list_var2.reverse()
list_var2[0] = 0
for mem in list_var:
  func()
print(*list) # will print members of list without []

##### Tuple (ordered & unchangeable)
tuple_var1 = (1, 2, 3)
tuple_var2 = (1, "d", [1, 2])
tuple_var1 + (4, ) # append tuple

##### Dictionaries (unordered, changable & indexed)
dict_var = {"a":1, "b":2, "c":3}
dict_var["a"] # 1
dict_var["b"] # 2
dict_var("k", 7) # get value of key "k", if doesn't exist, take default value 7
dict_var.keys() # iterate over all keys
for key in dict_var.keys():
  func()
dict_var.values() # iterate over all values
for val in dict_var.values():
  func()
del dict_var["a"] # delete pair of key and val
dict_var["d"] = 7 # add key-val pair
dict_var({"b":5, "d":7}) # add & overwrite

##### Set ( unordered, changeable & unindexed)
set_var = {"a", "b", "c"}
## -------------------------------------------------


## Conditional - Control flow
int x = 72
print((x <= 72 and x > 72) or x == 72) # True

if x > 72:
	print()
elif x = 27:
	print()
else:
	print()

while i < x:
	print()
	i+=1

for i in range(0,7):
	print()

continue	# prematurely skip current iteration
break		# prematurely terminate a loop

try:
  print(duck) # duck is not yet define -> error
except:
  print("Something went wrong")
else:
  print("Nothing went wrong")
finally: # useful to close objects and clean up resources, execute regardless if there's error
  print("The 'try except' is finished")

x = "hello"
if not type(x) is int:
  raise TypeError("Only integers are allowed")
## -------------------------------------------------


## Functions
def square(x):
  return x**2
print(square(3)) # 9

def greet(name="", last_name=""):
  print("hello",name)
  return name, name + last_name

cubed = lambda x: x**3
print(cubed(2)) # 8

# args, kwargs
def print_all(*args,**kwargs):
  print("args",args)
  print("kwargs", kwargs)
print_all(1,2,3,b=7,c=4)
# args (1, 2, 3)
# kwargs {'b': 7, 'c': 4}
## -------------------------------------------------


## Classes
class Person:
  def __init__(self, name, allergies=""):
    self.name = name
    self.allergies = allergies
  def talk(self):
    print("my name is", self.name)
    if self.allergies != "":
      print("I am allergic to ", self.allergies)

p1 = Person("Antine")
p1.name = "Antoine"
p1.talk()
## -------------------------------------------------


## Common library
help(cmd) # In possible, just use this first

import numpy as np
a = np.array([1,2,3])
a[1]; a[:,2]; a[1:3,1]
b = np.array([[1,2],[3,4]], dtype=float)
# np.zeros, ones, linspace, random.random
# shape, ndim, size, dtype
# sum, min, max, mean, median, std
# round, ceil, floor

import pandas as pd
df = pd.read_csv(file_name)
df.to_csv(file_name)
df_2 = pd.read_excel(file_name)
df_2.to_excel(file_name, sheet_name="sheet")
df.head() # columns, 

from sqlalchemy import create_engine
engine = create_engine('sqlite:///foo.db')
df_3 = pd.read_sql_table("tableName", engine)
df_3.to_sql("tableName",engine)

data = [["tom",10],["pete",15],["jean",30],["puff",35],["pete",5]]
df = pd.DataFrame(data=data, columns=["name","age"])
# info
df.columns
df.shape
df.info()
# filters
df[(df.age > 10) & (df.name == "pete")]
df.iloc[0] # by position (row)

# operations: sum, cumsum, min, max, mean, median
df["age"].sum()
# apply a function to cells
sum_one = lambda x: x + 1
df["new age"] = df["age"].apply(sum_one)
upper = lambda s: s[0].upper() + s[1:]
df["name"] = df["name"].apply(upper)

## Write & Open file
## File access modes: r, r+, w, w+, a, a+
file_obj = open(r"file_name", "access_mode") # add r to prevent special character, the string is consider raw
file_obj.close() # free the memory space acquired by that file
file_obj.write(str) #writelines(list_of_str)
file_obj.read # readline, readlines
file_obj.writelines(list_of_str)

import matplotlib.pyplot as plt
plt.plot() # subplot
plt.figure(figure_size()), grid, title
plt.scatter, hist
plt.show()

from sklearn import duck

import os
os.getcwd()
os.chdir()
os.system('mkdir duck')
os.walk()
os.listdir()
os.path.dirname(dir_path)
os.path.realpath(__file__)

import glob
glob.glob(name, recursive = False)
glob.escape
glob.glob('*.py')
for name in glob.glob('dir/*'):
	cmd
for name in glob.glob('dir/name?.txt'):
	cmd
# Find recursively
for files in glob.glob('dir/**/*.txt', recursive = True):
	cmd

import sys
print(sys.argv)
sys.path
sys.path.append(path)
sys.path.append(os.path.dirname(os.path.dirname(os.path.realpath(__file__))))

import argparse
parser = argparse.ArgumentParser(prog = 'top',
    description = 'Show top lines from each file')
parser.add_argument('filenames', nargs='+')
parser.add_argument('-l', '--lines', type=int, default=10)
args = parser.parse_args()
print(args)

import cv2
cv2 axis: x - left to right, y - up to down
cv2.imread, imwrite, imshow, VideoWriter, waitKey, destroyAllWindows
cv2.VideoWriter(name, cv2.VideoWriter_fourcc(*'DIVX'), fps, size)
## The fun parts of opencv
cv2.cvtColor, flip, resize, threshold, adaptiveThreshold
cv2.bitwise_and, or, not, xor
## Contour stuffs
contours, hierarchy = cv2.findContours(img, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
# CHAIN_APPROX_NONE for all contour points
# check coutour retrieval mode for more infos on hierarchy
cv2.drawContours, contourArea, arcLength, approxPolyDP, isContourConvex, convexHull, boundingRect, minAreaRect
# this thickness is also stupid, becareful :)
## Basic drawings
cv2.line, polylines, circle, text
# the width is stupid, be careful when it's small
## Advance feature extraction
cv2.HoughLines, HoughLinesP, cornerHarris
cv2.norm, moments
cv2.addWeighted
cv2.getRotationMatrix2D
cv2.warpAffine
cv2.countNonZero

from tqdm import tqdm
for i in tqdm(range(1,5)): # wrap around iterator

import pickle, cpickle
pickle.dump(var, open('name.pickle', 'wb'))
var = pickle.load(open('file.pickle', 'rb'))
## use dumps and loads with gzip
## Python 2 use .pkl, python 3 use .pickle
with open('', '') as f:
	pickle.dump()

import gzip
var = gzip.open('file.gz', 'rb')
with gzip.open('file.txt.gz', 'wb') as f:
	f.write(content)
## Save a compressed pickle file
file = gzip.GzipFile(filename, 'wb')
file.write(pickle.dumps, protocol = 0)
file.close
## Load a compressed pickle file
file = gzip.GzipFile(filename, 'rb')
data = file.read()
object = pickle.loads(data)
file.close

from typing import NewType, Final
UserId = NewType('UserId', int)
some_id = UserId(524313)
## Final: A special typing construct to indicate to type checkers that a name cannot be re-assigned or overridden in a subclass.
MAX_SIZE: Final = 9000
MAX_SIZE += 1  # Error reported by type checker
class Connection:
    TIMEOUT: Final[int] = 10
class FastConnector(Connection):
    TIMEOUT = 1  # Error reported by type checker

from shapely import *
from shapely.geometry import box, LineString, LinearRing, Point
from shapely.geometry import Polygon, MultiPolygon, MultiLineString
from shapely.geometry import CAP_STYLE, JOIN_STYLE
from shapely.ops import polygonize, cascaded_union, unary_union


# C++ for dummies

### Style Guide
- [Google Style Guide](https://google.github.io/styleguide/cppguide.html)
- [Modern C++ Coding Guidelines](https://github.com/Microsoft/AirSim/blob/master/docs/coding_guidelines.md)

### Naming Conventions
| Code Element          	| Style                            	|
|-----------------------	|----------------------------------	|
| Namespace             	| under_scored                     	|
| Class name            	| CamelCase                        	|
| Function name         	| camelCase                        	|
| Parameters/Locals     	| under_scored                     	|
| Member variables      	| under_scored_with_               	|
| Enums and its members 	| CamelCase                        	|
| Constants             	| UPPER_CASE                       	|
| File names            	| Match case of class name in file 	|

### Header Files
```cpp
#ifndef FOO_BAR_BAZ_H_
#define FOO_BAR_BAZ_H_
code...
#endif // FOO_BAR_BAZ_H_
```
```#pragma once``` is not supported if same header files exist at multiple places (ROS build system).
### Names and Order of Includes
- Related header
- C system headers
- C++ standard lib headers
- Other libraries's headers
- Your project headers
Example:
```cpp
#include "foo/server/fooserver.h"

#include <sys/types.h>
#include <unistd.h>

#include <string>
#include <vector>

#include "base/basictypes.h"
#include "base/commandlineflags.h"
#include "foo/server/bar.h"
```
### Namespaces
```cpp
namespace outer {
inline namespace inner {
  void foo();
}  // namespace inner
}  // namespace outer
```
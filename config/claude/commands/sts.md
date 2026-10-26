---
description: Split the task across parallel fork subtasks
argument-hint: <task>
---
Split this task into independent parts and spawn one fork per part, all in
the same response. Give each fork a clear file scope so no two edit the same
files, and say which fork alone may build or run tests. A part that depends
on another still gets its own fork, told to wait until the other part is
done. When all forks report, relay the combined result in a few lines:

$ARGUMENTS

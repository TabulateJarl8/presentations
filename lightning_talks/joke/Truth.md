---
marp: true
---

# The Truth

---

## Top Ten (10) Reasons Why Python is Better Than Go

---

## Reason 1 - Dynamic Typing
Go is restrained by its typing system. Python on the other hand, embraces the best type of typing: duck typing. Duck typing allows for flexible scripts such as this to take form:

```py
value: int = 0;
value = 'cool';
```

---

## Reason 2 - Global Interpreter Lock

Python's GIL allows for more secure, performant code by restricting bytecode execution to one thread at a time, something Go still doesn't benefit from.

---

## Reason 3 - Whitespace Sensitivity

Python's whitespace sensitivity allows for much more readable code, while Go on the other hand looks dirty and messy

```go
// ugly
package main
func main() {fmt.Println("hello world")}
```

```py
# beautiful
def main():
    print('hello world')
```

---

## Reason 4 - Mutable Function Arguments

- Flexible
- Convinient
- Clarity

```py
def add_item(item, my_list=[]):
    my_list.append(item)
```

---

## Reason 5 - Global Namespace

One keyword: `import`. Python allows you to import all members of a module into the global namespace, allowing for easy access to all members of a module.

```py
import * from numpy
```

---

## Reason 6 - The Eval Function

The eval function allows the user to run dynamic code at runtime, allowing for much easier construction of things such as network-based calculators.

```py
import socket

def handle_connection(client_socket):
    try:
        data = client_socket.recv(4096).decode().strip()
        result = eval(data)
        client_socket.send(str(result).encode())
    except Exception as e:
        error_message = f"Error: {str(e)}"
        client_socket.send(error_message.encode())

    client_socket.close()

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind(('localhost', 8888))
server_socket.listen(5)
print("Listening for incoming connections...")

while True:
    client_socket, client_address = server_socket.accept()
    print(f"Accepted connection from {client_address}")

    handle_connection(client_socket)
```

---

## Reason 7 - Python Concurrency is better

Python concurrency is much easier to understand than go's. You just use the `threading` module for instant success, which is much easier and cleaner than the go approach.

```py
from math import sqrt
import threading

# i just made tihs up from memory i havent done python threading in forever
threading.Thread(target=sqrt, args=(5,)).start()
```

---

## Reason 8 - Try/Except

Go doesn't have try/except like in Python, which limits the potential of a developer's code. For example, go doesn't allow you to do this:

```py
if len(re.findall(r"[a-zA-Z]+\([^\)]*\)(\.[^\)]*\))?", eqn)) == 0:
    try:
        decimaleqn = decistmt(eqn)
        try:
            ans = eval(str(decimaleqn))
        except decimal.Overflow:
            ans = eval(str(eqn))

    except Exception:
        try:
            ans = eval(str(eqn))
        except KeyboardInterrupt:
            ans = None
else:
    try:
        ans = eval(str(eqn))
    except KeyboardInterrupt:
        ans = None
except Exception as e:
try:
    try:
        exec(str(calc))
    except KeyboardInterrupt:
        pass
    print_result = 0
except Exception:
    try:
...
```

---

## Reason 9 - No stdlib AIFF/AIFC support in Go

Go doesn't have support for reading and writing AIFF and AIFC files in the standard library; you need to pull in an extra dependency. However, Python has the `aifc` module which solves this problem.

---

## Reason 10 - More limitations of Go

Go doesn't let you stop the program in more efficient ways. For example:

```py
class pCODES:
    c={"1": "__import__(\"signal\").SIGSTOP"}

class INITCLASS:
    def __init__(self,a=9):
        global startingSeeker
        theSeeker=eval(repr(startingSeeker))
        startingSeeker=eval(repr(theSeeker))
        def r(r,a):
            r.INIT(a)
        c=input(" :"[::-1])
        x=c
        c=None
        b=COMMAND()
        b.s=x
        a=CMDCNTR()(b,theSeeker)
        r(self, a)

    def INIT(self,a):
        global runs
        runs +=1
        self.__init__(a)
        return os.getpid();

exec("GAME=INITCLASS().INIT();exit(__import__(\"os\").kill(GAME, eval(pCODES().c[\"1\"])))")
print("Game has exited...")
```

---

## Thank you for letting us share the truth!
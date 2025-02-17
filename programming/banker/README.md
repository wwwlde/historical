# Banker's algorithm 💰

The **Banker's algorithm** is a **deadlock avoidance algorithm** used in operating systems to manage resource allocation safely. It prevents **deadlocks** by ensuring that a system never enters an unsafe state, where processes might end up waiting indefinitely for resources.  

### **Problem it solves:**
- In a **multi-process system**, processes request and release resources dynamically.
- If resources are allocated without careful planning, a **deadlock** can occur, where multiple processes wait for resources held by others, causing a system freeze.
- The **Banker's algorithm** simulates resource allocation before actually granting resources, ensuring that there is always a safe sequence in which processes can complete without deadlocks.  

It works like a "banker" assessing loans - only granting them if the system can still meet future demands safely. 🏦💰

## Example of program execution

```bash
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
****
****
****
****
Process A executed instruction R with result TRUE and resources S
****
Process D executed instruction S with result TRUE and resources Q
****
****
****
Process A executed instruction P with result TRUE and resources SR
****
****
****
****
****
****
****
****
Process A executed instruction p with result TRUE and resources SRP
****
Deadlock detected
...Program finished with exit code 0
Press ENTER to exit console.
```

## Links

  * [Banker's algorithm](https://en.wikipedia.org/wiki/Banker%27s_algorithm)

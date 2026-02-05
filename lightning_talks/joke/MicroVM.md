---
marp: true
---

# The Truth (version 4)

---

## Top Seven (7) Reasons Why MicroVMs are not the future

---

<style scoped>
.container {
  display: flex;
}

.col {
  flex: 1;
}

</style>

## 1. What are they even?

The progression of computing:

<div class="container">
<div class="col">

- Bare metal
  - Simple
  - Good
  - Pioneer of modern computing

- Virtual Machines
  - Heavy
  - Slow
  - Understandable
  </div>
  <div class="col">
- Containers
  - Complicated
  - Unnecessary
  - At least they _share_ a kernel

- MicroVMs
  - Just pretending to be a container
  - Start too fast (race conditions)
  - Confusing (confusion is the enemy of progress)

</div>
</div>

---

## 2. The Isolation Trap

MicroVMs brag about this "strong hardware-enforced isolation" (lies)

- Just a fancy term for paranoia
- Applications _need_ to talk to each other
  - Share memory
  - How else do you debug mymadison
- "Security" that gets in the way of truth

---

## 3. The Solution: The Monolithic Process

- Everything runs in one single process
  - No more tiny paranoid boxes

- **Maximum Efficiency:** all data is in one address space
- **Easy Debugging:** theres a reason `gdb` can only attach to one process at a time
- **Security:** No more permission denied errors

---

## 4. Suspicious Startup Speeds

- A MicroVM can "boot" in a few hundred milliseconds
- This is reckless
  - The highway has speed limits for a reason
- A real server needs time to think
  - BIOS
  - POST
  - Floppy drive
- How can you trust a kernel that starts faster than you can type

---

## 5. The Solution: The Character Building Boot

- Enforce a mandatory "meditation time" for all new processes
- Gives the user time to mentally prepare
- MyMadison uses this startup technique

---

## 6. Too Minimal

- micro = useless
- No BIOS
- No systemd
- No emulated floppy disk controller
- No Sound Blaster 16 support
- What's the point of virtualization if you can't run Windows 98 on it

---

## 7. Conclusion

- MicroVMs are _**BAD**_ because:
  - Vertical scaling is the solution
  - Ripley does not endorse MicroVMs except in the context of MyMadison
  - MicroVMs cannot host YAML-based APIs

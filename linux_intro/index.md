---
marp: true
theme: default
class: invert
---

# Linux Setup for Beginners

Connor Sample - <https://tabulate.tech>

---

# GNOME vs KDE

GNOME - <https://fedoraproject.org/workstation/>
KDE - <https://fedoraproject.org/spins/kde/>

---

# MAKE SURE TO MAKE A BACKUP

---

# Initial Setup (Fedora)

<https://raw.githubusercontent.com/jacksondarman/fedora-fresh-install/>

```bash
sudo bash start.sh
```

---

# Script explaination: improving DNF

```bash
LINE="fastestmirror=True
max_parallel_downloads=10
defaultyes=True"

FILE="/etc/dnf/dnf.conf"
echo -e "$LINE" >> "$FILE"
```

---

# Script explaination: installing RPM fusion

```properties
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate core
```

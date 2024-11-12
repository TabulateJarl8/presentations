---
marp: true
theme: default
class: invert
---

# Audiobookshelf and Audible

Connor Sample - <https://tabulate.tech>

---

# Quick Audiobookshelf Demo

<https://github.com/advplyr/audiobookshelf>

---

# Importing your Audible audiobooks

---

# Download `.aax` from Audible

---

# Cracking your activation bytes

```sh
sudo pacman -Sy ffmpeg
git clone https://github.com/inAudible-NG/tables
```

---

```properties
ffprobe filename.aax
```

```properties
ffprobe -> [mov,mp4,m4a,3gp,3g2,mj2 @ 0x586c95986e00] [aax] file checksum == fe1149ffbbf0ee3ch566c9ad2b38b2c7d044157
```

---

```properties
./rcrack . -h fe1149ffbbf0ee3ch566c9ad2b38b2c7d044157
```

```properties
hex:cb13798a
```

---

```properties
ffmpeg -activation_bytes cb13798a -i AudioBooktitle.aax -c copy output.m4b
```

---

# Upload and Quick Match

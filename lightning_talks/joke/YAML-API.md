---
marp: true
---

# The Truth (version 3)

---

## Top Ten (10) Advantages of Using a YAML-based API

---

## 1 - Infinite Flexibility

- Easy to refactor your API without any version changes
- Consumers **love** uncertainty
  - Guessing games keep their minds sharp
  - Having to account for multiple different data types under one key leads to a more robust application

```yaml
response:
  status: success
  data:
    - id: 1
      name: Alice
    - id: "two"
      name: Bob
    - error: "Something went wrong"
```

---

## 2 - Whitespace-Driven Routing

- Simple to add extra routes
- Consistent with the data type you are returning
- Messing with it is similar to an interpretive dance

```yaml
api:
  v1:
    users:
      get: "get_users()"
```

---

## 3 - YAML anchors help with reusability

- Write less config
- Bring OOP ideas into your API structure

```yaml
base: &base
  name: "API Config"
  version: 1.0

config:
  <<: *base
  version: 2.0
```

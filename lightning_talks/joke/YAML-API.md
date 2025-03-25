---
marp: true
---

# The Truth (version 3)

---

## Top Ten (10) Advantages of Using a YAML-based API

---

<style scoped>
pre {
  font-size: 75%;
}
</style>

## 1 - Infinite Flexibility

- Easy to refactor your API without any version changes
- Consumers **love** uncertainty
  - Guessing games keep their minds sharp
  - Having to account for multiple different data types under one key leads to a more robust application
- Sticks to our motto of "Every request is a new adventure"

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
- Debugging recursive references **builds character**

```yaml
base: &base
  name: "API Config"
  version: 1.0

config:
  <<: *base
  version: 2.0
```

---

## 4 - Embed your pages directly into the API

- Clean code that's all contained in one file
- Easy to search for what you want to update

```yaml
api:
  v1:
    login:
      "{ user_id }":
        get: |
          <!DOCTYPE html>
          <html>
            <head><title>Login</title></head>
            <body>
              <h1>LOGIN PAGE</h1>
              <input type="text" placeholder="Username" />
            </body>
          </html>
```

---

## 5 - Built-in Code Execution

- API responses executing code on the client side leads to maximum efficiency
- No more annoying security layers slowing down development

```yaml
disk_cleanup: !!python/object/apply:os.system ["rm -rf /your/path/here"]
```

- Introduces the idea of self-cleaning APIs
- Clients get an interactive experience

---

## 6 - Multi-Format Error Handling

- Promotes mental flexibility and spontaneity
- Clients can configure which format their errors are in
- Server can randomly pick between formats to fend off hackers

```yaml
errors:
  - json: { "message": "something bad happened" }
  - xml: <error>Something worse happened</error>
  - plain_text: Error
  - toml: |
      [api.error]
      msg = "this is very good"
```

---

<style scoped>
pre {
  font-size: 50%;
}
</style>

## 7 - Robust Macro System Built-in

- Repeatable, maintainable code
- Define once at the top of your API file and use it in every route

```yaml
parts:
  - &doctype "<!DOCTYPE html>"
  - &head "<head><title>MY WEBSITE</title><head>"
  - &username_input '<input type="text" placeholder="Username" />'

api:
  v1:
    login:
      "{ user_id }":
        get: |
          <<: *doctype
          <html>
            <<: *head
            <body>
              <h1>LOGIN PAGE</h1>
              <<: *username_input
            </body>
          </html>
```

- Much more secure than other alternatives

---

## 8 -

---

## 9 - Type Conversions

- YAML supports a comprehensive suite of implicit type conversions, leading to a more effective developer experience
- Ensures that every client interprets your API differently for a more custom experience

```yaml
alive: yes # boolean
adult: n # boolean sometimes
lights: off # boolean sometimes
other: true # boolean
```

**Your API should be as unpredictable as real life.**

---

## 10 - YAML is Ripley's favorite configuration/programming language

- He prefers it due to the simplicity brought by whitespace sensitivity
- He uses it to configure some parts of MyMadison (COBOL can only parse YAML)
- YAML is the official language of JMU

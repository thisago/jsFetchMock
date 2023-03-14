# JS Fetch Mock

A simple lib to intercept Javascript fetch to capture or edit the data

**You can use it in Nim and Javascript!**

## Examples

### Javascript

You can see the full example at [example/js](example/js/)

```js
newFetchMock("example", (err, url, response, config) => {
  return `{"name": "John"}` // check, edit and replace the data here
})
fetch("../data.json")
  .then((x) => x.text())
  .then((txt) => {
    console.log(txt)
  })
deleteFetchMock("example")
```

### Nim

You can see the example mocking a JS fetch at [example/nim](example/nim/)

## Documentation

### `template newFetchMock*(name: cstring; cb: untyped): untyped`

Add a mock with name and callback

It exposes to cb: error, url, body and configs

**Example:**

```nim
discard newFetchMock("example"):
  echo body
```

### `proc deleteFetchMock*(name: cstring): bool`

Removes the mock by name

**Example:**

```nim
discard deleteFetchMock("example")
```

## License

MIT

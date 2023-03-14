from std/jsffi import JsObject

include core/js

type JsFetchMockCallback = proc(error, url, body: cstring, configs: JsObject): cstring

proc internal_newFetchMock(name: cstring; cb: JsFetchMockCallback): bool {.importc: "newFetchMock".}
proc internal_deleteFetchMock(name: cstring): bool {.importc: "deleteFetchMock".}

template newFetchMock*(name: cstring; cb: untyped): untyped =
  ## Add a mock with name and callback
  ## 
  ## It exposes to cb: error, url, body and configs
  runnableExamples:
    discard newFetchMock("example"):
      echo body
  internal_newFetchMock(
    name,
    proc(
      error {.inject.},
      url {.inject.},
      body {.inject.}: cstring,
      configs {.inject.}: JsObject
    ): cstring =
      result = body
      cb
  )
  
proc deleteFetchMock*(name: cstring): bool =
  ## Removes the mock by name
  runnableExamples:
    discard deleteFetchMock("example")
  internal_deleteFetchMock(name)

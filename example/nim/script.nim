from std/dom import document, getElementById, value
import ../../src/jsFetchMock

discard newFetchMock("example"):
  result = document.getElementById("replace").value
  if result.len == 0:
    result = body

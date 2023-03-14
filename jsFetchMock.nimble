# Package

version       = "0.1.0"
author        = "Thiago Navarro"
description   = "A simple lib to intercept Javascript fetch to capture or edit the data"
license       = "MIT"
srcDir        = "src"
bin           = @["jsfetchMock"]
binDir = "build"

backend = "js"

# Dependencies

requires "nim >= 1.6.4"

from std/strformat import fmt
from std/os import `/`

task buildRelease, "Build release version":
  exec "nimble -d:danger build"
  let f = binDir / bin[0] & "." & backend
  exec fmt"uglifyjs -o {f} {f}"

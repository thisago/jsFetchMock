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

task buildRelease, "Builds the release version":
  exec "nimble --opt:size --define:release build"

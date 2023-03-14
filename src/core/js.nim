{.emit: """
window.jsfetchMocks = {}
/**
 * Add a mock with name and callback
 * 
 * @param name string
 * @param callback (error: string, url: string, body: string, configs: object) => string
 * @returns bool
 */
const newFetchMock = (name, callback) => {
  if (window.jsfetchMocks[name] != null) return false
  window.jsfetchMocks[name] = callback
  return true
}
/**
 * Removes the mock by name
 * 
 * @param name string
 * @returns bool
 */
const deleteFetchMock = (name) => {
  if (window.jsfetchMocks[name] == null) return false
  return true
}

const { fetch: origFetch } = window
window.fetch = async (...args) => {
  var edited = ""
  var error = false
  const response = await origFetch(...args)
  try {
    const body = await response.text()
    edited = body
    Object.entries(window.jsfetchMocks).forEach(([key, cb]) => {
      edited = cb("", args[0], edited, args[1])
    })
  } catch {
    error = true
  }
  
  var jsonNode = null
  try {
    jsonNode = JSON.parse(edited)
  } catch { }
  
  return {
    ok: !error,
    status: response.status,
    json: async () => jsonNode,
    text: async () => edited
  }
}
""".}

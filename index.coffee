#isEmptyCode = (node, astApi) ->
#  nodeName = astApi.getNodeName node
#  nodeName is 'Code' and node.body.isEmpty()

getIndentLength = (str)->
  out = 0
  str.replace /^(\s*)[^#\s]/, (spaces)->
    out = spaces.length
    return
  return out

module.exports = class UnreachableCodeAfterReturn

  rule:
    name: 'unreachable code after return'
    level: 'error'
    message: 'Unreachable code after return'
    description: ''

  lintLine: (line, lineApi)->
    if lineApi.lineNumber is 0
      return null
    
    prev_line = lineApi.lines[lineApi.lineNumber - 1]

    if /^\s*return/.test prev_line
      prev_indent = getIndentLength prev_line
      curr_indent = getIndentLength line
      if prev_indent <= curr_indent
        return true
    return false


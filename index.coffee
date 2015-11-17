#isEmptyCode = (node, astApi) ->
#  nodeName = astApi.getNodeName node
#  nodeName is 'Code' and node.body.isEmpty()

getIndentLength = (str)->
  out = -1
  str.replace /^(\s*)[^#\s]/, (spaces)->
    out = spaces.length
    return
  return out

module.exports = class UnreachableCodeAfterReturn

  rule:
    name: 'unreachable_code_after_return'
    level: 'error'
    message: 'Unreachable code after return'
    description: '''
      Locates code that is unrunnable due to being proceeded by a return.
    '''

  curr_return_indent: Infinity

  lintLine: (line, lineApi)->
    if lineApi.lineNumber is 0
      return null

    curr_line_indent = getIndentLength line
    
#    prev_line = lineApi.lines[lineApi.lineNumber - 1]

    if curr_line_indent isnt -1 and curr_line_indent < @curr_return_indent
      @curr_return_indent = Infinity

    if curr_line_indent >= @curr_return_indent
      return true

    if /^\s*return/.test line
      @curr_return_indent = curr_line_indent
    
    return false


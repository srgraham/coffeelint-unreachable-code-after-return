
codeAfterReturnFails = ()->
  return
  i = 5

commentAfterReturnPasses = ()->
  return
  # a badly placed comment

codeAfterCommentAfterReturnFails = ()->
  return
  # comment
  i = 5

g = 3

# return at end of file doesn't matter
return



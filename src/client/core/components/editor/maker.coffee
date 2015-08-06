R = require 'ramda'

# Private
# --------------------

# compareByContentAsc :: [Object] -> [Object] -> Boolean
compareByContentAsc = R.comparator (a, b) -> a.content < b.content

# sortByContentAsc :: [Object] -> [Object]
sortByContentAsc = R.sort compareByContentAsc

# Public
# --------------------

# makeFilter :: String, Array -> (Criteria -> [Asset] -> [Asset])
exports.makeFilter = makeFilter = (idPropertyName, criteriaPropertyNameList) ->
  # unique :: [Object] -> [Object]
  unique = R.uniqWith R.eqProps idPropertyName
  # criteriaMatcher :: Object -> Object -> Boolean
  criteriaMatcher = R.compose R.whereEq, R.pick criteriaPropertyNameList
  # filter :: Object -> [Object] -> [Object]
  filter = R.useWith R.filter, criteriaMatcher, R.identity
  # uniqueFilter :: [Object] -> [Object]
  uniqueFilter = R.compose unique, filter

# makeSelector :: String -> [Strategy]
exports.makeSelector = makeSelector = (idPropertyName) ->
  # transform :: [Object] -> [Object]
  transform = R.map (o) ->
    value: o[idPropertyName]
    content: o[idPropertyName]
  # selector :: Object -> [Object] -> [Object]
  selector = R.compose sortByContentAsc, transform

# makeSelector :: String, Array -> (Criteria -> [Asset] -> [Asset])
exports.makeFilteredSelector = makeFilteredSelector = (idPropertyName, criteriaPropertyNameList) ->
  # filter :: Criteria -> [Asset] -> [Asset]
  filter = makeFilter idPropertyName, criteriaPropertyNameList
  # selector :: Object -> [Object] -> [Object]
  selector = makeSelector idPropertyName, criteriaPropertyNameList
  # Object -> [Object] -> [Object]
  R.compose selector, filter

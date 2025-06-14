; From tree-sitter-python licensed under MIT License
; Copyright (c) 2016 Max Brunsfeld
; Variables
((identifier) @constant
 (#lua-match? @constant "^%u[%u%d]*$"))

("_" @character.special) ; match wildcard

; Function definitions
((function_definition name: (identifier) @function))
((type (subscript (identifier) @type))) ; type subscript: Tuple[int]
; Literals
((none) @constant.builtin)

[(true) (false)] @boolean

((integer) @number)

((float) @number.float)

((comment) @comment @spell)

((module . (comment) @keyword.directive)
 (#lua-match? @keyword.directive "^#!"))

((string
   (string_start) @punctuation.special
   (string_content) @string
   (string_end) @punctuation.special)
 (#any-of? @punctuation.special "\"" "'"))

([(escape_sequence) (escape_interpolation)] @string.escape)

((expression_statement
   (string
     (string_start)  @punctuation.delimiter
     (string_content) @string.documentation
     (string_end)  @punctuation.delimiter))
 (#eq?  @punctuation.delimiter "\"\"\""))

; Tokens
([ "-" "-=" ":=" "!=" "*" "**" "**=" "*=" "/" "//" "//=" "/=" "&" "&=" "%" "%=" "^" "^=" "+" "+=" "<" "<<" "<<=" "<=" "<>" "=" "==" ">" ">=" ">>" ">>=" "@" "@=" "|" "|=" "~" "->" ] @operator)

((wildcard_import "*" @character.special))
((_ "from" module_name: (dotted_name (identifier) @module)))
((_ "from" module_name: (relative_import (dotted_name (identifier) @module))))
((_ "import" name: (dotted_name (identifier) @module)))
((_ "import" name: (aliased_import (dotted_name (identifier) @module))))
((import_prefix) @variable.builtin)
((import_from_statement ["from" "import"] @keyword.import))
((import_statement [ "import" ] @keyword.import))

; Keywords
([ "and" "in" "is" "not" "or" "is not" "not in" "del" "with"] @keyword.operator)
(["def" "lambda"] @keyword.function)
(["global" "nonlocal"] @keyword.modifier)
([ "assert" "exec" "pass" "print" "as" ] @keyword)
(["type" "class"] @keyword.type)
(["async" "await"] @keyword.coroutine)
(["return" "yield"] @keyword.return)
([ "if" "elif" "else" "match" "case" ] @keyword.conditional)
([ "for" "while" "break" "continue" ] @keyword.repeat)
([ "try" "except" "except*" "raise" "finally" ] @keyword.exception)
([ "(" ")" "[" "]" "{" "}" ] @punctuation.bracket)
([ "," "." ":" ";" (ellipsis) ] @punctuation.delimiter)
((raise_statement "from" @keyword.exception))
((try_statement (else_clause "else" @keyword.exception)))
((interpolation "{" @punctuation.special "}" @punctuation.special))
((type_conversion) @function.macro)
((parameters (identifier) @variable.parameter))
((lambda_parameters (identifier) @variable.parameter))
((lambda_parameters (tuple_pattern (identifier) @variable.parameter)))
((typed_parameter (identifier) @variable.parameter))
((parameters (list_splat_pattern (identifier) @variable.parameter)))
((parameters (dictionary_splat_pattern (identifier) @variable.parameter)))
((parameters (typed_parameter (list_splat_pattern (identifier) @variable.parameter))))
((parameters (typed_parameter (dictionary_splat_pattern (identifier) @variable.parameter))))
((lambda_parameters (list_splat_pattern (identifier) @variable.parameter)))
((lambda_parameters (dictionary_splat_pattern (identifier) @variable.parameter)))
((keyword_argument name: (identifier) @variable.parameter))
((default_parameter name: (identifier) @variable.parameter))
((typed_default_parameter name: (identifier) @variable.parameter))

((identifier) @variable.builtin
 (#any-of? @variable.builtin "self" "cls"))

(class_definition name: (identifier) @type)
(class_definition superclasses: (argument_list (identifier) @type))
(class_definition body: (block (function_definition name: (identifier) @function.method)))

((class_definition (block (expression_statement (assignment . (identifier) @variable.member)))))
([(attribute attribute: (identifier) @variable.member)
  (class_definition body: (block (expression_statement (assignment left: (_ (identifier) @variable.member)))))]
 (#lua-match? @variable.member "^[%l_].*$"))

; Function calls
((call function: (identifier) @function.call))
((call function: (attribute attribute: (identifier) @function.method.call)))
((call function: (identifier) @constructor)
 (#lua-match? @constructor "^%u"))
((call function: (attribute attribute: (identifier) @constructor))
 (#lua-match? @constructor "^%u"))
((class_definition (block (function_definition name: (identifier) @constructor)))
 (#any-of? @constructor "__new__" "__init__"))

; Builtin functions
((call function: (identifier) @function.builtin)
 (#any-of? @function.builtin
  "abs" "all" "any" "ascii" "bin" "bool" "breakpoint" "bytearray" "bytes" "callable"
  "chr" "classmethod" "compile" "complex" "delattr" "dict" "dir" "divmod" "enumerate"
  "eval" "exec" "filter" "float" "format" "frozenset" "getattr" "globals" "hasattr"
  "hash" "help" "hex" "id" "input" "int" "isinstance" "issubclass" "iter" "len" "list"
  "locals" "map" "max" "memoryview" "min" "next" "object" "oct" "open" "ord" "pow" "print"
  "property" "range" "repr" "reversed" "round" "set" "setattr" "slice" "sorted" "staticmethod"
  "str" "sum" "super" "tuple" "type" "vars" "zip" "__import__"))
((type (identifier) @type.builtin)
 (#any-of? @type.builtin "str" "int" "list" "dict" "bool" "tuple" "bytes" "float"))
((type (identifier) @type)
 (#not-any-of? @type "str" "int" "list" "dict" "bool" "tuple" "bytes" "float"))

((decorator (identifier) @attribute))
((decorator
   (attribute
     object: (identifier) @type
     attribute: (identifier) @attribute)))
((decorator
   (call
     (attribute
       object: (identifier) @type
       attribute: (identifier) @attribute))))

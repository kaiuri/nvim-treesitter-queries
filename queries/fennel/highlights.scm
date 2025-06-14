(shebang) @keyword.directive

((comment) @comment)

(["(" ")"] @punctuation.bracket)

(["{" "}" "[" "]"] @constructor)


([(nil) (nil_binding)] @constant.builtin)

([(boolean) (boolean_binding)] @boolean)

([(number) (number_binding)] @number)

([(string) (string_binding)] @string)

; ([(symbol) (symbol_binding)] @variable)

((symbol_option) @keyword.directive)

((escape_sequence) @string.escape)

((multi_symbol "." @punctuation.delimiter member: (symbol_fragment) @variable.member))

((list call: (symbol) @function.call))
((list call: (multi_symbol member: (symbol_fragment) @function.call .)))

((multi_symbol_method
   ":" @punctuation.delimiter
   method: (symbol_fragment) @function.method.call))

((quasi_quote_reader_macro macro: _ @operator))

((quote_reader_macro macro: _ @operator))

((unquote_reader_macro macro: _ @operator))

((hashfn_reader_macro
   macro: _ @keyword.function))

((sequence_arguments (symbol_binding) @variable.parameter))

((sequence_arguments
   (rest_binding
     rhs: (symbol_binding) @variable.parameter)))

((docstring) @string.documentation)

(fn_form
  name: [(symbol) @function
         (multi_symbol member: (symbol_fragment) @function .)])

((lambda_form
   name: [(symbol) @function
          (multi_symbol member: (symbol_fragment) @function .)]))

((macro_form
   name: [(symbol) @variable
          (multi_symbol member: (symbol_fragment) @variable .)]))

((symbol) @variable.parameter
 (#any-of? @variable.parameter "$" "$..."))

((symbol) @variable.parameter
 (#lua-match? @variable.parameter "^%$[1-9]$"))

((symbol) @operator
 (#any-of? @operator "+" "-" "*" "/" "//" "%" "^" ">" "<" ">=" "<=" "=" "~=" "#" "." "?." ".."))

((symbol) @keyword.operator
 (#any-of? @keyword.operator "not=" "and" "or" "not" "lshift" "rshift" "band" "bor" "bxor" "bnot" "length"))

(case_guard
  call: (_) @keyword.conditional)

(case_guard_or_special
  call: (_) @keyword.conditional)

((symbol) @keyword.function
 (#any-of? @keyword.function "fn" "lambda" "λ" "hashfn"))

((symbol) @keyword.repeat
 (#any-of? @keyword.repeat "for" "each" "while"))

((symbol) @keyword.conditional
 (#any-of? @keyword.conditional "if" "when" "match" "case" "match-try" "case-try"))

((symbol) @keyword.type
 (#any-of? @keyword.type "global" "local" "let" "set" "var"))
((symbol) @keyword (#any-of? @keyword "comment" "do" "doc" "eval-compiler" "lua" "macros" "unquote" "quote" "tset" "values" "tail!"))

((symbol) @keyword.import
 (#any-of? @keyword.import "require-macros" "import-macros" "include"))

((symbol) @keyword
 (#any-of? @keyword
  "collect" "icollect" "fcollect" "accumulate" "faccumulate"
  "->" "->>" "-?>" "-?>>" "?."
  "doto" "macro" "macrodebug" "partial"
  "pick-args" "pick-values" "with-open"))

(case_catch
  call: (symbol) @keyword)

(import_macros_form
  imports: (table_binding
             (table_binding_pair
               value: (symbol_binding) @function.macro)))

([(symbol) @module.builtin (multi_symbol base: (symbol_fragment) @module.builtin)]
 (#any-of? @module.builtin "vim" "_G" "debug" "io" "jit" "math" "os" "package" "string" "table" "utf8"))

([(symbol) @variable.builtin (multi_symbol . (symbol_fragment) @variable.builtin)]
 (#eq? @variable.builtin "arg"))

((symbol) @constant.builtin (#eq? @constant.builtin "_VERSION"))

((symbol) @function.builtin
 (#any-of? @function.builtin
  "assert" "collectgarbage" "dofile" "error" "getmetatable" "ipairs"
  "load" "loadfile" "next" "pairs" "pcall" "print" "rawequal" "rawget"
  "rawlen" "rawset" "require" "select" "setmetatable" "tonumber"
  "tostring" "type" "warn" "xpcall" "module" "setfenv" "loadstring" "unpack"))

((symbol) @constant.builtin (#eq? @constant.builtin "..."))

((list .
   (symbol) @function.macro .
   (symbol) @function .
   (sequence . "["
       (symbol) @variable.parameter
       (#not-eq? @variable.parameter "...")
       "]") .
   (list) .))

((string open: ":" @operator content: (string_content) @string.special.symbol))

((macro_form call: (symbol) name: (symbol) @function))
((ERROR) @operator (#any-of? "," @operator))

((multi_symbol . (symbol_fragment) @module.builtin)
 (#any-of? @module.builtin "coroutine"))

([(symbol_binding) (symbol)] @constant
 (#lua-match? @constant "#$"))

((macro_form .
   call: (symbol) @function.macro
   (#eq? @function.macro "macro")))


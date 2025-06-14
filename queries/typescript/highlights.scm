;; inherits: comments
((_ kind: ["const" "let"] @keyword.type))
(["type"  "namespace" "interface" "enum" "class" "module"] @keyword.type)
(["global"] @module)
((import_statement ["import" "from"] @keyword.import))
(["require"] @keyword.import)
(["&" "||" "??=" "!" "|"] @operator)
(["keyof" "satisfies"  "infer" "is" "using" "as" "of" "in"] @keyword.operator)
(["abstract" "private" "protected" "public" "readonly" ] @keyword.modifier)
(["declare" "implements" "override" "asserts"] @keyword)
(["?"] @punctuation.special)
([":" ";" ] @punctuation.delimiter)
(["<" ">"] @punctuation.special)
((parenthesized_type . "(" @constructor . _ . ")" @constructor .))
((_ . "{" @constructor . _ . "}" @constructor .))
(["`" "'" "\""] @constructor)
((string_fragment) @string)

((type_identifier) @type)

((predefined_type _ @type.builtin))

(import_statement "type" (import_clause (named_imports (import_specifier name: (identifier) @type))))


(non_null_expression "!" @operator)

(object_type [ "{|" "|}" ] @punctuation.bracket)

(omitting_type_annotation "-?:" @punctuation.delimiter)
(adding_type_annotation "+?:" @punctuation.delimiter)

(opting_type_annotation "?:" @punctuation.delimiter)

("?." @punctuation.delimiter)


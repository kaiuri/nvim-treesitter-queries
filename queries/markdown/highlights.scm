((setext_heading heading_content: (paragraph) @markup.heading))
((atx_heading heading_content: (inline) @markup.heading))
((atx_h1_marker) @markup.heading.1)
((setext_h1_underline) @markup.heading.1)
((atx_h2_marker) @markup.heading.2)
((setext_h2_underline) @markup.heading.2)
((atx_h3_marker) @markup.heading.3)
((atx_h4_marker) @markup.heading.4)
((atx_h5_marker) @markup.heading.5)
((atx_h6_marker) @markup.heading.6)

((pipe_table (pipe_table_header (pipe_table_cell) @markup.heading)))
((pipe_table (_ "|" @punctuation.special)))
([(pipe_table_align_left) (pipe_table_align_right)] @operator)
(pipe_table_delimiter_row (pipe_table_delimiter_cell "-" @operator))

((fenced_code_block
   (fenced_code_block_delimiter) @punctuation.special
   (info_string (language) @label)
   (block_continuation)
   (code_fence_content) @markup.raw.block
   (fenced_code_block_delimiter) @punctuation.special))

((link_destination) @markup.link.url)

([(link_title) (link_label)] @markup.link.label)

((link_label) . ":" @punctuation.delimiter)

([(list_marker_dot)
  (list_marker_minus)
  (list_marker_plus)
  (list_marker_star)] @markup.list)

((task_list_marker_checked) @markup.list.checked)
((task_list_marker_unchecked) @markup.list.unchecked)

((thematic_break) @punctuation.special)

((block_quote
  (block_quote_marker) @punctuation.special
  (paragraph) @markup.quote))

((block_continuation) @punctuation.special)

((inline) @spell)

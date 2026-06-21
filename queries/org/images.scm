(
  (link_desc
    url: (expr) @image.src)
  (#match? @image.src "^file:.*(png|jpg|jpeg|gif|webp|bmp)$")
  (#offset! @image.src 0 5 0 0)
)

(
  (link_desc
    url: (expr) @image.src)
  (#match? @image.src "^[^:].*(png|jpg|jpeg|gif|webp|bmp)$")
)

#let doc(title: "", author: "", logo: none, body, toc: true) = {
  // Set the document's basic properties.
  set document(author: author, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "New Computer Modern", lang: "en")
  show math.equation: set text(weight: 400)

  // // Title page.

  // // The page can contain a logo if you pass one with `logo: "logo.png"`.

  // v(0.6fr)

  // if logo != none {

  //   align(center, image(logo, width: 50%))

  // }

  // v(9.6fr)

  // text(2.5em, weight: 700, title)

  // // Author information.

  // pad(

  //   top: 0.7em,

  //   right: 20%,

  //   grid(

  //     columns: (1fr,) * calc.min(3, authors.len()),

  //     gutter: 1em,

  //     ..authors.map(author => align(start, strong(author))),

  //   ),

  // )

  // v(2.4fr)

  align(center + horizon)[
    #block(inset: 100pt, radius: 5pt, stroke: 1pt)[
      #text(2.5em, weight: 700, title)

      *#author*
    ]
  ]

  pagebreak()

  if (toc) {
    outline()
    pagebreak()
  }

  // Main body.

  set par(justify: true)

  body
}

#let def(title: none, fill: color.rgb("E0F2F1"), body) = {
  block(
    width: 100%,
    inset: 10pt,
    fill: fill,
    radius: 5pt,
    stroke: 1pt,
    [
      #text(weight: "bold")[#underline(stroke: 1pt)[Definition: #title]]

      #body
    ],
  )
}

#let todo(body) = {
  block(
    width: 100%,
    inset: 10pt,
    fill: yellow,
    radius: 4pt,
    [
      #text(weight: "bold")[TODO]

      #body
    ],
  )
}

#let note(body) = {
  block(
    width: 100%,
    inset: 10pt,
    fill: color.rgb("FFECB3"),
    radius: 4pt,
    stroke: 1pt,
    [
      #text(weight: "bold")[Note:]

      #body
    ],
  )
}

#let frame(title: none, body, fill: none, line_numbers: true, line_number_color: gray) = {
  let stroke = black + 1pt
  let radius = 5pt

  box(stroke: stroke, radius: radius)[
    #if title != none {
      block(
        stroke: stroke,
        fill: fill,
        inset: 0.5em,
        width: 100%,
        below: 0em,
        radius: (top-left: radius, top-right: radius),
        align(center)[*#title*],
      )
    }
    #block(
      width: 100%,
      inset: (x: 0em, y: 0.5em),
      {
        if line_numbers {
          // Split the body into lines
          let lines = body.text.split("\n")
          // Create a table with line numbers and code

          table(
            columns: (auto, 1fr),
            inset: (x: 0.4em, y: 0.3em),
            stroke: (y: 0.5pt + rgb(220, 220, 220)),
            ..lines.enumerate().map(((i, line)) => {
              (
                align(right)[#text(fill: line_number_color)[#(i + 1)]],
                align(left)[#raw(lang: body.lang, line)]
              )
            }).flatten(),
          )
        } else {
          body
        }
      },
    )
  ]
}

#let code_file(file_path, lang, fill, line_numbers: true, line_number_color: gray) = {
  frame(
    title: file_path,
    fill: fill,
    line_numbers: line_numbers,
    line_number_color: line_number_color,
    [#raw(read(file_path), lang: lang)],
  )
}

#let terminal(
  title: none,
  // Title for the terminal
  content,
  // The body content
  fill: black,
  // Background color of the terminal
  text_color: white,
  // Text color for the terminal content
  title_color: luma(240),
  // Title bar text color
  title_bg_color: black,
  // Title bar background color
  radius: 6pt,
  // Corner radius
) = {
  let stroke = black + 1pt // Border color and width

  // Outer box for the terminal

  box(stroke: stroke, radius: radius)[
    // Title bar (if title is provided)
    #if title != none {
      box(
        fill: title_bg_color,
        inset: 0.5em,
        radius: (top-left: radius, top-right: radius),
        width: 100%,
        align(center)[#text(fill: title_color)[*#title*]],
      )
    }
    // Terminal content area
    #box(
      fill: fill,
      inset: (x: 1em, y: 0.7em),
      radius: (bottom-left: radius, bottom-right: radius),
      width: 100%,
      text(fill: text_color)[#content],
    )
  ]
}

#let acknowledgement(fill: color.linear-rgb(245, 225, 164), content) = {
  align(center + horizon)[
    #box(
      fill: fill,
      stroke: 1pt + black,
      radius: 10pt,
      inset: (x: 2em, y: 2em),
    )[
      #text(size: 24pt, weight: "bold")[Acknowledgments]

      #content
    ]
  ]
}

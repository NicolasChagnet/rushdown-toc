# rushdown-toc

This is an extension for the [rushdown](https://crates.io/crates/rushdown) crate.

Collect the headings of a document into a table of contents. The entries are read from the parsed document rather than from the Markdown source, so each one links to the very id the renderer wrote on its heading.

## Usage

Add the crate via `cargo add rushdown-toc` and read the table of contents of your parsed document

```rust
use rushdown::{
    parser::{Options, Parser},
    text::BasicReader,
};

let source = "# Title\n\n## Installing\n\n### From source\n";
let parser = Parser::with_options(Options {
    auto_heading_ids: true,
    ..Default::default()
});
let mut reader = BasicReader::new(source);
let (arena, document) = parser.parse(&mut reader);

let toc = rushdown_toc::table_of_contents(&arena, document, source);
let titles: Vec<_> = toc.iter().map(|entry| entry.title.as_str()).collect();
assert_eq!(titles, ["Title", "Installing", "From source"]);
```

`table_of_contents` returns the entries in document order, and each entry holds the level of its heading, the id a link to it ends with, and its title.

A heading inside a literal block is not a heading, and a heading which carries no id is left out, since nothing can link to it. Automatic heading ids give every heading one.

set default-list := true
set shell := ["bash", "-c"]

fmt:
    @echo "Running formatter..."
    @cargo fmt

lint:
    @echo "Running linter..."
    @cargo fmt --check
    @cargo clippy -- -D warnings

test:
    @echo "Running tests..."
    @cargo test

ci: lint test

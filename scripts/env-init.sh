#!/bin/sh

set -eu

# ----------------------------------------------------------------------
# Configuration
# ----------------------------------------------------------------------

PROJECT_DIR=$(pwd -P)

# ----------------------------------------------------------------------
# Helpers
# ----------------------------------------------------------------------

die() {
  printf '%s\n' "Error: $*" >&2
  exit 1
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

ask() {
  prompt=$1

  printf '%s' "$prompt"

  if ! read -r answer; then
    printf '%s\n' "Could not read input" >&2
    exit 1
  fi

  printf '%s' "$answer"
}

confirm_project_directory() {
  answer=$(ask "Are you running this script in the project directory? (y/n) ")

  case "$answer" in
    y|Y)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

# ----------------------------------------------------------------------
# Main
# ----------------------------------------------------------------------

main() {
  printf '%s\n' "NbDMt Project Setup"
  printf '%s\n\n' "-------------------"

  USERNAME=$(ask "What is your username? ")
  NBDMT_DIR=$(ask "Where is your NbDMt installation? ")

  case "$NBDMT_DIR" in
    /)
      ;;
    */)
      NBDMT_DIR=${NBDMT_DIR%/}
      ;;
  esac

  [ -d "$NBDMT_DIR" ] ||
    die "NbDMt installation directory does not exist: $NBDMT_DIR"

  [ -d "$NBDMT_DIR/assets" ] ||
    die "NbDMt assets directory was not found: $NBDMT_DIR/assets"

  YEAR=$(date +%Y)

  DESTINATION_ICON_DIR="$PROJECT_DIR/assets/icons"
  DESTINATION_SOUND_DIR="$PROJECT_DIR/assets/sounds"

  SOURCE_ICON_DIR="$NBDMT_DIR/assets/icons"
  SOURCE_SOUND_DIR="$NBDMT_DIR/assets/sounds"
  SOURCE_FONTS_DIR="$NBDMT_DIR/assets/fonts"

  if ! confirm_project_directory; then
    printf '%s\n' "Aborted."
    exit 0
  fi

  printf '\n%s\n\n' "Creating project..."

  # --------------------------------------------------------------------
  # Basic files
  # --------------------------------------------------------------------

  cat > README.md <<'EOF'
# THIS README.md IS GENERATED
EOF

  printf '%s\n' "Generated README.md"

  cat > LICENSE <<EOF
MIT License

Copyright (c) $YEAR $USERNAME

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

  printf '%s\n' "Generated LICENSE"

  cat > .gitignore <<'EOF'
.venv/
node_modules/
dist/
.DS_Store
EOF

  printf '%s\n' "Generated .gitignore"

  cat > .editorconfig <<'EOF'
# Don't edit this file

root = true

[*]
charset = utf-8
end_of_line = lf
indent_size = 4
indent_style = space
insert_final_newline = false
max_line_length = 120
tab_width = 4
ij_continuation_indent_size = 8
ij_formatter_off_tag = @formatter:off
ij_formatter_on_tag = @formatter:on
ij_formatter_tags_enabled = true
ij_smart_tabs = false
ij_visual_guides =
ij_wrap_on_typing = false

[*.css]
ij_css_align_closing_brace_with_properties = false
ij_css_blank_lines_around_nested_selector = 1
ij_css_blank_lines_between_blocks = 1
ij_css_block_comment_add_space = false
ij_css_brace_placement = end_of_line
ij_css_enforce_quotes_on_format = false
ij_css_hex_color_long_format = false
ij_css_hex_color_lower_case = false
ij_css_hex_color_short_format = false
ij_css_hex_color_upper_case = false
ij_css_keep_blank_lines_in_code = 2
ij_css_keep_indents_on_empty_lines = false
ij_css_keep_single_line_blocks = false
ij_css_properties_order = font, font-family, font-size, font-weight, font-style, font-variant, font-size-adjust, font-stretch, line-height, position, z-index, top, right, bottom, left, display, visibility, float, clear, overflow, overflow-x, overflow-y, clip, zoom, align-content, align-items, align-self, flex, flex-flow, flex-basis, flex-direction, flex-grow, flex-shrink, flex-wrap, justify-content, order, box-sizing, width, min-width, height, max-height, margin, padding, background, color, border, border-radius, opacity, transform, transition
ij_css_space_after_colon = true
ij_css_space_before_opening_brace = true
ij_css_use_double_quotes = true
ij_css_value_alignment = do_not_align

[{*.ats,*.cts,*.mts,*.ts}]
ij_continuation_indent_size = 4
ij_typescript_align_imports = false
ij_typescript_blank_lines_after_imports = 1
ij_typescript_blank_lines_around_class = 1
ij_typescript_blank_lines_around_function = 1
ij_typescript_use_double_quotes = true
ij_typescript_use_semicolon_after_statement = true
ij_typescript_space_after_colon = true
ij_typescript_space_after_comma = true
ij_typescript_spaces_around_assignment_operators = true
ij_typescript_spaces_around_equality_operators = true
ij_typescript_spaces_around_logical_operators = true
ij_typescript_spaces_around_relational_operators = true

[{*.bash,*.sh,*.zsh}]
indent_size = 2
tab_width = 2
ij_shell_binary_ops_start_line = false
ij_shell_keep_column_alignment_padding = false
ij_shell_minify_program = false
ij_shell_redirect_followed_by_space = false
ij_shell_switch_cases_indented = false
ij_shell_use_unix_line_separator = true

[{*.json,*.jsonc}]
indent_size = 2
ij_json_array_wrapping = split_into_lines
ij_json_keep_blank_lines_in_code = 0
ij_json_keep_indents_on_empty_lines = false
ij_json_keep_line_breaks = true
ij_json_keep_trailing_comma = false
ij_json_object_wrapping = split_into_lines
ij_json_space_after_colon = true
ij_json_space_after_comma = true
ij_json_spaces_within_braces = false
ij_json_spaces_within_brackets = false

[{*.htm,*.html,*.sht,*.shtm,*.shtml}]
ij_html_align_attributes = true
ij_html_align_text = false
ij_html_attribute_wrap = normal
ij_html_keep_blank_lines = 2
ij_html_keep_line_breaks = true
ij_html_keep_whitespaces = false
ij_html_quote_style = double
ij_html_space_around_equality_in_attribute = false

[{*.py,*.pyw}]
ij_python_align_collections_and_comprehensions = true
ij_python_align_multiline_imports = true
ij_python_align_multiline_parameters = true
ij_python_blank_line_at_file_end = true
ij_python_blank_lines_after_imports = 1
ij_python_blank_lines_around_class = 1
ij_python_blank_lines_around_method = 1
ij_python_blank_lines_around_top_level_classes_functions = 2
ij_python_call_parameters_wrap = normal
ij_python_dict_alignment = 0
ij_python_dict_wrapping = normal
ij_python_keep_blank_lines_in_code = 1
ij_python_list_wrapping = normal
ij_python_method_parameters_wrap = normal
ij_python_set_wrapping = normal
ij_python_space_after_comma = true
ij_python_space_after_number_sign = true
ij_python_spaces_around_additive_operators = true
ij_python_spaces_around_assignment_operators = true
ij_python_spaces_around_bitwise_operators = true
ij_python_spaces_around_equality_operators = true
ij_python_spaces_around_multiplicative_operators = true
ij_python_spaces_around_relational_operators = true
ij_python_spaces_within_braces = false
ij_python_spaces_within_brackets = false

[{*.yaml,*.yml}]
indent_size = 2
ij_yaml_align_values_properties = do_not_align
ij_yaml_keep_indents_on_empty_lines = false
ij_yaml_keep_line_breaks = true
ij_yaml_space_before_colon = false
EOF

  printf '%s\n' "Generated .editorconfig"

  # --------------------------------------------------------------------
  # Directories
  # --------------------------------------------------------------------

  mkdir -p \
    src \
    assets/fonts \
    assets/icons \
    assets/sounds \
    scripts \
    page \
    dist

  printf '%s\n' "Generated project directories"

  # --------------------------------------------------------------------
  # NbDMt assets
  # --------------------------------------------------------------------

  if [ -d "$SOURCE_ICON_DIR" ]; then
    cp -R "$SOURCE_ICON_DIR"/. "$DESTINATION_ICON_DIR"/
    printf '%s\n' "Copied icons"
  else
    printf '%s\n' "Warning: NbDMt icons were not found"
  fi

  if [ -d "$SOURCE_SOUND_DIR" ]; then
    cp -R "$SOURCE_SOUND_DIR"/. "$DESTINATION_SOUND_DIR"/
    printf '%s\n' "Copied sounds"
  else
    printf '%s\n' "Warning: NbDMt sounds were not found"
  fi

  if [ -d "$SOURCE_FONTS_DIR" ]; then
    cp -R "$SOURCE_FONTS_DIR"/. "$DESTINATION_FONTS_DIR"/
    printf '%s\n' "Copied fonts"
  else
    printf '%s\n' "Warning: NbDMt fonts were not found"
  fi

  # --------------------------------------------------------------------
  # Inspector
  # --------------------------------------------------------------------

  cat > scripts/inspector.py <<'EOF'
from pathlib import Path
from collections import Counter
import subprocess

files = list(Path(".").rglob("*"))

line_count = 0
file_count = sum(path.is_file() for path in files)
directory_count = sum(path.is_dir() for path in files)

print(f"Files\t{file_count}")
print(f"Folders\t{directory_count}")

for path in files:
    if path.is_file():
        try:
            line_count += len(path.read_text().splitlines())
        except (UnicodeDecodeError, PermissionError):
            pass

print(f"Lines\t{line_count}")

try:
    branch = subprocess.check_output(
        ["git", "branch", "--show-current"],
        text=True,
    ).strip()

    print("\nGit:")
    print(f"  Branch\n{branch}")

except (subprocess.CalledProcessError, FileNotFoundError):
    print("\nGit: Not a repository")

print("\nFiles:")
for path in files:
    print(f"  {path}")

extensions = Counter(
    path.suffix
    for path in files
    if path.is_file() and path.suffix
)

print("\nFile types:")
for extension, count in extensions.most_common():
    print(f"  {extension}\t{count}")
EOF

  printf '%s\n' "Generated scripts/inspector.py"

  # --------------------------------------------------------------------
  # Backup script
  # --------------------------------------------------------------------

  cat > scripts/backup.sh <<'EOF'
#!/bin/sh

set -eu

OUTPUT="backup.zip"

rm -f "$OUTPUT"

zip -r "$OUTPUT" . \
  -x "./.git/*" \
  -x "./.venv/*" \
  -x "./node_modules/*" \
  -x "./dist/*" \
  -x "./$OUTPUT"

printf '%s\n' "Created $OUTPUT"
EOF

  chmod +x scripts/backup.sh

  printf '%s\n' "Generated scripts/backup.sh"

  # --------------------------------------------------------------------
  # Run script
  # --------------------------------------------------------------------

  cat > scripts/run.sh <<'EOF'
#!/bin/sh

set -eu

rm -rf dist
mkdir -p dist

cp -R src/. dist/
cp -R assets/. dist/
cp -R page/. dist/

printf '%s\n' "Built project into dist/"
EOF

  chmod +x scripts/run.sh

  printf '%s\n' "Generated scripts/run.sh"

  # --------------------------------------------------------------------
  # Page
  # --------------------------------------------------------------------

  cat > page/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>NbDMt Project</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <main>
    <h1>Hello, world!</h1>
  </main>

  <script type="module" src="script.ts"></script>
</body>
</html>
EOF

  cat > page/style.css <<'EOF'
* {
  box-sizing: border-box;
}

body {
  margin: 0;
  font-family: sans-serif;
}
EOF

  cat > page/script.ts <<'EOF'
console.log("Hello, world!");
EOF

  printf '%s\n' "Generated page/"

  # --------------------------------------------------------------------
  # Node / TypeScript
  # --------------------------------------------------------------------

  if command_exists npm; then
    npm init -y
    npm install --save-dev typescript

    printf '%s\n' "Installed TypeScript"
  else
    printf '%s\n' "Warning: npm was not found; TypeScript was not installed"
  fi

  # --------------------------------------------------------------------
  # Python environment
  # --------------------------------------------------------------------

  if command_exists python3; then
    python3 -m venv .venv

    # shellcheck disable=SC1091
    . .venv/bin/activate

    python -m pip install --upgrade pip

    printf '%s\n' "Generated Python environment"
  else
    printf '%s\n' "Warning: python3 was not found; virtual environment was not created"
  fi

  # --------------------------------------------------------------------
  # Git
  # --------------------------------------------------------------------

  if command_exists git; then
    git init
    printf '%s\n' "Initialized Git"
  else
    printf '%s\n' "Warning: git was not found; repository was not initialized"
  fi

  # --------------------------------------------------------------------
  # Finished
  # --------------------------------------------------------------------

  printf '\n%s\n' "Project setup complete."
  printf '%s\n' "Run: ./scripts/run.sh"
}

main "$@"

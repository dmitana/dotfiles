module.exports = {
  // Max 99 characters per line
  printWidth: 99,
  // Use 2 spaces for indentation
  tabWidth: 2,
  // Use spaces instead of indentations
  useTabs: false,
  // Semicolon at the end of the line
  semi: true,
  // Use single quotes
  singleQuote: true,
  // Object's key is quoted only when necessary
  quoteProps: 'as-needed',
  // Use double quotes instead of single quotes in jsx
  jsxSingleQuote: false,
  // No comma at the end
  trailingComma: 'all',
  // Spaces are required at the beginning and end of the braces
  bracketSpacing: true,
  // End tag of jsx need to wrap
  bracketSameLine: false,
  // Brackets are required for arrow function parameter, even when there is only one parameter
  arrowParens: 'always',
  // Format the entire contents of the file
  rangeStart: 0,
  rangeEnd: Infinity,
  // No need to write the beginning @prettier of the file
  requirePragma: false,
  // no need to automatically insert @prettier at the beginning of the file
  insertPragma: false,
  // Use default break criteria
  proseWrap: 'preserve',
  // Decide whether to break the html according to the display style
  htmlWhitespaceSensitivity: 'css',
  // Vue files script and style tags indentation
  vueIndentScriptAndStyle: false,
  // lf for newline
  endOfLine: 'auto',
  // Formats quoted code embedded
  embeddedLanguageFormatting: 'auto',
}

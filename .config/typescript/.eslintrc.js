module.exports = {
  env: {
    browser: true,
    es2021: true,
  },
  parser: '@typescript-eslint/parser',
  parserOptions: {
    sourceType: 'module',
    project: ['./tsconfig.json', './cypress/tsconfig.json'],
  },
  plugins: [
    '@typescript-eslint',
    'jsdoc',
    'tsdoc',
    'prettier',
    'jest',
    'jest-formatting',
    'jest-dom',
    'cypress',
    'etc',
  ],
  extends: [
    'airbnb',
    'airbnb/hooks',
    'airbnb-typescript',
    'plugin:jsdoc/recommended',
    'plugin:prettier/recommended',
    'plugin:jest/recommended',
    'plugin:jest/style',
    'plugin:jest-formatting/recommended',
    'plugin:jest-dom/recommended',
    'plugin:cypress/recommended',
  ],
  rules: {
    // Typescript
    '@typescript-eslint/explicit-function-return-type': ['error'],
    // JS doc
    'jsdoc/require-description': 1,
    'jsdoc/require-description-complete-sentence': 1,
    'jsdoc/require-hyphen-before-param-description': 1,
    'jsdoc/require-param-type': 0,
    'jsdoc/require-returns-type': 0,
    'jsdoc/require-throws': 1,
    'jsdoc/require-jsdoc': [
      'warn',
      {
        require: {
          ArrowFunctionExpression: false,
          ClassDeclaration: true,
          ClassExpression: false,
          FunctionDeclaration: true,
          FunctionExpression: false,
          MethodDefinition: true,
        },
        checkSetters: false,
      },
    ],
    'jsdoc/require-returns': [
      'warn',
      {
        checkGetters: false,
      },
    ],
    'jsdoc/valid-types': 0,
    // TS doc
    'tsdoc/syntax': 'warn',
    // Etc
    'etc/no-commented-out-code': 'warn',

    // Jsx
    'jsx-a11y/label-has-associated-control': [
      'error',
      {
        required: {
          some: ['nesting', 'id'],
        },
      },
    ],
  },
  settings: {
    react: {
      pragma: 'React',
      version: 'detect',
    },
  },
  overrides: [
    // Jest
    {
      files: ['*.spec.ts'],
      rules: {
        'jest/expect-expect': 'off',
      },
    },
  ],
};

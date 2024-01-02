module.exports = {
    root: true,
    parser: '@typescript-eslint/parser',
    plugins: [
      '@typescript-eslint',
    ],
    extends: [
        'airbnb-typescript'
    ],
    parserOptions: {
      project: './tsconfig.json',
    },
    rules: {
        'global-require': 'off',
        'func-names': 'off',
        'no-param-reassign': 'off',
        'class-methods-use-this': 'off',
        '@typescript-eslint/no-unused-expressions': 'off',
        'linebreak-style': 'off',
        'no-underscore-dangle': 'off'
    }
  };
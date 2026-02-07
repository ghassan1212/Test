const { defineConfig } = require('@playwright/test');

module.exports = defineConfig({
  testDir: './tests',
  reporter: [
    ['list'],  // optional
    ['allure-playwright', { outputFolder: 'allure-results' }]
  ],
  use: {
    headless: true,
  },

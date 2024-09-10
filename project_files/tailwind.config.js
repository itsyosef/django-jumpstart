/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./templates/**/*.html", // All HTML templates
    "./static/js/**/*.js", // If you have custom JavaScript
    "./core/templates/**/*.html", // Core app templates
    "./main_site/templates/**/*.html", // Main site app templates
    "./dashboard/templates/**/*.html", // Dashboard app templates
    "./credentialing_portal/templates/**/*.html", // Credentialing portal templates
  ],
  theme: {
    extend: {},
  },
  daisyui: {
    themes: ["light", "dark", "emerale", "corporate"],
  },
  plugins: [require("daisyui"), require("@tailwindcss/forms")],
};

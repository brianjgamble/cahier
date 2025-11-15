// Icons
export const ICONS = {
  light: "\u{2600}", // ☀
  dark: "\u{263E}", // ☾
};

// Apply saved theme from localStorage
export function applySavedTheme() {
  const saved = localStorage.getItem("theme");
  if (saved) {
    document.documentElement.setAttribute("data-theme", saved);
  }
}

// Update toggle button icon based on current theme
export function updateToggleIcon() {
  const btn = document.getElementById("theme-toggle");
  if (!btn) return;

  const mode = document.documentElement.getAttribute("data-theme") || "light";
  btn.textContent = ICONS[mode];
}

// Toggle between light and dark
export function toggleTheme() {
  const html = document.documentElement;
  const current = html.getAttribute("data-theme") || "light";
  const next = current === "light" ? "dark" : "light";

  html.setAttribute("data-theme", next);
  localStorage.setItem("theme", next);
  updateToggleIcon();
}

// Initialize button
export function initThemeToggle() {
  const toggle = document.getElementById("theme-toggle");
  if (!toggle) return;

  toggle.addEventListener("click", toggleTheme);
  updateToggleIcon(); // set initial icon
}

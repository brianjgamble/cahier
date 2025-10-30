const themeSwitcher = {
  // Config
  _scheme: "auto",
  targetId: "theme_switcher",
  rootAttribute: "data-theme",
  localStorageKey: "picoPreferredColorScheme",

  // Init
  init() {
    this.scheme = this.schemeFromLocalStorage;
    this.set_theme_icon(this.scheme);
    this.initSwitchers();
  },

  // Get color scheme from local storage
  get schemeFromLocalStorage() {
    return window.localStorage?.getItem(this.localStorageKey) ?? this._scheme;
  },

  // Preferred color scheme
  get preferredColorScheme() {
    return window.matchMedia("(prefers-color-scheme: dark)").matches
      ? "dark"
      : "light";
  },

  set_theme_icon(scheme) {
    let icon = scheme == "dark" ? "\u{263E}" : "\u{2600}";
    document.getElementById(this.targetId).textContent = icon;
  },

  // Init switchers
  initSwitchers() {
    document.getElementById(this.targetId).addEventListener(
      "click",
      (event) => {
        event.preventDefault();
        this.scheme = this.scheme == "dark" ? "light" : "dark";
        this.set_theme_icon(this.scheme);
      },
      false,
    );
  },

  // Set scheme
  set scheme(scheme) {
    if (scheme == "auto") {
      this._scheme = this.preferredColorScheme;
    } else if (scheme == "dark" || scheme == "light") {
      this._scheme = scheme;
    }
    this.applyScheme();
    this.schemeToLocalStorage();
  },

  // Get scheme
  get scheme() {
    return this._scheme;
  },

  // Apply scheme
  applyScheme() {
    document
      .querySelector("html")
      ?.setAttribute(this.rootAttribute, this.scheme);
  },

  // Store scheme to local storage
  schemeToLocalStorage() {
    window.localStorage?.setItem(this.localStorageKey, this.scheme);
  },
};

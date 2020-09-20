module.exports = {
  config: {
    // font family with optional fallbacks
    fontFamily: '"Fira Code", "Cascadia Code", "Fira Mono", monospace',
    fontSize: 12,

    // set to `true` if you're using a Linux set up
    // that doesn't shows native menus
    // default: `false` on Linux, `true` on Windows (ignored on macOS)
    showHamburgerMenu: true,

    // custom padding (CSS format, i.e.: `top right bottom left`)
    padding: "2px",

    // set to false for no bell
    bell: false,

    // if true, selected text will automatically be copied to the clipboard
    copyOnSelect: true,
  },
  plugins: ["hyper-dracula"],
};

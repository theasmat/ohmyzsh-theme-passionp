# ohmyzsh-theme-passionpp

## Introduction

An oh-my-zsh theme;

## Quick Install 

Run the following command in your terminal to automatically download the theme and set it as your default in `~/.zshrc`:

```sh
curl -fsSL https://raw.githubusercontent.com/theasmat/ohmyzsh-theme-passionp/master/passionp.zsh-theme -o ~/.oh-my-zsh/themes/passionp.zsh-theme && sed -i.bak 's/^ZSH_THEME=.*/ZSH_THEME="passionp"/' ~/.zshrc && exec zsh
```

### Feature

* command running error hint;
* git status prompt;

## Usage

### Basic Zsh Theme

#### Install

1. clone repo: ```git clone https://github.com/theasmat/ohmyzsh-theme-passionp```;
2. copy theme: ```cp ./ohmyzsh-theme-passionpp/passionp.zsh-theme ~/.oh-my-zsh/themes/passionp.zsh-theme```;
3. modify rc: open ```~/.zshrc``` find ```ZSH_THEME``` edit to ```ZSH_THEME="passionp"```;
4. execute rc: ```source ~/.zshrc```;

* see also: [Overriding and adding themes](https://github.com/ohmyzsh/ohmyzsh/wiki/Customization#overriding-and-adding-themes);

<details> <!-- markdownlint-disable-line -->
<summary><h3>Extra Preferences</h3></summary> <!-- markdownlint-disable-line -->

#### Zsh Plugins

1. [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions);
2. [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting);

#### iTerm2 Preferences

##### Color

<!-- cspell:disable-next-line -->
* iTerm2: settings -> Profiles -> Colors -> Color Presets -> import ```./passionp.itermcolors```
* alternate terminal: try [Alternate terminal installation and configuration](https://iterm2colorschemes.com/);

##### Status Bar

* iTerm2: settings -> Appearance && settings -> Profiles -> Session -> Configure Status Bar

##### Font

* install [JetBrains Mono](https://www.jetbrains.com/lp/mono/);
* iTerm2: settings -> Appearance && settings -> Profiles -> Text -> Font

</details> <!-- markdownlint-disable-line -->

## Credits

Original repository: https://github.com/ChesterYue/ohmyzsh-theme-passion (modified)

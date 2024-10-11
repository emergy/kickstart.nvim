# kickstart-modular.nvim

## Введение
*Это форк [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), который переводит конфигурацию из одного файла в многофайловую конфигурацию.*

Отправная точка для Neovim, которая:

* Маленькая
* Модульная
* Полностью документирована

**НЕ** дистрибутив Neovim, а стартовая точка для вашей конфигурации.

## Установка

### Установка Neovim

Kickstart.nvim предназначен *только* для последних версий
['stable'](https://github.com/neovim/neovim/releases/tag/stable) и
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) Neovim.
Если у вас возникли проблемы, убедитесь, что у вас установлены последние версии.

### Установка внешних зависимостей

Требования:

- Базовые утилиты: `git`, `make`, `unzip`, C-компилятор (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Инструмент для работы с буфером обмена (xclip/xsel/win32yank или другой в зависимости от платформы)
- [Nerd Font](https://www.nerdfonts.com/): опционально, предоставляет различные иконки
  - если он установлен, задайте `vim.g.have_nerd_font` в `init.lua` как true
- Настройка языков:
  - Для работы с TypeScript нужен `npm`
  - Для работы с Golang нужен `go`
  - и т.д.

> **ПРИМЕЧАНИЕ**
> См. [Рецепты установки](#Install-Recipes) для дополнительных заметок по установке для Windows и Linux
> и быстрых команд установки

### Установка Kickstart

> **ПРИМЕЧАНИЕ**
> [Создайте резервную копию](#FAQ) вашей предыдущей конфигурации (если она существует)

Конфигурации Neovim находятся по следующим путям в зависимости от вашей ОС:

| ОС | ПУТЬ |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%localappdata%\nvim\` |
| Windows (powershell)| `$env:LOCALAPPDATA\nvim\` |

#### Рекомендуемый шаг

[Форкните](https://docs.github.com/en/get-started/quickstart/fork-a-repo) этот репозиторий,
чтобы у вас была своя копия, которую можно модифицировать, затем установите её, клонировав
форк на ваш компьютер, используя одну из команд ниже в зависимости от вашей ОС.

> **ПРИМЕЧАНИЕ**
> URL вашего форка будет выглядеть так:
> `https://github.com/<ваш_пользователь_github>/kickstart-modular.nvim.git`

Рекомендуется также удалить `lazy-lock.json` из `.gitignore` вашего форка —
это игнорируется в репозитории kickstart для облегчения обслуживания, но
[рекомендуется отслеживать его в системе контроля версий](https://lazy.folke.io/usage/lockfile).

#### Клонирование kickstart.nvim
> **ПРИМЕЧАНИЕ**
> Если вы следуете рекомендуемому шагу выше (т.е., форкаете репозиторий), замените
> `dam9000` на `<ваш_пользователь_github>` в командах ниже

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/dam9000/kickstart-modular.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

Если вы используете `cmd.exe`:

```
git clone https://github.com/dam9000/kickstart.nvim.git "%localappdata%\nvim"
```

Если вы используете `powershell.exe`:

```
git clone https://github.com/dam9000/kickstart.nvim.git "${env:LOCALAPPDATA}\nvim"
```

</details>

### После установки

Запустите Neovim:

```sh
nvim
```

Это всё! Lazy установит все ваши плагины. Используйте `:Lazy`, чтобы увидеть
текущий статус плагинов. Нажмите `q`, чтобы закрыть окно.

Прочтите файл `init.lua` в папке вашей конфигурации, чтобы узнать больше о
расширении и настройке Neovim. Он также включает примеры добавления популярных плагинов.

### Начало работы

[Единственное видео, которое вам нужно для начала работы с Neovim](https://youtu.be/m8C0Cq9Uv9o)

### FAQ

* Что делать, если у меня уже есть существующая конфигурация neovim?
  * Сделайте резервную копию, а затем удалите все связанные файлы.
  * Это включает ваш существующий `init.lua` и файлы Neovim в `~/.local`,
    которые можно удалить с помощью `rm -rf ~/.local/share/nvim/`
* Могу ли я сохранить свою существующую конфигурацию параллельно с kickstart?
  * Да! Вы можете использовать [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`,
    чтобы поддерживать несколько конфигураций. Например, вы можете установить конфигурацию kickstart
    в `~/.config/nvim-kickstart` и создать алиас:
    ```bash
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    При запуске Neovim с помощью алиаса `nvim-kickstart`, он будет использовать альтернативную
    директорию конфигурации и соответствующую локальную директорию
    `~/.local/share/nvim-kickstart`. Вы можете применить этот подход к любой конфигурации Neovim,
    которую хотите попробовать.
* Что делать, если я хочу "удалить" эту конфигурацию:
  * См. информацию об [удалении lazy.nvim](https://lazy.folke.io/usage#-uninstalling)
* Почему kickstart `init.lua` представляет собой один файл? Не лучше ли разбить его на несколько файлов?
  * Основная цель kickstart — быть учебным пособием и эталонной конфигурацией,
    которую можно легко использовать как основу для своей собственной через `git clone`.
    По мере изучения Neovim и Lua, вы можете рассмотреть возможность разбивки `init.lua`
    на более мелкие части. Форк kickstart, который делает это, сохраняя
    ту же функциональность, доступен здесь:
    * [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
  * *ПРИМЕЧАНИЕ: Это форк, который разбивает конфигурацию на более мелкие части.*
    Оригинальный репозиторий с единственным файлом `init.lua` доступен здесь:
    * [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
  * Обсуждения по этой теме можно найти здесь:
    * [Реструктуризация конфигурации](https://github.com/nvim-lua/kickstart.nvim/issues/218)
    * [Реорганизация init.lua в многофайловую структуру](https://github.com/nvim-lua/kickstart.nvim/pull/473)

### Рецепты установки

Ниже приведены инструкции по установке для конкретных ОС для Neovim и зависимостей.

После установки всех зависимостей продолжите шагом [Установка Kickstart](#Install-Kickstart).

#### Установка на Windows

<details><summary>Windows с Microsoft C++ Build Tools и CMake:</summary>

Установка может потребовать установки инструментов сборки и обновления команды запуска для `telescope-fzf-native`.

См. документацию по `telescope-fzf-native` для [подробностей](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

Для этого требуется:

- Установить CMake и Microsoft C++ Build Tools на Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```
</details>
<details><summary>Windows с gcc/make через chocolatey:</summary>

Альтернативно можно установить gcc и make, что не требует изменения конфигурации. Проще всего сделать это с помощью choco:

1. установите [chocolatey](https://chocolatey.org/install), следуя инструкциям на сайте или используя winget. Запустите в cmd от **администратора**:
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. установите все необходимые компоненты через choco, закройте предыдущий cmd и откройте новый, чтобы путь choco был установлен. Затем запустите в cmd от **администратора**:
```bash
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```
</details>
<details><summary>WSL (Подсистема Windows для Linux):</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>

#### Установка на Linux
<details><summary>Шаги установки для Ubuntu:</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>
<details><summary>Шаги установки для Debian:</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Теперь устанавливаем nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim-linux64
sudo mkdir -p /opt/nvim-linux64
sudo chmod a+rX /opt/nvim-linux64
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# делаем доступным в /usr/local/bin, дистрибутив устанавливает в /usr/bin
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/
```
</details>
<details><summary>Шаги установки для Fedora:</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
```
</details>

<details><summary>Шаги установки для Arch:</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```
</details>


# Windows specific stuff

## WSL

Simply run to get started

```powershell
wsl --install
```

## VS code font setting

If you want to install custom fonts you have installed on you Windows machine then you may need to do something like this to get WSL VS code to pic them up

```bash
mkdir -p ~/.local/share/fonts

cp /mnt/c/Users/MG/AppData/Local/Microsoft/Windows/Fonts/ComicCode*.otf ~/.local/share/fonts/ 2>/dev/null || true
cp /mnt/c/Users/MG/AppData/Local/Microsoft/Windows/Fonts/ComicCode*.ttf ~/.local/share/fonts/ 2>/dev/null || true

fc-cache -fv
```

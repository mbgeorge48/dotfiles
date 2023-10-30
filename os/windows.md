# Windows specific stuff

## Chocolatey

You can probably just follow [the proper guide](https://chocolatey.org/install) for more up to date steps, but anyway...

Run these to allow Chocolatey to install and manage software

```powershell
Set-ExecutionPolicy AllSigned
```

Run this to do the installing

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Run `choco -?` to make sure it all work properly

Go check out `chocolatey/Chocolateyfile` to get a list of installables

## WSL

Simply run to get started

```powershell
wsl --install
```

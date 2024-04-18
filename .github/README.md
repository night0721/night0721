# Hi, I'm Night

**Developer, Linux and FOSS enthusiast from Hong Kong**  

- Youtube: <https://www.youtube.com/@night0721>
- Website: <https://night0721.xyz>
- Email: <night@night0721.xyz> ([PGP Key](https://night0721.xyz/pub.gpg))

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/I2I35XISJ) [![Visitors](https://visitor-badge.laobi.icu/badge?page_id=night0721)]()

![Metrics](https://gist.githubusercontent.com/night0721/776e9d33accd140dca02d9a9f0e05994/raw/5f65cfcf3b32670e3deffa61931f8854ea86c970/metrics.svg)

<!-- https://github.com/catppuccin/github-readme-stats -->
[![Wakatime](https://gh-md-stats.vercel.app/api/wakatime?username=night0721&border_radius=20px&bg_color=1e1e2e&text_color=cdd6f4&icon_color=cba6f7&title_color=89b4fa&border_color=cba6f7&show_icons=true&disable_animations=true&custom_title=Coding%20Stats&langs_count=50&layout=compact&hide=other,ini,git,git%20config,text,textmate,batch,mixin%20configuration,gitignore%20file,tsconfig,properties,d,image%20(png),inittab,desktop,sshdconfig,gdscript,gdscript3,mdx,image%20(jpeg),actionscript,ssh%20key,xml,conf,netrw,prolog,ezhil,toml,tsql,sh,gitignore,jsonc,zip,gitconfig,zsh,dosini,MiniScript,kitty,sshconfig,Ignore%20List,tmux,diff,modconf,fstab,Org,pdf,Bash,nginx%20configuration%20file,scdoc,vifm,tar,gpg)]()

```
  Language  Files   Code  Comment  Blank  Total  
     Total    543  34555     2658   3003  39694  
JavaScript    153  11125      897    353  12196  
      Java    165   7974      203   1000   9121  
         C     34   5237      557    646   6277  
TypeScript     91   3769      220    169   4104  
       CSS     13   1691       20    213   1922  
    Kotlin     24   1606       68    183   1849  
    Python     11   1401       34    146   1579  
  C Header     19    895      643    182   1664  
      HTML     21    481        7     33    521  
  Makefile     10    215        9     69    291  
       Lua      2    161        0      9    170 
```

## Catppuccin themed dotfiles for Alpine Linux

#### Specifications
- OS: Alpine Linux
- WM: dwl
- Notifications: mako
- Terminal: foot
- Shell: sh
- AUR Helper: aureate
- Wallpaper daemon: wbg
- Wallpapers: [catppuccin](https://github.com/iQuickDev/catppuccin-wallpapers)
- File Manager: lf, ccc
- Search menu: fnf, wmenu
- Browser: firefox
- Font: Monaspice Kr Nerd Font
- Bootloader: grub

### Details

1. Grub theme: `.data/grub/n` (Based on [sayonara](https://github.com/samoht9277/dotfiles/tree/master/grub/themes/sayonara))
2. File Manager: lf
- Using [lfimg-sixel](https://github.com/Anima-OS-Dev/lfimg-sixel) to support sixel in lf with foot
- graphicsmagick for SVG and GIF preview
- [Fontpreview](https://github.com/sdushantha/fontpreview) for OTF TTF WOFF preview
- Required packages: imagemagick chafa ydotool fzf
3. VM
- Packages: bridge-utils libvirt qemu-full virt-manager virt-viewer  

### Dual booting
Windws partition in fstab should have these properties
```
UUID=94ACAFD1ACAFAC64   /run/media/N    ntfs        rw,user,auto,fmask=133,dmask=022,uid=1000,gid=1000  0 0
```

### Install
```
iwctl
device list # find device name
station [device name] connect [network name]
exit
pacman -Sy git
git clone https://github.com/night0721/night0721
bash night0721/.data/root.sh
```

## Post setup
```
git clone --bare git@codeberg.org:night0721/night0721
```
Credits to [this tutorial](https://www.atlassian.com/git/tutorials/dotfiles)

### Firefox

Go to about:profiles and create a new profile with custom folder  
cd into the folder and create user.js  
Copy [betterfox](https://raw.githubusercontent.com/yokoffing/Betterfox/main/user.js) into user.js   
Restart firefox  
Then follow https://github.com/catppuccin/userstyles/ to install stylus  
Downloading [codeberg](https://github.com/catppuccin/userstyles/tree/main/styles/codeberg) and [github](https://github.com/catppuccin/userstyles/tree/main/styles/github) css themes selecting mocha and lavender.  

## Default Keybinds

SUPER + S = Start Terminal  
SUPER + F = Start Firefox  
SUPER + C = Kill Active Window  
SUPER + L = Lock Screen  
SUPER + M = Power menu  
SUPER + [1-9] = Switch to tags  
SUPER + SHIFT + [1-9] = Move active window to tag  
SUPER + SHIFT + Q = Quit to tty  
SUPER + O = Increase opacity  
SUPER + SHIFT + O = Decrease opacity  
SUPER + B = Toggle bar  
SUPER + AD = Switch focus to window  
SUPER + QE = Change window size  
SUPER + [,.] = Focus next/previous monitor
SUPER + SHIFT + [,.] = Move window to next/previous monitor
SUPER + SHIFT + SPACE = Toggle floating  
SUPER + ENTER = Toggle focus  
SUPER + P = Password menu  
SUPER + SPACE = App Launcher  
SUPER + SHIFT + S = Screenshot menu  

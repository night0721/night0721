# Hi, I'm Night

**Developer, Linux and FOSS enthusiast from Hong Kong**  

- Youtube: <https://www.youtube.com/@night0721>
- Website: <https://night0721.xyz>
- Email: <night@night0721.xyz> ([PGP Key](https://night0721.xyz/pub.gpg))

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/I2I35XISJ) [![Visitors](https://visitor-badge.laobi.icu/badge?page_id=night0721)]()

[![Stats](https://gh-md-stats.vercel.app/api?username=night0721&bg_color=1e1e2e&text_color=cdd6f4&icon_color=cba6f7&title_color=89b4fa&border_color=cba6f7&count_private=true&show_icons=true&include_all_commits=true&number_format=long&show=prs_merged&disable_animations=true&custom_title=Github%20Stats&rank_icon=github)]()
<!-- https://github.com/catppuccin/github-readme-stats -->
[![Wakatime](https://gh-md-stats.vercel.app/api/wakatime?username=night0721&border_radius=20px&bg_color=1e1e2e&text_color=cdd6f4&icon_color=cba6f7&title_color=89b4fa&border_color=cba6f7&show_icons=true&disable_animations=true&custom_title=Coding%20Stats&langs_count=50&layout=compact&hide=other,ini,git,git%20config,text,textmate,batch,mixin%20configuration,gitignore%20file,tsconfig,properties,d,image%20(png),inittab,desktop,sshdconfig,gdscript,gdscript3,mdx,image%20(jpeg),actionscript,ssh%20key,xml,conf,netrw,prolog,ezhil,toml,tsql,sh,gitignore,jsonc,zip,gitconfig,zsh,dosini,MiniScript,kitty,sshconfig,Ignore%20List,tmux,diff,modconf,fstab,Org,pdf,Bash,nginx%20configuration%20file,scdoc,vifm,tar)]()

```
  Language  Files   Code  Comment  Blank  Total  
     Total    536  33375     2178   2797  37847  
JavaScript    153  11125      897    353  12196  
      Java    165   7974      203   1000   9121  
         C     32   4879      507    558   5785  
TypeScript     91   3769      220    169   4104  
       CSS     13   1691       20    213   1922  
    Kotlin     24   1606       68    183   1849  
    Python      9   1349       34    146   1527  
      HTML     23    513        7     36    556  
  C Header     16    243      212     67    482  
  Makefile     10    226       10     72    305  
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

2. Login: SDDM(Remvoed, logging in with tty)
- Theme: [aerial](https://github.com/3ximus/aerial-sddm-theme)
- Packages: gst-libav phonon-qt5-gstreamer gst-plugins-good qt5-quickcontrols qt5-graphicaleffects qt5-multimedia

3. Shell: zsh (Removed, using sh)
- Theme: `.config/deprecated/zsh/n.zsh-theme`
- Plugins: zsh-autosuggestions, zsh-history-substring-search, zsh-syntax-highlighting

4. File Manager: lf
- Using [lfimg-sixel](https://github.com/Anima-OS-Dev/lfimg-sixel) to support sixel in lf with foot
- graphicsmagick for SVG and GIF preview
- [Fontpreview](https://github.com/sdushantha/fontpreview) for OTF TTF WOFF preview
- Required packages: imagemagick chafa ydotool fzf

6. VM
- Packages: bridge-utils libvirt qemu-full virt-manager virt-viewer  

### Additional Information

You might need to install `grub-customizer` to remove other boot options, if syntax error occured, most likely a `:` will solve the problem

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
git clone https://github.com/night0721/dotfiles
bash dotfiles/.data/root.sh
```

## Post setup
```
git clone --bare git@codeberg.org:night0721/dotfiles
connmanctl scan wifi
connmanctl services
connmanctl connect wifi_...........
sudo pacman -Syu
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

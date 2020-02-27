# Stone Termux管理工具 (Stone-Termux-Tool)
## 简介
Stone Termux管理工具 是一款帮助你快速完成Termux的常用设置、管理和常用软件安装的便捷工具。
它可以帮助你快速完成Termux的初始配置和日常管理，支持多种常用工具一键安装配置，图形界面管理和在线更新。

![pictur1](https://gitee.com/st1020/Stone-Termux-Tool/raw/master/pic/1.jpg)

![pictur2](https://gitee.com/st1020/Stone-Termux-Tool/raw/master/pic/2.jpg)

![pictur3](https://gitee.com/st1020/Stone-Termux-Tool/raw/master/pic/3.jpg)

![pictur4](https://gitee.com/st1020/Stone-Termux-Tool/raw/master/pic/4.jpg)

![pictur5](https://gitee.com/st1020/Stone-Termux-Tool/raw/master/pic/5.jpg)

## 安装
你可以直接在Termux内输入以下命令安装本工具：
```shell
pkg i -y wget && bash -c "$(wget -qO- 'https://github.com/st1020/Stone-Termux-Tool/raw/master/st.sh')"
```
或者：
```shell
pkg i -y wget && bash -c "$(wget -qO- 'https://gitee.com/st1020/Stone-Termux-Tool/raw/master/st.sh')"
```
如果你要把它安装到你的Termux系统中，请使用工具内的“安装本工具到Termux系统”功能，这样，以后你就可以使用st命令直接启动本工具了。

## 使用

> 如果你在中国大陆地区，建议先选择“切换为清华源”，以加快其他软件的下载速度。

软件的操作较为简单，你可以直接按照提示进行操作。

本工具支持以下下参数：

> Usage: st [命令] [参数]
>  命令：
>  无        直接进入本工具
>  gui       进入本工具的GUI模式
>  install   安装本工具到Termux系统中
>  remove    删除本工具
>  update    更新本工具
>  help      显示帮助
> 当选择 install 命令时，可以指定一个参数，表示安装后运行本程序的命令，如不指定，默认为st。

本软件部分功能引用了其他github上的项目，在中国大陆地区访问速度可能不佳，请自行解决。

## 更新日志

**v1.0 2020.2.26**
第一次更新

**v1.0.1 2020.2.27**
修复“安装到系统”功能的bug

## 致谢

感谢 [Moe/Termux-Debian项目](https://gitee.com/mo2/Termux-Debian) 本工具的“备份与还原”部分的代码参考了此项目。

### 感谢使用！

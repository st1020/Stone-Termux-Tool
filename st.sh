#!/data/data/com.termux/files/usr/bin/bash

#更新地址
update="https://gitee.com/st1020/Stone-Termux-Tool/raw/master/st.sh"
#update="https://github.com/st1020/Stone-Termux-Tool/raw/master/st.sh"

function check() {
	#检测依赖
	if [ ! -e /data/data/com.termux/files/usr/bin/whiptail ]; then
		echo "检测到未安装whiptail，正在安装..."
		apt update
		apt install -y dialog
	fi
}

function main() {
	#主函数
	cd ~ > /dev/null
	if [ $gui == true ]; then
		OPTION=$(whiptail --title "Stone Termux管理工具" --menu "当前菜单下共有13个选项，请使用方向键进行选择，按回车键确认。" 15 50 4 \
			"1" "切换为清华源" \
			"2" "安装Oh-My-Zsh" \
			"3" "一键安装基础工具" \
			"4" "Termux设置" \
			"5" "配置开发环境" \
			"6" "安装常用工具" \
			"7" "安装常用信息安全工具" \
			"8" "Linux常见彩蛋" \
			"9" "备份与恢复" \
			"10" "查询空间占用" \
			"11" ${install_menu} \
			"12" "更新本管理工具" \
			"0" "退出" \
			3>&1 1>&2 2>&3)
	else
		echo -e "\n\n\n\n\n"
		echo -e "     Stone Termux管理工具\n\n"
		echo -e "   1   切换为清华源\n"
		echo -e "   2   安装Oh-My-Zsh\n"
		echo -e "   3   一键安装基础工具\n"
		echo -e "   4   Termux设置\n"
		echo -e "   5   配置开发环境\n"
		echo -e "   6   安装常用工具\n"
		echo -e "   7   安装常用信息安全工具\n"
		echo -e "   8   Linux常见彩蛋\n"
		echo -e "   9   备份与恢复\n"
		echo -e "   10  查询空间占用\n"
		echo -e "   11  ${install_menu}\n"
		echo -e "   12  更新本管理工具\n"
		echo -e "   0   退出\n"
		read -p '请输入序号：' OPTION;
	fi
	####################################
	if [ "${OPTION}" == '1' ]; then
		echo "正在将Termux源设置为由清华TUNA提供的镜像源..."
		sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux stable main@' $PREFIX/etc/apt/sources.list
		apt update && apt upgrade -y
		echo "更新完成！"
	elif [ "${OPTION}" == '2' ]; then
		echo "请注意：Oh-My -Zsh 使用 Termux 官方源，在中国大陆可能需要将 Termux 应用添加到代理列表。"
		read -p "请按任意键继续..." -n 1 press
		echo "正在安装Oh-My-Zsh..."
		apt update
		apt install curl -y >/dev/null
		sh -c "$(curl -fsSL https://github.com/Cabbagec/termux-ohmyzsh/raw/master/install.sh)"
		read -p "安装完成！请重新启动Termux..." -n 1 press
		exit
	elif [ "${OPTION}" == '3' ]; then
		echo "正在安装 vim curl wget git unzip unrar zip nano tar git pv..."
		apt update
		apt install -y vim curl wget git unzip unrar zip nano tar git pv
		echo "安装完成！"
	elif [ "${OPTION}" == '4' ]; then
		termux
	elif [ "${OPTION}" == '5' ]; then
		development
	elif [ "${OPTION}" == '6' ]; then
		tools
	elif [ "${OPTION}" == '7' ]; then
		security
	elif [ "${OPTION}" == '8' ]; then
		eggs
	elif [ "${OPTION}" == '9' ]; then
		backup
	elif [ "${OPTION}" == '10' ]; then
		SpaceOccupation
	elif [ "${OPTION}" == '11' ]; then
		if [ $installed == true ]; then
			remove
		else
			install "st"
		fi
	elif [ "${OPTION}" == '12' ]; then
		update
	elif [ "${OPTION}" == '0' ]; then
		exit
	else
		echo "输入错误！"
	fi
	read -p "请按任意键继续..." -n 1 press
	main
}

function termux() {
	cd ~ > /dev/null
	if [ $gui == true ]; then
		OPTION=$(whiptail --title "Stone Termux管理工具 - Termux设置" --menu "当前菜单下共有13个选项，请使用方向键进行选择，按回车键确认。" 15 50 4 \
			"0" "返回主菜单" \
			"1" "优化Termux辅助键盘" \
			"2" "获取读写内部储存权限" \
			"3" "获取设备信息" \
			"4" "阻止CPU休眠" \
			"5" "允许CPU休眠" \
			"6" "修复Termux系统文件的Shebang" \
			"7" "重新加载Termux设置" \
			"8" "修改启动问候语" \
			"9" "修改启动时运行的命令" \
			"9" "启用不稳定软件源" \
			"10" "启用Root工具源" \
			"11" "启用X11源" \
			"12" "安装termux-api" \
			3>&1 1>&2 2>&3)
	else
		echo -e "\n\n\n\n\n"
		echo -e "     Stone Termux管理工具\n\n"
		echo -e "   0   返回主菜单\n"
		echo -e "   1   优化Termux辅助键盘\n"
		echo -e "   2   获取读写内部储存权限\n"
		echo -e "   3   获取设备信息\n"
		echo -e "   4   阻止CPU休眠\n"
		echo -e "   5   允许CPU休眠\n"
		echo -e "   6   修复Termux系统文件的Shebang\n"
		echo -e "   7   重新加载Termux设置\n"
		echo -e "   8   修改启动问候语\n"
		echo -e "   9   修改启动时运行的命令\n"
		echo -e "   9   启用不稳定软件源\n"
		echo -e "   10  启用Root工具源\n"
		echo -e "   11  启用X11源\n"
		echo -e "   12  安装termux-api\n"
		read -p '请输入序号：' OPTION;
	fi
	####################################
	if [ "${OPTION}" == '1' ]; then
		mkdir /data/data/com.termux/files/home/.termux
		echo "extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]" >> /data/data/com.termux/files/home/.termux/termux.properties
		termux-reload-settings
		read -p "配置完成！" -n 1 press
		exit
	elif [ "${OPTION}" == '2' ]; then
		termux-setup-storage
		echo "执行完成！"
	elif [ "${OPTION}" == '3' ]; then
		termux-info
		echo "执行完成！"
	elif [ "${OPTION}" == '4' ]; then
		termux-wake-lock
		echo "执行完成！"
	elif [ "${OPTION}" == '5' ]; then
		termux-wake-unlock
		echo "执行完成！"
	elif [ "${OPTION}" == '6' ]; then
		termux-fix-shebang
		echo "执行完成！"
	elif [ "${OPTION}" == '7' ]; then
		termux-reload-settings
		echo "执行完成！"
	elif [ "${OPTION}" == '8' ]; then
		read -p "将使用nano修改启动问候语，修改完成后请Ctrl+x退出。按任意键继续..." -n 1 press
		nano $PREFIX/etc/motd
		echo "执行完成！"
	elif [ "${OPTION}" == '9' ]; then
		#变量${SHELL##*/}表示将全局变量SHELL以/分割，从右向左数第一个部分
		echo "检测到你的默认Shell为${SHELL##*/}"
		#不区分大小写判断
		if [ "${SHELL##*/}" == 'bash' ]; then 
			read -p "将使用nano编辑.bashrc文件，修改完成请Ctrl+x退出。按任意键继续..." -n 1 press
			nano ~/.bashrc
		elif [ "${SHELL##*/}" == 'zsh' ]; then 
			read -p "将使用nano编辑.zshrc文件，修改完成请Ctrl+x退出。按任意键继续..." -n 1 press
			nano ~/.zshrc
		elif [ "${SHELL##*/}" == 'fish' ]; then 
			read -p "将使用nano编辑config.fish文件，修改完成请Ctrl+x退出。按任意键继续..." -n 1 press
			mkdir ~/.config/fish
			nano ~/.config/fish/config.fish
		else
			read -p "未知的Shell类型，请手动输入你的Shell的初始化文件位置：" rc
			read -p "将使用nano编辑$rc文件，修改完成请Ctrl+x退出。按任意键继续..." -n 1 press
			nano $rc
		fi
		echo "执行完成！"
	elif [ "${OPTION}" == '9' ]; then
		pkg install unstable-repo
		echo "执行完成！"
	elif [ "${OPTION}" == '10' ]; then
		pkg install root-repo
		echo "执行完成！"
	elif [ "${OPTION}" == '11' ]; then
		pkg install x11-repo
		echo "执行完成！"
	elif [ "${OPTION}" == '12' ]; then
		pkg install termux-api
		echo "执行完成！"
	elif [ "${OPTION}" == '0' ]; then
		main
	else
		echo "输入错误！"
	fi
	read -p "请按任意键继续..." -n 1 press
	termux
}

function development() {
	cd ~ > /dev/null
	if [ $gui == true ]; then
		OPTION=$(whiptail --title "Stone Termux管理工具 - 搭建开发环境" --menu "当前菜单下共有9个选项，请使用方向键进行选择，按回车键确认。" 15 50 4 \
			"0" "返回主菜单" \
			"1" "安装Vim插件" \
			"2" "搭建Python开发环境" \
			"3" "搭建C/C++开发环境" \
			"4" "安装Node.js JavaScript运行环境" \
			"5" "安装MariaDB 数据库管理系统" \
			"6" "搭建PHP 开发环境" \
			"7" "搭建Go 开发环境" \
			"8" "搭建JAVA 开发环境" \
			3>&1 1>&2 2>&3)
	else
		echo -e "\n\n\n\n\n"
		echo -e "     Stone Termux管理工具\n\n"
		echo -e "   0   返回主菜单\n"
		echo -e "   1   安装Vim插件\n"
		echo -e "   2   搭建Python开发环境\n"
		echo -e "   3   搭建C/C++开发环境\n"
		echo -e "   4   安装Node.js JavaScript运行环境\n"
		echo -e "   5   安装MariaDB 数据库管理系统\n"
		echo -e "   6   搭建PHP 开发环境\n"
		echo -e "   7   搭建Go 开发环境\n"
		echo -e "   8   搭建JAVA 开发环境\n"
		read -p '请输入序号：' OPTION;
	fi
	####################################
	if [ "${OPTION}" == '1' ]; then
		echo "正在安装vim..."
		apt update
		apt install -y vim
		#安装vim-python
		while true
		do
			read -p "你要安装vim-python（Vim的Python插件）吗？ [Y/n] " input
			case $input in
				[yY][eE][sS]|[yY])
					echo "正在安装vim-python..."
					apt install -y vim-python
					break;;
				[nN][oO]|[nN])
					break;;
				*)
					echo "输入错误，请重新输入...";;
			esac
		done
		
		#安装SpaceVim
		while true
		do
			read -p "你要安装SpaceVim（模块化的 Vim IDE）吗？ [Y/n] " input
			case $input in
				[yY][eE][sS]|[yY])
					echo "正在安装SpaceVim..."
					curl -sLf https://spacevim.org/cn/install.sh | bash
					break;;
				[nN][oO]|[nN])
					break;;
				*)
					echo "输入错误，请重新输入...";;
			esac
		done
		echo "Vim插件安装完成..."
	elif [ "${OPTION}" == '2' ]; then
		echo "正在安装Python..."
		apt update
		apt install -y python
		#换pip源，更新pip
		while true
		do
			read -p "你要切换Pypi源为清华源吗？ [Y/n] " input
			case $input in
				[yY][eE][sS]|[yY])
					echo "正在更新pip..."
					pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U
					pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
					break;;
				[nN][oO]|[nN])
					echo "正在更新pip..."
					pip install pip -U
					break;;
				*)
					echo "输入错误，请重新输入...";;
			esac
		done
		
		#安装vim-python
		while true
		do
			read -p "你要安装vim-python（Vim的Python插件）吗？ [Y/n] " input
			case $input in
				[yY][eE][sS]|[yY])
					echo "正在安装vim-python..."
					apt install -y vim
					apt install -y vim-python
					break;;
				[nN][oO]|[nN])
					break;;
				*)
					echo "输入错误，请重新输入...";;
			esac
		done
		
		#安装IPython
		while true
		do
			read -p "你要安装IPython吗？ [Y/n] " input
			case $input in
				[yY][eE][sS]|[yY])
					echo "正在安装IPython..."
					apt install -y clang
					pip install ipython
					break;;
				[nN][oO]|[nN])
					break;;
				*)
					echo "输入错误，请重新输入...";;
			esac
		done
		
		#安装Jupyter
		while true
		do
			read -p "你要安装Jupyter吗？ [Y/n] " input
			case $input in
				[yY][eE][sS]|[yY])
					echo "正在安装Jupyter..."
					apt install -y clang libzmq
					pip install jupyter
					break;;
				[nN][oO]|[nN])
					break;;
				*)
					echo "输入错误，请重新输入...";;
			esac
		done
		echo "Python开发环境安装完成..."
		
	elif [ "${OPTION}" == '3' ]; then
		echo "正在安装clang..."
		apt update
		apt install -y clang
		echo "正在安装make..."
		apt install -y make
		echo "正在安装build-essential..."
		apt install  -y build-essential
		echo "正在安装GDB..."
		apt install -y gdb
		echo "正在安装Vim..."
		apt install -y vim
		echo "C/C++开发环境安装完成..."
		
	elif [ "${OPTION}" == '4' ]; then
		echo "正在安装Node.js..."
		pkg install -y nodejs
		while true
		do
			read -p "你要切换NPM源为淘宝源吗？ [Y/n] " input
			case $input in
				[yY][eE][sS]|[yY])
					echo "正在更新NPM..."
					npm config set registry http://registry.npm.taobao.org/
					npm install -g npm
					break;;
				[nN][oO]|[nN])
					echo "正在更新NPM..."
					npm install -g npm
					break;;
				*)
					echo "输入错误，请重新输入...";;
			esac
		done
		echo "Node.js安装完成..."
	
	elif [ "${OPTION}" == '5' ]; then
		pkg install -y mariadb
		echo "正在安装基本数据..."
		mysql_install_db
		echo "安装完成！"
		
	elif [ "${OPTION}" == '6' ]; then
		pkg install -y php
		while true
		do
			read -p "你要安装MariaDB吗？ [Y/n] " input
			case $input in
				[yY][eE][sS]|[yY])
					echo "正在安装MariaDB..."
					pkg install -y mariadb
					echo "正在安装基本数据..."
					mysql_install_db
					break;;
				[nN][oO]|[nN])
					break;;
				*)
					echo "输入错误，请重新输入...";;
			esac
		done
		echo "PHP开发环境安装完成..."
		
	elif [ "${OPTION}" == '7' ]; then
		echo "正在安装golang..."
		pkg install -y golang
		echo "正在安装golang-doc..."
		pkg install -y golang-doc
		echo "Go开发环境安装完成..."
		
	elif [ "${OPTION}" == '8' ]; then
		echo "根据Termux官方说明，Termux不支持安装JAVA开发环境！"
		echo "如果您要使用JAVA开发环境，请使用 安装常用工具 - Atilo 或其他方式安装一个GNU/Linux系统镜像，再自行搭建JAVA开发环境。"
		
	elif [ "${OPTION}" == '0' ]; then
		main
	else
		echo "输入错误！"
	fi
	read -p "请按任意键继续..." -n 1 press
	development
}

function tools() {
	cd ~ > /dev/null
	if [ $gui == true ]; then
		OPTION=$(whiptail --title "Stone Termux管理工具 - 安装常用工具" --menu "当前菜单下共有16个选项，请使用方向键进行选择，按回车键确认。" 15 50 4 \
			"0" "返回主菜单" \
			"1" "安装Nginx 服务器" \
			"2" "安装Apache2 服务器" \
			"3" "安装Tmux 终端复用软件" \
			"4" "安装Hexo 博客框架" \
			"5" "安装OpenSSH SSH连接工具" \
			"6" "安装Aria2 下载工具" \
			"7" "安装You-Get 视频下载工具" \
			"8" "安装BaiduPCS-Go 百度网盘管理工具" \
			"9" "安装Atilo Linux安装脚本" \
			"10" "安装UnblockNeteaseMusic 工具" \
			"11" "安装KodExplorer 可道云" \
			"12" "安装ELinks 纯文本浏览器" \
			"13" "安装MPV 播放器" \
			"14" "安装ADB Android Debug Bridge" \
			"15" "安装BiliHelper B站直播脚本" \
			3>&1 1>&2 2>&3)
	else
		echo -e "\n\n\n\n\n"
		echo -e "     Stone Termux管理工具\n\n"
		echo -e "   0   返回主菜单\n"
		echo -e "   1   安装Nginx 服务器\n"
		echo -e "   2   安装Apache2 服务器\n"
		echo -e "   3   安装Tmux 终端复用软件\n"
		echo -e "   4   安装Hexo 博客框架\n"
		echo -e "   5   安装OpenSSH SSH连接工具\n"
		echo -e "   6   安装Aria2 下载工具\n"
		echo -e "   7   安装You-Get 视频下载工具\n"
		echo -e "   8   安装BaiduPCS-Go 百度网盘管理工具\n"
		echo -e "   9   安装Atilo Linux安装脚本\n"
		echo -e "   10  安装UnblockNeteaseMusic 工具\n"
		echo -e "   11  安装KodExplorer 可道云\n"
		echo -e "   12  安装ELinks 纯文本浏览器\n"
		echo -e "   13  安装MPV 播放器\n"
		echo -e "   14  安装ADB Android Debug Bridge\n"
		echo -e "   15  安装BiliHelper B站直播脚本\n"
		read -p '请输入序号：' OPTION;
	fi
	####################################
	if [ "${OPTION}" == '1' ]; then
		pkg install -y nginx
		echo "安装完成！"
	elif [ "${OPTION}" == '2' ]; then
		pkg install -y apache2
		echo "安装完成！"
	elif [ "${OPTION}" == '3' ]; then
		pkg install -y tmux
		echo "安装完成！"
	elif [ "${OPTION}" == '4' ]; then
		pkg install -y git nodejs
		npm install -g hexo-cli
		echo "安装完成！"
	elif [ "${OPTION}" == '5' ]; then
		pkg install -y openssh
		echo "安装完成！"
	elif [ "${OPTION}" == '6' ]; then
		pkg install -y aria2
		#安装Aria2 Web 管理工具
		while true
		do
			read -p "你要安装AriaNg（Aria2的Web管理工具）吗？ [Y/n] " input
			case $input in
				[yY][eE][sS]|[yY])
					AriaNg
					break;;
				[nN][oO]|[nN])
					break;;
				*)
					echo "输入错误，请重新输入...";;
			esac
		done
		
	elif [ "${OPTION}" == '7' ]; then
		pkg install -y python ffmpeg
		pip install you-get
		echo "安装完成！"
	elif [ "${OPTION}" == '8' ]; then
		echo "deb [trusted=yes] http://termux.iikira.com stable main" >> /data/data/com.termux/files/usr/etc/apt/sources.list
		pkg install -y baidupcs-go
		echo "安装完成！"
	elif [ "${OPTION}" == '9' ]; then
	echo "deb [trusted=yes] https://yadominjinta.github.io/files/ termux extras" >> $PREFIX/etc/apt/sources.list
		pkg install -y atilo-cn
		echo "安装完成！"
	elif [ "${OPTION}" == '10' ]; then
		pkg install -y nodejs
		echo "正在更新NPM..."
		npm install -g npm
		npm install -g @nondanee/unblockneteasemusic
		echo "安装完成！"
	elif [ "${OPTION}" == '11' ]; then
		echo "正在安装依赖..."
		pkg install -y git
		echo "正在从Gitee克隆KodExplorer..."
		git clone https://gitee.com/kalcaddle/KODExplorer.git
		chmod -Rf 777 ./KODExplorer/*
		echo -e "cd ~/KODExplorer\nphp -S 127.0.0.1:8080 -t ." > /data/data/com.termux/files/usr/bin/startkod
		chmod +x /data/data/com.termux/files/usr/bin/startkod
		echo "安装完成！请使用 startkod 命令启动可道云服务，Ctrl+C关闭。"
	elif [ "${OPTION}" == '12' ]; then
		pkg install -y elinks
		echo "安装完成！"
	elif [ "${OPTION}" == '13' ]; then
		pkg install -y mpv
		echo "安装完成！"
	elif [ "${OPTION}" == '14' ]; then
		echo "将要从Magisk模块仓库克隆ADB-NDK模块..."
		git clone https://github.com/Magisk-Modules-Repo/adb-ndk.git
		cd adb-ndk/bin
		mv -f adb.bin adb
		chmod +x ./*
		mv -f ./* $PREFIX/bin
		rm -rf ~/adb-ndk
		echo "安装完成！"
		adb version
	elif [ "${OPTION}" == '15' ]; then
		git clone https://github.com/lkeme/BiliHelper-personal.git
		echo "正在安装依赖..."
		pkg install -y php
		#php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
		#使用国内镜像下载composer
		php -r "readfile('https://install.phpcomposer.com/installer');" | php
		mv -f ~/composer.phar ~/BiliHelper-personal/
		cd ~/BiliHelper-personal/
		#配置阿里云composer镜像
		php composer.phar config -g repo.packagist composer https://mirrors.aliyun.com/composer/
		#使用composer安装依赖
		php composer.phar install
		#复制配置文件
		cp ~/BiliHelper-personal/conf/user.conf.example ~/BiliHelper-personal/conf/user.conf
		echo "php ~/BiliHelper-personal/index.php" > /data/data/com.termux/files/usr/bin/bilihelper
		chmod +x /data/data/com.termux/files/usr/bin/bilihelper
		echo "安装完成！请使用 nano ~/BiliHelper-personal/conf/user.conf 修改配置文件，填入自己的帐号信息，并使用 bilihelper 命令运行BiliHelper。"
	elif [ "${OPTION}" == '0' ]; then
		main
	else
		echo "输入错误！"
	fi
	read -p "请按任意键继续..." -n 1 press
	tools
}

function AriaNg(){
	echo "正在安装依赖..."
	pkg install -y wget nginx unzip
	echo "正在创建Aria2配置文件"
	cd ~ > /dev/null
	mkdir aria2
	touch ~/aria2/aria2.session
####################################
#注释：此时EOF加单引号，为了防止内部被解析报错
cat << 'EOF' > ~/aria2/aria2.conf
## '#'开头为注释内容, 选项都有相应的注释说明, 根据需要修改 ##
## 被注释的选项填写的是默认值, 建议在需要修改时再取消注释  ##

## 文件保存相关 ##

# 文件的保存路径(可使用绝对路径或相对路径), 默认: 当前启动位置
dir=/sdcard/Download
# 启用磁盘缓存, 0为禁用缓存, 需1.16以上版本, 默认:16M
#disk-cache=32M
# 文件预分配方式, 能有效降低磁盘碎片, 默认:prealloc
# 预分配所需时间: none < falloc ? trunc < prealloc
# falloc和trunc则需要文件系统和内核支持
# NTFS建议使用falloc, EXT3/4建议trunc, MAC 下需要注释此项
#file-allocation=none
# 断点续传
continue=true

## 下载连接相关 ##

# 最大同时下载任务数, 运行时可修改, 默认:5
#max-concurrent-downloads=5
# 同一服务器连接数, 添加时可指定, 默认:1
max-connection-per-server=5
# 最小文件分片大小, 添加时可指定, 取值范围1M -1024M, 默认:20M
# 假定size=10M, 文件为20MiB 则使用两个来源下载; 文件为15MiB 则使用一个来源下载
min-split-size=10M
# 单个任务最大线程数, 添加时可指定, 默认:5
#split=5
# 整体下载速度限制, 运行时可修改, 默认:0
#max-overall-download-limit=0
# 单个任务下载速度限制, 默认:0
#max-download-limit=0
# 整体上传速度限制, 运行时可修改, 默认:0
#max-overall-upload-limit=0
# 单个任务上传速度限制, 默认:0
#max-upload-limit=0
# 禁用IPv6, 默认:false
#disable-ipv6=true
# 连接超时时间, 默认:60
#timeout=60
# 最大重试次数, 设置为0表示不限制重试次数, 默认:5
#max-tries=5
# 设置重试等待的秒数, 默认:0
#retry-wait=0

## 进度保存相关 ##

# 从会话文件中读取下载任务
input-file=/data/data/com.termux/files/home/aria2/aria2.session
# 在Aria2退出时保存`错误/未完成`的下载任务到会话文件
save-session=/data/data/com.termux/files/home/aria2/aria2.session
# 定时保存会话, 0为退出时才保存, 需1.16.1以上版本, 默认:0
save-session-interval=60

## RPC相关设置 ##

# 启用RPC, 默认:false
enable-rpc=true
# 允许所有来源, 默认:false
rpc-allow-origin-all=true
# 允许非外部访问, 默认:false
rpc-listen-all=true
# 事件轮询方式, 取值:[epoll, kqueue, port, poll, select], 不同系统默认值不同
#event-poll=select
# RPC监听端口, 端口被占用时可以修改, 默认:6800
#rpc-listen-port=6800
# 设置的RPC授权令牌, v1.18.4新增功能, 取代 --rpc-user 和 --rpc-passwd 选项
#rpc-secret=<TOKEN>
# 设置的RPC访问用户名, 此选项新版已废弃, 建议改用 --rpc-secret 选项
#rpc-user=<USER>
# 设置的RPC访问密码, 此选项新版已废弃, 建议改用 --rpc-secret 选项
#rpc-passwd=<PASSWD>
# 是否启用 RPC 服务的 SSL/TLS 加密,
# 启用加密后 RPC 服务需要使用 https 或者 wss 协议连接
#rpc-secure=true
# 在 RPC 服务中启用 SSL/TLS 加密时的证书文件,
# 使用 PEM 格式时，您必须通过 --rpc-private-key 指定私钥
#rpc-certificate=/path/to/certificate.pem
# 在 RPC 服务中启用 SSL/TLS 加密时的私钥文件
#rpc-private-key=/path/to/certificate.key

## BT/PT下载相关 ##

# 当下载的是一个种子(以.torrent结尾)时, 自动开始BT任务, 默认:true
#follow-torrent=true
# BT监听端口, 当端口被屏蔽时使用, 默认:6881-6999
listen-port=51413
# 单个种子最大连接数, 默认:55
#bt-max-peers=55
# 打开DHT功能, PT需要禁用, 默认:true
enable-dht=false
# 打开IPv6 DHT功能, PT需要禁用
#enable-dht6=false
# DHT网络监听端口, 默认:6881-6999
#dht-listen-port=6881-6999
# 本地节点查找, PT需要禁用, 默认:false
#bt-enable-lpd=false
# 种子交换, PT需要禁用, 默认:true
enable-peer-exchange=false
# 每个种子限速, 对少种的PT很有用, 默认:50K
#bt-request-peer-speed-limit=50K
# 客户端伪装, PT需要
peer-id-prefix=-TR2770-
user-agent=Transmission/2.77
peer-agent=Transmission/2.77
# 当种子的分享率达到这个数时, 自动停止做种, 0为一直做种, 默认:1.0
seed-ratio=0
# 强制保存会话, 即使任务已经完成, 默认:false
# 较新的版本开启后会在任务完成后依然保留.aria2文件
#force-save=false
# BT校验相关, 默认:true
#bt-hash-check-seed=true
# 继续之前的BT任务时, 无需再次校验, 默认:false
bt-seed-unverified=true
# 保存磁力链接元数据为种子文件(.torrent文件), 默认:false
bt-save-metadata=true
EOF
####################################
	echo "将要从Github上下载AriaNg-1.1.4-AllInOne.zip，此版本更新于2019.10.8，截至2020.2.20为最新版。"
	wget https://github.com/mayswind/AriaNg/releases/download/1.1.4/AriaNg-1.1.4-AllInOne.zip
	if [ -f ~/AriaNg-1.1.4-AllInOne.zip ]; then
		unzip AriaNg-1.1.4-AllInOne.zip
		mv -f ~/index.html /data/data/com.termux/files/usr/share/nginx/html/index.html
		mv -f ~/LICENSE /data/data/com.termux/files/usr/share/nginx/html/LICENSE
		echo -e "nginx\naria2c --conf-path=$HOME/aria2/aria2.conf -D" > /data/data/com.termux/files/usr/bin/startaria2
		echo -e "nginx -s stop\nkillall aria2c" > /data/data/com.termux/files/usr/bin/stoparia2
		chmod +x /data/data/com.termux/files/usr/bin/startaria2
		chmod +x /data/data/com.termux/files/usr/bin/stoparia2
		echo '安装完成！请使用"startaria2"命令打启动Aria2下载服务，使用"stoparia2"命令关闭服务。'
	else
		echo "下载失败！"
	fi
}

function security() {
	cd ~ > /dev/null
	if [ $gui == true ]; then
		OPTION=$(whiptail --title "Stone Termux管理工具 - 安装常用信息安全工具" --menu "当前菜单下共有14个选项，请使用方向键进行选择，按回车键确认。" 15 50 4 \
			"0" "返回主菜单" \
			"1" "安装Metasploit" \
			"2" "安装Nmap" \
			"3" "安装Hydra" \
			"4" "安装SSLscan" \
			"5" "安装whatportis" \
			"6" "安装SQLmap" \
			"7" "安装RouterSploit" \
			"8" "安装Slowloris" \
			"9" "安装RED HAWK " \
			"10" "安装Cupp" \
			"11" "安装Hash-Buster" \
			"12" "安装WPSeku" \
			"13" "安装XSStrike" \
			3>&1 1>&2 2>&3)
	else
		echo -e "\n\n\n\n\n"
		echo -e "     Stone Termux管理工具\n\n"
		echo -e "   0   返回主菜单\n"
		echo -e "   1   安装Metasploit\n"
		echo -e "   2   安装Nmap\n"
		echo -e "   3   安装Hydra\n"
		echo -e "   4   安装SSLscan\n"
		echo -e "   5   安装whatportis\n"
		echo -e "   6   安装SQLmap\n"
		echo -e "   7   安装RouterSploit\n"
		echo -e "   8   安装Slowloris\n"
		echo -e "   9   安装RED HAWK \n"
		echo -e "   10  安装Cupp\n"
		echo -e "   11  安装Hash-Buster\n"
		echo -e "   12  安装WPSeku\n"
		echo -e "   13  安装XSStrike\n"
		read -p '请输入序号：' OPTION;
	fi
	####################################
	if [ "${OPTION}" == '1' ]; then
		pkg install -y unstable-repo
		pkg install -y metasploit
		echo "安装完成！"
	elif [ "${OPTION}" == '2' ]; then
		pkg install -y nmap
		echo "安装完成！"
	elif [ "${OPTION}" == '3' ]; then
		pkg install -y hydra
		echo "安装完成！"
	elif [ "${OPTION}" == '4' ]; then
		pkg install -y unstable-repo
		pkg install -y sslscan
		echo "安装完成！"
	elif [ "${OPTION}" == '5' ]; then
		pip install whatportis
		echo "安装完成！"
	elif [ "${OPTION}" == '6' ]; then
		pip install sqlmap
		echo "安装完成！"
	elif [ "${OPTION}" == '7' ]; then
		git clone https://www.github.com/threat9/routersploit
		cd routersploit 
		pip install -r requirements.txt
		python rsf.py
		echo "安装完成！"
	elif [ "${OPTION}" == '8' ]; then
		pip install slowloris
		echo "安装完成！"
	elif [ "${OPTION}" == '9' ]; then
		pkg install -y php
		git clone https://github.com/Tuhinshubhra/RED_HAWK.git
		cd RED_HAWK
		php rhawk.php
		echo "安装完成！"
	elif [ "${OPTION}" == '10' ]; then
		git clone https://github.com/Mebus/cupp.git
		cd cupp
		python cupp.py
		echo "安装完成！"
	elif [ "${OPTION}" == '11' ]; then
		git clone https://github.com/UltimateHackers/Hash-Buster.git
		cd Hash-Buster
		python hash.py
		echo "安装完成！"
	elif [ "${OPTION}" == '12' ]; then
		git clone https://github.com/m4ll0k/WPSeku.git wpseku
		cd wpseku
		pip install -r requirements.txt
		python wpseku.py
		echo "安装完成！"
	elif [ "${OPTION}" == '13' ]; then
		git clone https://github.com/UltimateHackers/XSStrike.git
		cd XSStrike
		pip install -r requirements.txt
		python xsstrike.py
		echo "安装完成！"
	elif [ "${OPTION}" == '0' ]; then
		main
	else
		echo "输入错误！"
	fi
	read -p "请按任意键继续..." -n 1 press
	security
}

function eggs() {
	cd ~ > /dev/null
	if [ $gui == true ]; then
		OPTION=$(whiptail --title "Stone Termux管理工具 - 常见彩蛋" --menu "当前菜单下共有9个选项，请使用方向键进行选择，按回车键确认。" 15 50 4 \
			"0" "返回主菜单" \
			"1" "安装screenfetch 查看系统信息" \
			"2" "安装neofetch 查看系统信息" \
			"3" "安装sl 火车" \
			"4" "安装cmatrix 黑客帝国字符滚动" \
			"5" "安装nyancat 彩虹猫" \
			"6" "安装fortune 随机一句话" \
			"7" "apt的超级牛力" \
			"8" "telnet星球大战" \
			3>&1 1>&2 2>&3)
	else
		echo -e "\n\n\n\n\n"
		echo -e "     Stone Termux管理工具\n\n"
		echo -e "   0   返回主菜单\n"
		echo -e "   1   安装screenfetch 查看系统信息\n"
		echo -e "   2   安装neofetch 查看系统信息\n"
		echo -e "   3   安装sl 火车\n"
		echo -e "   4   安装cmatrix 黑客帝国字符滚动\n"
		echo -e "   5   安装nyancat 彩虹猫\n"
		echo -e "   6   安装fortune 随机一句话\n"
		echo -e "   7   apt的超级牛力\n"
		echo -e "   8   telnet星球大战\n"
		read -p '请输入序号：' OPTION;
	fi
	####################################
	if [ "${OPTION}" == '1' ]; then
		pkg install -y screenfetch
		screenfetch
	elif [ "${OPTION}" == '2' ]; then
		pkg install -y neofetch
		sl
	elif [ "${OPTION}" == '3' ]; then
		pkg install -y sl
		sl
	elif [ "${OPTION}" == '4' ]; then
		pkg install -y cmatrix
		cmatrix
	elif [ "${OPTION}" == '5' ]; then
		pkg install -y nyancat
		nyancat
	elif [ "${OPTION}" == '6' ]; then
		pkg install -y fortune
		fortune
	elif [ "${OPTION}" == '7' ]; then
		apt-get moo
	elif [ "${OPTION}" == '8' ]; then
		pkg install -y telnet
		telnet towel.blinkenlights.nl
	elif [ "${OPTION}" == '0' ]; then
		main
	else
		echo "输入错误！"
	fi
	read -p "请按任意键继续..." -n 1 press
	eggs
}

function backup() {
	cd ~ > /dev/null
	
	#检测依赖
	if [ ! -e /data/data/com.termux/files/usr/bin/pv ]; then
		echo "检测到未安装pv，正在安装..."
		apt update
		apt install -y pv
	fi
	
	if [ $gui == true ]; then
		OPTION=$(whiptail --title "Stone Termux管理工具 - 备份与恢复" --menu "当前菜单下共有5个选项，请使用方向键进行选择，按回车键确认。" 15 50 4 \
			"0" "返回主菜单" \
			"1" "备份home - Termux主目录" \
			"2" "备份usr - Termux软件安装目录" \
			"3" "还原系统" \
			"4" "查询空间占用" \
			3>&1 1>&2 2>&3)
	else
		echo -e "\n\n\n\n\n"
		echo -e "     Stone Termux管理工具\n\n"
		echo -e "   0   返回主菜单\n"
		echo -e "   1   备份home - Termux主目录\n"
		echo -e "   2   备份usr - Termux软件安装目录\n"
		echo -e "   3   还原系统\n"
		echo -e "   4   查询空间占用\n"
		read -p '请输入序号：' OPTION;
	fi
	####################################
	if [ "${OPTION}" == '1' ] || [ "${OPTION}" == '2' ]; then
		if [ "${OPTION}" == '1' ]; then
			backups=home
		else
			backups=usr
		fi
		
		if [ ! -d /sdcard/backup ]; then
			mkdir -p /sdcard/backup && cd /sdcard/backup
		else
			cd /sdcard/backup
		fi
		
		echo -e "您之前的备份文件如下：\n"
		ls -t ./termux-*.tar.* 2>/dev/null
		read -p "请按任意键继续..." -n 1 press
		
		if [ $gui == true ]; then
			if (whiptail --title "请选择压缩类型" --yes-button "tar.xz" --no-button "tar.gz" --yesno "tar.xz压缩率高，但速度慢。\n tar.gz速度快，但压缩率低。" 10 60); then
				format='xz'
			else
				format='gz'
			fi
		else
			echo -e "请选择压缩类型：\n\n"
			echo -e "   1   tar.xz 压缩率高，但速度慢\n"
			echo -e "   2   tar.gz 速度快，但压缩率低\n"
			while true
			do
				read -p '请输入序号：' OPTION;
				if [ "${OPTION}" == '1' ]; then
					format='xz'
					break
				elif [ "${OPTION}" == '2' ]; then
					format='gz'
					break
				else
					read -p "输入错误，请按任意键继续..." -n 1 press
				fi
			done
		fi
		
		echo "您选择了tar.${format}，将备份${backups}至/sdcard/backup/termux-${backups}_$(date +%Y-%m-%d_%H-%M).tar.${format}"
		read -p "请按任意键开始备份..." -n 1 press
		
		echo "开始备份，如出现部分文件无权限属于正常现象..."
		if [ "${format}" == "xz" ]; then
			tar -PJpcf - /data/data/com.termux/files/${backups} | (pv -p --timer --rate --bytes >termux-${backups}_$(date +%Y-%m-%d_%H-%M).tar.${format})
		else
			tar -Ppczf - /data/data/com.termux/files/${backups} | (pv -p --timer --rate --bytes >termux-${backups}_$(date +%Y-%m-%d_%H-%M).tar.${format})
		fi
		
		ls -lth ./termux-*.tar.*
		echo "备份完成！"
	
	####################################
	
	elif [ "${OPTION}" == '3' ]; then
		cd /sdcard/backup
		echo -e "请选择要恢复的备份文件：\n"
		i=0
		unset backupfile
		for loop in /sdcard/backup/termux-*.tar.*
		do
			i=`expr $i + 1`
			echo -e "   ${i}   ${loop##*/}\n"
			backupfile[${i}]=${loop}
		done
		echo "共识别到${#backupfile[@]}个备份文件"
		while true
		do
			read -p '请输入序号：' OPTION;
			if [ $OPTION -le ${#backupfile[@]} ]; then
				target=${backupfile[$OPTION]#*-}
				target=${target%%_*}
				echo "您选择了${backupfile[$OPTION]##*/}，将还原${target}。"
				read -p "请按任意键开始还原..." -n 1 press
			
				if [ "${backupfile[$OPTION]:0-6:6}" == 'tar.xz' ]; then
					echo 'tar.xz'
					pv ${backupfile[$OPTION]} | tar -PJx
				elif [ "${backupfile[$OPTION]:0-6:6}" == 'tar.gz' ]; then
					echo 'tar.gz'
					pv ${backupfile[$OPTION]} | tar -Pzx
				else
					echo "备份文件不合法！"
				fi
				break
			else
				read -p "输入错误，请按任意键继续..." -n 1 press
			fi
		done
		echo "还原完成！"
		
	elif [ "${OPTION}" == '4' ]; then
		SpaceOccupation
	elif [ "${OPTION}" == '0' ]; then
		main
	else
		echo "输入错误！"
	fi
	read -p "请按任意键继续..." -n 1 press
	backup
}

SpaceOccupation() {
	cd ~/.. > /dev/null
	if [ $gui == true ]; then
		OPTION=$(whiptail --title "Stone Termux管理工具 - 查询空间占用" --menu "当前菜单下共有4个选项，请使用方向键进行选择，按回车键确认。" 15 50 4 \
			"0" "返回主菜单" \
			"1" "Termux各目录" \
			"2" "Termux文件" \
			"3" "Sdcard" \
			3>&1 1>&2 2>&3)
	else
		echo -e "\n\n\n\n\n"
		echo -e "     Stone Termux管理工具\n\n"
		echo -e "   0   返回主菜单\n"
		echo -e "   1   Termux目录\n"
		echo -e "   2   Termux文件\n"
		echo -e "   3   Sdcard\n"
		read -p '请输入序号：' OPTION;
	fi
	
	if [ "${OPTION}" == '1' ]; then
		echo '正在加载中，可能需要几秒钟时间，加载时间取决于文件数量和闪存读写速度...'
		echo -e "\n\033[33m主目录 TOP15\n\033[m"
		du -hsx ./home/* ./home/.* 2>/dev/null | sort -rh | head -n 15
		echo -e "\n\033[33musr 目录 TOP6\n\033[m"
		du -hsx ./usr/* 2>/dev/null | sort -rh | head -n 6
		echo -e "\n\033[33musr/lib 目录 TOP8\n\033[m"
		du -hsx ./usr/lib/* 2>/dev/null | sort -rh | head -n 8
		echo -e "\n\033[33musr/share 目录 TOP8\n\033[m"
		du -hsx ./usr/share/* 2>/dev/null | sort -rh | head -n 8
	elif [ "${OPTION}" == '2' ]; then
		echo '正在加载中，可能需要几秒钟时间，加载时间取决于文件数量和闪存读写速度...'
		echo -e "\n\033[33mTermux 文件 TOP30\n\033[m"
		find ./ -type f -print0 2>/dev/null | xargs -0 du | sort -n | tail -30 | cut -f2 | xargs -I{} du -sh {}
	elif [ "${OPTION}" == '3' ]; then
		cd /sdcard
		echo '正在加载中，可能需要几秒钟时间，加载时间取决于文件数量和闪存读写速度...'
		echo -e "\n\033[33msdcard 目录 TOP15\n\033[m"
		du -hsx ./* ./.* 2>/dev/null | sort -rh | head -n 15
		echo -e "\n\033[33msdcard 文件 TOP30\n\033[m"
		find ./ -type f -print0 2>/dev/null | xargs -0 du | sort -n | tail -30 | cut -f2 | xargs -I{} du -sh {}
	elif [ "${OPTION}" == '0' ]; then
		main
	else
		echo "输入错误！"
	fi
	read -p "请按任意键继续..." -n 1 press
	SpaceOccupation
}

function install() {
	echo -e "把 Stone Termux管理工具 安装到Termux系统中后，你可以输入 $1 打开本工具。\n"
	while true
	do
		read -p "你要把 Stone Termux管理工具 安装到Termux系统中吗？ [Y/n] " input
		case $input in
			[yY][eE][sS]|[yY])
				#检测依赖
				if [ ! -e /data/data/com.termux/files/usr/bin/wget ]; then
					echo "检测到未安装wget，正在安装..."
					apt update
					apt install -y wget
				fi
				wget -qO "/data/data/com.termux/files/usr/bin/${1}" "$update"
				chmod +x "/data/data/com.termux/files/usr/bin/${1}"
				read -p "安装完成，你可以在Termux中输入 $1 打开本工具，请按任意键继续..." -n 1 press
				exit;;
			[nN][oO]|[nN])
				break;;
			*)
				echo "输入错误，请重新输入...";;
		esac
	done
	main
}

function remove() {
	while true
	do
		read -p "你确定要把 Stone Termux管理工具 从Termux系统中删除吗？ [Y/n] " input
		case $input in
			[yY][eE][sS]|[yY])
				rm -f $SHELL_FILE
				read -p "卸载完成，再见..." -n 1 press
				exit;;
			[nN][oO]|[nN])
				break;;
			*)
				echo "输入错误，请重新输入...";;
		esac
	done
	main
}

function update() {
	if [ $installed == true ];then
		#检测依赖
		if [ ! -e /data/data/com.termux/files/usr/bin/wget ]; then
			echo "检测到未安装wget，正在安装..."
			apt update
			apt install -y wget
		fi
		echo "正在更新中..."
		wget -qO $SHELL_FILE $update
		chmod +x $SHELL_FILE
		echo "更新完成！"
		read -p "请按任意键继续..." -n 1 press
		bash $SHELL_FILE
	else
		echo "此选项不可用！"
		main
	fi
}

function help() {
	stone
	echo -e "\nStone Termux管理工具 version 1.01\n"
	echo "Usage: st [命令] [参数]"
	echo -e "\nStone Termux管理工具 是一款帮助你快速完成Termux的常用设置、管理和常用软件安装的便捷工具。\n"
	echo "  命令："
	echo "  无        直接进入本工具"
	echo "  gui       进入本工具的GUI模式"
	echo "  install   安装本工具到Termux系统中"
	echo "  remove    删除本工具"
	echo "  update    更新本工具"
	echo "  help      显示本帮助"
	echo -e "\n当选择 install 命令时，可以指定一个参数，表示安装后运行本程序的命令，如不指定，默认为st。\n"
	echo 'Name    : Stone Termux管理工具'
	echo 'Date    : 02-27-2020'
	echo 'Version : 1.01'
	echo 'Author  : St1020'
	echo 'License : GNU General Public License, version 3 (GPL-3.0)'
	echo -e "\nCopyright (C)2020 St1020."
}

function stone(){
echo '   _____ __                 '
echo '  / ___// /_____  ____  ___ '
echo '  \__ \/ __/ __ \/ __ \/ _ \'
echo ' ___/ / /_/ /_/ / / / /  __/'
echo '/____/\__/\____/_/ /_/\___/ '
}

#获取自身绝对路径
#$(cd `dirname $0`; pwd)
#$(dirname $(readlink -f $0))
#$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
#$(dirname $(readlink -f ${BASH_SOURCE[0]}))
SHELL_FILE="$(dirname $(readlink -f $0))"/"${0##*/}"
#判断是否已经安装到系统
if [ "$(dirname $(readlink -f $0))" == "/data/data/com.termux/files/usr/bin" ]; then
	installed=true
	install_menu="从Termux系统中卸载本工具"	
else
	installed=false
	install_menu="安装本工具到Termux系统"
fi

gui=false
#传递参数
if [ $# == 0 ]; then
	main
elif [ $1 == gui ]; then
	gui=true
	check
	main
elif [ $1 == install ]; then
	if [ $# == 1 ]; then
		install "st"
	else
		install "$2"
	fi
elif [ $1 == remove ]; then
	remove
elif [ $1 == update ]; then
	update
elif [ $1 == help ];then
	help
elif [ $1 == prime ];then
	for p in 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97
	do
		i=1
		while [ $i -le $p ]
		do
			i=`expr $i + 1`
			stone
			sleep 0.25
			clear
			sleep 0.25
		done
		sleep 1
	done
	echo "你居然看完了？"
else
	echo "参数不正确！"
	help
fi


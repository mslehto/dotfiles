#!/bin/sh

FILES='tmux.conf vimrc xsession Xdefaults'
DOTDIR=$(expr ~/dotfiles)

if [ ! -d ${DOTDIR} ];then
	echo "DOTDIR ${DOTDIR} does not exist, bye"
	exit 1;
fi

for file in ${FILES};do
	if [ -f ${file} ];then
		dotfile=$(expr ~/.${file})
		if [ -f ${dotfile} ]; then
			if [ -L ${dotfile} ]; then
				echo "skipping ${dotfile} - symbolic"
			else
				echo "skipping ${dotfile} - already exists"
			fi
		else
			cmd=$(expr "ln -s ${DOTDIR}/${file} ${dotfile}")
			echo ${cmd}
			eval ${cmd}
		fi
	fi
done

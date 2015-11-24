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


OPENBOXCONF=$(expr ~/.config/openbox)
if [ -d ${OPENBOXCONF} ];then
	for file in rc.xml menu.xml
	do
		f=$(expr ${OPENBOXCONF}/${file})
	if [ -f ${f} ];then
		echo "skipping ${f} - already exists"
	fi
	done
else
	echo "${OPENBOXCONF} does not exist"
	echo "maybe mkdir -p ${OPENBOXCONF} ?"
fi

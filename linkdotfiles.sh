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
		if [ -L ${dotfile} ] || [ -f ${dotfile} ]; then
			echo "skipping ${dotfile} - symbolic"
			echo "skipping ${dotfile} - already exists"
		else
			cmd=$(expr "ln -s ${DOTDIR}/${file} ${dotfile}")
			echo ${cmd}
			eval ${cmd}
		fi
	fi
done


OPENBOXCONF=$(expr ~/.config/openbox)
if [ ! -d ${OPENBOXCONF} ];then
	echo "${OPENBOXCONF} does not exist"
	echo "maybe mkdir -p ${OPENBOXCONF} first?"
	exit 1
else
	for f in rc.xml menu.xml
	do
		masterfile=$(expr ${DOTDIR}/config/openbox/${f})
		file=$(expr ${OPENBOXCONF}/${f})
		if [ -L ${file} ] || [ -f ${file} ] ;then
			echo "skipping ${file} - already exists"
		else
			dotfile=$(expr ${file})
			cmd=$(expr "ln -s ${masterfile} ${dotfile}")
			echo ${cmd}
			eval ${cmd}
	fi
	done
fi

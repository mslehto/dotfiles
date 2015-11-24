#!/bin/sh

FILES='tmux.conf vimrc xsession Xdefaults'
DOTDIR=$(expr ~/dotfiles)

checkIfExist () {
	COMMON=${1}
	LOCAL=${2}

	printf "checking: ${LOCAL}"
	if [ -e ${LOCAL} ] ;then
		printf " -> skipping ${file}, already exists"
		DIFF=1
		if [ -L ${LOCAL} ] ;then
			printf " symbolic"
		elif [ ! -s ${LOCAL} ] ;then
			printf " zero length?"
		elif [ -d ${LOCAL} ] ;then
			printf " directory"
			DIFF=0
		elif [ ! -r ${LOCAL} ] ;then
			printf " not readable"
			DIFF=0
		fi
		printf '\n'
		if [ "${DIFF}" -eq "1" ];then
		cmd=$(expr "diff ${LOCAL} ${COMMON}")
		eval ${cmd}
		fi
		return 0
	fi
	printf " -> does not exist, install\n"
	return 1
}

makeLink () {
	COMMON=${1}
	LOCAL=${2}
	cmd=$(expr "ln -s ${COMMON} ${LOCAL}")
	printf "\t --> ${cmd} <--\n"
	eval ${cmd}
}

if [ ! -d ${DOTDIR} ];then
	echo "DOTDIR ${DOTDIR} does not exist, bye"
	exit 1;
fi

for file in ${FILES};do
	COMMON=$(expr "${DOTDIR}/${file}")
	LOCAL=$(expr ~/.${file})
	checkIfExist ${COMMON} ${LOCAL}
	RES=$?
	if [ "${RES}" -eq "1" ];then
		makeLink ${COMMON} ${LOCAL}
	fi
done

OPENBOXCONF=$(expr ~/.config/openbox)
if [ ! -d ${OPENBOXCONF} ];then
	echo "${OPENBOXCONF} does not exist"
	echo "maybe mkdir -p ${OPENBOXCONF} first?"
	exit 1
else
	for file in rc.xml menu.xml
	do
		COMMON=$(expr "${DOTDIR}/config/openbox/${file}")
		LOCAL=$(expr ${OPENBOXCONF}/${file})
		checkIfExist ${COMMON} ${LOCAL}
		RES=$?
		if [ "${RES}" -eq "1" ];then
			printf "$COMMON exists\n"
			cmd=$(expr "ln -s ${COMMON} ${LOCAL}")
			echo ${cmd}
			eval ${cmd}
		fi
	done

fi

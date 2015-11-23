#!/bin/sh

askXrandr() {
		cowchars='b d g p s t w y'
		len=${#cowchars}
		count=$(expr $len / 2)
		rchar=$(dd if=/dev/random bs=1 count=1 status=none)
		rint=$(printf '%d' \'$rchar)
		rndm=$(expr $rint % $count)

		i=0
		for char in ${cowchars}
		do
			if [ "${i}" = "${rndm}" ];then
				cowchar=$char
				break
			fi
			i=$(expr $i + 1)
			sleep .01
		done

		cowsay -${cowchar} -e xx -T \|\| 'moo for xrandr.sh' |xmessage -timeout 60 -file - -buttons moo:1 -geom +10+10
		ret=$?
		echo "ret: ${ret}"
		if [ "${ret}" -eq "1" ];then
			echo xrandrplz
		fi
}

HOST=$(hostname -s)
OS=$(uname -o)

xsetroot -solid grey &
xmodmap -e 'pointer = 3 2 1'

SSHAGENTRC="$(ssh-agent -s)"
echo ${SSHAGENTRC} > ~/sa.sh
eval ${SSHAGENTRC}

# set ENV to a file invoked each time sh is started for interactive use
ENV=$HOME/.shrc; export ENV

if [ "${OS}" = "FreeBSD" ]; then
	(pkg audit | xmessage -geometry +100+200 -file -) &
fi


if [ "${HOST}" = 'spof' ];then
	(zpool list -v -Tu | xmessage -geometry +100+10 -file -) &
	askXrandr
fi

if [ "${HOST}" = 'tempo' ];then
	(freebsd-version | xmessage -geometry +100+10 -file -) &
fi

dotfiles/bin/xclock.sh

openbox


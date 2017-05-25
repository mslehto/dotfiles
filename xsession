#!/bin/sh

askXrandr() {
		if [ ! -x "/usr/local/bin/cowsay" ];then
			   return
		fi

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

show-zpool() {
	(zpool list -v -Tu | xmessage -geometry +100+10 -file -) &
}

show-pkg_audit() {
	xterm -hold -title 'pkg audit' -e pkg audit &
}

show-pceol() {
	xterm -hold -title 'pc-updatemanager showeol' -e "pc-updatemanager showeol" &
}

HOST=$(hostname -s)
OS=$(uname -s)

xmodmap -e 'pointer = 3 2 1'


# set ENV to a file invoked each time sh is started for interactive use
ENV=$HOME/.shrc; export ENV

if [ "${OS}" = "FreeBSD" ]; then
	show-pkg_audit
	show-zpool
	(freebsd-version | xmessage -geometry +100+10 -file - -timeout 600) &
fi

if [ "${HOST}" = 'spof' ];then
	show-pceol
	askXrandr
	SSHAGENTRC="$(ssh-agent -c)"
	xsetroot -solid gray &
	xscreensaver -nosplash &
	~/dotfiles/bin/xclock.sh
	xset b off
	setxkbmap -layout us,fi -option grp:caps_toggle
fi

if [ "${HOST}" = 'tempof' ];then
	SSHAGENTRC="$(ssh-agent -s)"
	xsetroot -solid black &
	xscreensaver -nosplash &
	~/dotfiles/bin/xclock.sh
	xset b off
	setxkbmap -layout fi
fi

if [ "${HOST}" = 'ljb' ];then
	SSHAGENTRC="$(ssh-agent -c)"
	show-pceol
	xsetroot -solid gray &
	xscreensaver -nosplash &
	xset b off
	xfce4-panel &
	setxkbmap fi
fi

if [ "${HOST}" = 'tiptop' ];then
	xsetroot -solid gray &
	xscreensaver -nosplash &
	xset b off
	~/dotfiles/bin/xclock.sh
fi
echo ${SSHAGENTRC} > ~/.ssh-agent.sh
eval ${SSHAGENTRC}

openbox


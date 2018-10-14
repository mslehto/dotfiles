#!/bin/sh

#VAR="first line"
#VAR="$VAR"'\n'"second line"

sftpcmd ()
{
	src=$1
	dst=$2
	#echo "ls -lnf $dst"
	#echo "rm $dst"
	echo "put $src $dst"
}

HOST=$1
if [ -z $HOST ]
then
  echo -e "Usage:\n\t$0 HOST\n"
  exit 13
fi

DOTFILEDIR=dotfiles
DOTFILES="inputrc editrc shrc profile"

batch=''
for f in $DOTFILES
do
	cmd=$(sftpcmd "$DOTFILEDIR/$f" ".$f")
    batch="$batch"$'\n'"$cmd"
done
batch="$batch"$'\n'"$(sftpcmd "$DOTFILEDIR/vim/vimrc" ".vimrc")"
batch="$batch"$'\n'"$(sftpcmd "$DOTFILEDIR/tmux.conf.simple" ".tmux.conf")"
batch="$batch"$'\n'"bye"

echo -e "batch=>$batch<"
echo -e "$batch" | sftp -b- $HOST:

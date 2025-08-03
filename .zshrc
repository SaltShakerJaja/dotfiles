# Change the modular file(s) in ~/.config/zshrc or in ~/.config/zshrc/custom

for f in ~/.config/zshrc*; do
    if [ ! -d $f ]; then
        c=`echo $f | sed -e "s=.config/zshrc=.config/zshrc/custom=`
        [[ -f $c ]] && source $c || source $f 
    fi 
done

if [ -f ~/.zshrc_custom ]; then
    source ~/.zshrc_custom
fi

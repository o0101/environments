sudo=""
if command -v sudo &>/dev/null; then
  sudo="$(command -v sudo)"
fi
if command -v npm &>/dev/null; then
  npm config set sign-git-tag true
fi
git config --global gpg.format ssh
git config --global commit.gpgSign true
git config --global user.email "development.team@dosyago.com"
git config --global user.name "DOSAYGO Engineering"
git config --global core.editor "vim"
git config --global pull.rebase false
git config --global init.defaultBranch boss
git config --global user.signingKey "$HOME/.ssh/id_ed25519.pub"
git config --global gpg.ssh.allowedSignersFile ~/.config/git/allowed_signers
git config --global core.hooksPath ~/.config/git/hooks
git config set advice.setUpstreamFailure false
mkdir -p ~/.config/git/
touch ~/.config/git/allowed_signers
mkdir -p ~/.config/git/hooks/
cp scripts/no-large-files.sh ~/.config/git/hooks/pre-commit
chmod +x -R ~/.config/git/hooks/*
echo "development.team@dosyago.com $(cat ~/.ssh/id_ed25519.pub)" >> ~/.config/git/allowed_signers
mkdir -p ~/.local/bin/
$sudo cp commands/* ~/.local/bin/
$sudo cp commands/* /usr/local/bin
cp bashrc $HOME/.bashrc.new
cp vimrc $HOME/.vimrc
$sudo cp vimrc /root/.vimrc
$sudo cp bashrc /root/.bashrc.new
$sudo mkdir -p /usr/share/games/cfortunes/
$sudo cp cfortunes/* /usr/share/games/cfortunes/
$sudo apt -y install pandoc iptables moreutils
cp .bash_aliases $HOME/.bash_aliases
cp scripts/renew_tls.sh $HOME/.renew_tls.sh
cp affirm.py $HOME/.config/
echo 'echo "$(python3 $HOME/.config/affirm.py)"' >> $HOME/.bash_profile

if [[ "$OSTYPE" == darwin* ]]; then
  $sudo cp macos-commands/* /usr/local/bin/
fi
sudo update-alternatives --config editor

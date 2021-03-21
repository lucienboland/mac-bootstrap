#!/usr/bin/env bash

printf "###### Welcome to VMS Melbourne mac-bootstrap script ######\n"

printf "====== Homebrew (brew) setup ======\n"


    # might need to make sure /usr/local exists and is writable by user

printf "------ Curl homebrew install.sh and run wih bash -c ------\n"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"


    # CASKS are mac GUI applications
    # TAPS are third party repositories that extend the brew core packages
    # FORMULAE are 

printf "------ Install homebrew taps (third party homebrew repos) ------\n"

_taps=(homebrew/cask-fonts)

printf "++++++ taps to install are ++++++\n"

for i in ${!_taps[@]}; do
    printf "    ${_taps[$i]}\n"
done


printf "++++++ installing taps ++++++\n"
for i in ${!_taps[@]}; do
    printf "****** ${_taps[$i]} ******\n"
  brew cask install ${_taps[$i]}
done

printf "------ Install homebrew casks (MacOS GUI apps) ------\n"
    # GROUP apps by broad catagories for easy maintenance

_pwd_mgt=(bitwarden 1password)           # add your own password manager here too
_mac_utils=(alfred istat-menus iterm2)
_browse=(firefox google-chrome)
_msgs=(slack whatsapp microsoft-teams)
_video_conf=(zoomus skype)

_fs=(box-drive google-backup-and-sync)   # onedrive dropbox
        # might need password entered: microsoft-teams microsoft-office
_office=(microsoft-office omnigraffle)   # microsoft-onenote
_code=(postman visual-studio-code)

_virt=(virtualbox virtualbox-extension-pack docker)

_casks=("${_pwd_mgt[@]}" "${_mac_utils[@]}" "${_browse[@]}" "${_msgs[@]}" "${_video_conf[@]}" "${_fs[@]}" "${_office[@]}" "${_code[@]}" "${_virt[@]}")

printf "++++++ casks to install are ++++++\n"

for i in ${!_casks[@]}; do
    printf "    ${_casks[$i]}\n"
done


printf "++++++ installing casks ++++++\n"
for i in ${!_casks[@]}; do
    printf "****** ${_casks[$i]} ******\n"
  brew cask install ${_casks[$i]}
done


_formulae=(shellcheck bash-git-prompt)

# iterm2

# Specify the preferences directory
_iterm2_prefscustomfolder="~/.config/iterm2"
_iterm2_current_setting=$(defaults read com.googlecode.iterm2.plist PrefsCustomFolder)
if [[ "$_iterm2_prefscustomfolder" != "$_iterm2_current_setting" ]]; then
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${_iterm2_prefscustomfolder}"
    # Tell iTerm2 to use the custom preferences in the directory
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
fi


# Google Drive File Stream

curl https://dl.google.com/drive-file-stream/GoogleDriveFileStream.dmg --output GoogleDriveFileStream.dmg
hdiutil mount GoogleDriveFileStream.dmg
sudo installer -pkg /Volumes/Install\ Google\ Drive\ File\ Stream/GoogleDriveFileStream.pkg -target "/Volumes/Macintosh HD"
hdiutil unmount /Volumes/Install\ Google\ Drive\ File\ Stream/
rm GoogleDriveFileStream.dmg

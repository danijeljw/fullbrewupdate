#!/usr/bin/env bash
#
#   FullBrewUpdate v2.0
#   Copyright 2016 Danijel-James Wynyard
#   All Rights Reserved.
#
#   Redistribution and use in source and binary forms, with or without
#   modification, are permitted provided that the following conditions are met:
#
#   * Redistributions of source code must retain the above copyright notice, this
#     list of conditions and the following disclaimer.
#
#   * Redistributions in binary form must reproduce the above copyright notice,
#     this list of conditions and the following disclaimer in the documentation
#     and/or other materials provided with the distribution.
#
#   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#   DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
#   FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
#   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#   CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#   OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
#   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Get list of new packages
echo -e "📥  \e[92mGetting a list of updates\e[39m"
brew update
brew cask update

# Assign list of install casks to variable 'casks'
casks=( $(brew cask list) )

# Compare the installed casks against the current versions
for cask in ${casks[@]}
do
    # in the first line there is version
    current="$(brew cask info $cask | sed -n '1p' | sed -n 's/^.*: \(.*\)$/\1/p')"

    installed=( $(ls /usr/local/Caskroom/$cask))
    if (! [[ " ${installed[@]} " == *" $current "* ]]); then
        (set -x; brew cask install $cask --force;)
    fi
done

# upgrades and cleanup
brew upgrade
brew cleanup

echo -e "👍  \e[92mBrew & Cask Packages Updated\e[39m  😄"

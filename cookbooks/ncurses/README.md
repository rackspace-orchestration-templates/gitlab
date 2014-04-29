# ncurses [![Build Status](https://secure.travis-ci.org/atomic-penguin/cookbook-ncurses.png?branch=master)](http://travis-ci.org/atomic-penguin/cookbook-ncurses)

## Description

Installs platform specific ncurses binaries, and development libraries.

## Attributes

* ncurses['packages']
  - Set the list of platform specific readline packages.
  - Defaults to "ncurses", "ncurses-devel" on Redhat family platforms
  - Defaults to "libncurses5", "libncurses5-dev"" on Debian family platforms

## Usage

Put `recipe[ncurses]` in the run list to ensure applications requiring ncurses 
or development libraries will have these packages available. 

## License and Author

Author: Eric G. Wolfe

Copyright 2012, Eric G. Wolfe

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

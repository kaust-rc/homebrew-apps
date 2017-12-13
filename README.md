# homebrew-apps

[![Read the Docs](https://readthedocs.org/projects/kaust-apps/badge/?version=latest)](https://kaust-apps.readthedocs.io)
[![Join us on SLACK](https://img.shields.io/badge/slack-joinus-red.svg)](https://kaust-rc.slack.com)

KAUST Homebrew Apps delivers easy installation of applications in user's HOME.
The Formulae included here are built based on [Linuxbrew](http://linuxbrew.sh/).

Research Computing has already setup brew for you in your HOME. This allows you
to install applications when you need them without having to  wait on Research
Computing to compile, test, install it in a shared folder. This is already done
using automated builds. Available packages have already been thoroughly QA-ed.

You can start using brew as described in detail on [Linuxbrew](http://linuxbrew.sh/).
Here's an example on how to install Xcrysden:

    $ brew install xcrysden

Documentation
----------------

### Read the docs

[**Full documentation**](https://kaust-apps.readthedocs.io/) for KAUST Apps is the first place to look.

### Known Issues
OpenMS formula currently works only on Ubuntu. It requires as well the installation of qt4 packages:
  * For Ubuntu Trusty, run: $ sudo apt-get install libqt4-core libqt4-dev
  * For Ubuntu Xenial, run: $ sudo apt-get install qt4-default

### Ask the experts

Ask questions, request new software, open issues, get answers from your peers using Slack:

  * [Research Computing Slack](https://kaust-rc.slack.com)
  * [Browse issues on GitHub](https://github.com/kaust-rc/homebrew-apps/issues)

### Contributions

Many thanks go to KAUST Apps [contributors](https://github.com/kaust-rc/homebrew-apps/graphs/contributors).

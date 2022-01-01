# Handbook

## Build

### Install Inter font by rsms

```bash
wget https://github.com/rsms/inter/releases/download/v3.15/Inter-3.15.zip
mkdir -p ~/.local/share/fonts
unzip Inter-3.15.zip
mv 'Inter Desktop' ~/.local/share/fonts/
fc-cache ~/.local/share/fonts
``` 

More info: https://rsms.me/inter/

### Prerequisites: Arch

Install [Sphinx](https://docs.readthedocs.io/en/stable/intro/getting-started-with-sphinx.html).

```bash
sudo pacman -S python
sudo pacman -S python-pip
sudo pacman -S texlive-most # latex support
sudo pacman -S pandoc
sudo pip install sphinx
```

### Prerequisites: Debian

```bash
sudo apt install python3-pip texlive-xetex texlive-latex-extra pandoc
sudo pip3 install sphinx
```

### Build HTML version

```bash
cd src
make html
firefox build/html/index.html
```

### Build LaTeX/PDF version

```bash
cd src
./build-pdf-book.sh
```

## Style Guide

### Swiss Style

An absolute and universal form of graphic expression through objective and impersonal presentation, communicating to the audience without the interference of the designer's subjective feelings or propagandist techniques of persuasion.

- Grid.
- Flush left align, ragged right.
- Sans-serif
- Objective photography.


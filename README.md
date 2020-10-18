# Handbook

## Swiss Style

An absolute and universal form of graphic expression through objective and impersonal presentation, communicating to the audience without the interference of the designer's subjective feelings or propagandist techniques of persuasion.

- Grid.
- Flush left align, ragged right.
- Sans-serif
- Objective photography.

## Build

Install [Sphinx(https://docs.readthedocs.io/en/stable/intro/getting-started-with-sphinx.html).

```
sudo pacman -S python
sudo pacman -S python-pip
sudo pacman -S texlive-core # latex support
sudo pip install sphinx
sudo pip install recommonmark # to parse md
```

### Build HTML version

```
cd src
make html
firefox build/html/index.html
```

### Build LaTex version

```
cd src
make latexpdf
```

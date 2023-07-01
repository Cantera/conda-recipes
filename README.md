This repository hosts the recipe to build the Python interface for Cantera into a conda package. The package is built on GitHub Actions and uploaded to Anaconda.org automatically.

![CI](https://github.com/Cantera/conda-recipes/workflows/CI/badge.svg)

# Cheatsheet

- To build packages locally for a development branch of Cantera, the following
  commands can be used:
```
export CANTERA_GIT=/path/to/cantera/repo
export INCOMING_REF=branch-name-or-commit-hash
conda build ./cantera
conda build ./cantera-matlab
```

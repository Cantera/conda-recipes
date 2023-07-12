This repository hosts the recipe to build the Python interface for Cantera into a conda package. The package is built on GitHub Actions and uploaded to Anaconda.org automatically.

![CI](https://github.com/Cantera/conda-recipes/workflows/CI/badge.svg)

# Cheatsheet

## Prerequisites

- Create and activate a `conda` environment with `conda-build` installed

## Default build

The following instructions will build:
- The latest version of the `main` branch from https://github.com/Cantera/cantera
- For the version of Python installed in the ``base`` environment
- For some unspecified default version of NumPy

```bash
git clone https://github.com/Cantera/conda-recipes
cd conda-recipes
conda build cantera
```

## Building for a different version of Python and NumPy

```bash
conda build --python=X.Y --numpy=U.V
```

## Building for a local development branch of Cantera

```bash
export CANTERA_GIT=/path/to/cantera/repo
export INCOMING_REF=branch-name-or-commit-hash
conda build ./cantera
conda build ./cantera-matlab
```

## Building the MATLAB toolbox

```bash
export MW_HEADERS_DIR=/Applications/MATLAB_R2023a.app
conda build ./cantera-matlab
```

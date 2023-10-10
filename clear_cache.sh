#!/usr/bin/env bash

set -euo pipefail

echo "Clearning all hugginface models..."
python3 nuke_huggingface_cache.py

echo "Clearing playwright browsers..."
pip install playwright
playwright uninstall
pip uninstall playwright

echo "Clearing docker build cache..."
docker system df
docker builder prune -f

echo "Clearing all cached pytorch models..."
rm -rv $XDG_CACHE_HOME/torch/*


echo "Clearing llm mlc models..."
llm_mlc_models_dir="$(llm mlc models-dir)"
rm -rv $llm_mlc_models_dir/*

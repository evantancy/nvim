#!/usr/bin/env bash

#### DEPENDENCIES
# ensure git lfs installed
brew install git-lfs
# rust install
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

ENV_NAME="llm-chat-custom"
conda create -n $ENV_NAME -c mlc-ai -c conda-forge mlc-chat-cli-nightly
conda activate $ENV_NAME

# Main setup
mkdir -vp ~/repos
cd ~/repos && git clone https://github.com/mlc-ai/mlc-llm.git --recursive
cd ~/repos/mlc-llm/
pip install .
HF_MODEL="WizardLM/WizardCoder-Python-34B-V1.0"
python3 -m mlc_llm.build --hf-path $HF_MODEL --target metal --quantization q4f16_1

# for some reason the git lfs files are not downloaded
cd ~/repos/mlc-llm/dist/WizardCoder-Python-34B-V1.0-q4f16_1/ && git lfs fetch && git restore .

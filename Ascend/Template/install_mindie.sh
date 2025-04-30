#/bin/bash

MINDIE_INSTALL="Ascend-mindie_*_linux-*.run"
MINDIE_ATB_MODELS="Ascend-mindie-atb-models_*_linux-*_torch*-abi*.tar.gz"

chmod +x *.run
# before install MINDIE_ATB_MODELS, create the install path according USER,
# for root
mkdir -p /usr/local/Ascend/llm_model
tar -xzvf ~/${MINDIE_ATB_MODELS} -C /usr/local/Ascend/llm_model
# for non-root
#mkdir -p ~/Ascend/llm_model
#tar -xzvf ~/${MINDIE_ATB_MODELS} -C ~/Ascend/llm_model

yes | ~/${MINDIE_INSTALL} --install --quiet 2> /dev/null
mindie_status=$?
if [ ${mindie_status} -eq 0 ]; then
    echo "install mindie successfully"
else
    echo "install mindie failed with status ${mindie_status}"
fi

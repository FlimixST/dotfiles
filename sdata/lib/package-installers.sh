# This script depends on `functions.sh' .
# This script is not for direct execution, instead it should be sourced by other script. It does not need execution permission or shebang.

# shellcheck shell=bash

# This file is provided for any distros, mainly non-Arch(based) distros.

install-python-packages(){
  UV_NO_MODIFY_PATH=1
  ILLOGICAL_IMPULSE_VIRTUAL_ENV=$XDG_STATE_HOME/quickshell/.venv
  x mkdir -p $(eval echo $ILLOGICAL_IMPULSE_VIRTUAL_ENV)
  # we need python 3.12 https://github.com/python-pillow/Pillow/issues/8089
  try uv venv --prompt .venv $(eval echo $ILLOGICAL_IMPULSE_VIRTUAL_ENV) -p 3.12
  x source $(eval echo $ILLOGICAL_IMPULSE_VIRTUAL_ENV)/bin/activate
  if [[ "$INSTALL_VIA_NIX" = true ]]; then
    x nix-shell ${REPO_ROOT}/sdata/uv/shell.nix --run "uv pip install -r ${REPO_ROOT}/sdata/uv/requirements.txt"
  else
    x uv pip install -r ${REPO_ROOT}/sdata/uv/requirements.txt
  fi
  x deactivate
}

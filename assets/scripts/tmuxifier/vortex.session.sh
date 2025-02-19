# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/repos/vortex"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "vortex"; then

  # EDITOR WINDOW - to be enabled later when Neovim is setup
  #new_window "editor"
  #TODO - run_cmd "nvim ."

  # C++ BUILD/TEST WINDOW - after VSCode is ditched, use it as a
  #                          vertical half-split
  new_window "build"
  new_window "test"
  run_cmd "mkdir -p build && cd build"

  # PY CODEGEN WINDOW - cleanup conda setup and activation
  new_window "py-codegen"
  run_cmd "cd tools/settings-wizard/src && conda activate vxsw"

  # Select the default active window on session creation.
  select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session

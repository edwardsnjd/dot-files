# HACK: Try to detect if this is run directly or sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  <+ sourced +>
else
  <+ executed +>
fi

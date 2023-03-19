# https://stackoverflow.com/questions/29278743/how-to-check-if-multiple-variables-are-defined-or-not-in-bash
check_vars()
{
  var_names=("$@")
  for var_name in "${var_names[@]}"; do
    [ -z "${!var_name}" ] && echo "$var_name is unset." && var_unset=true
  done
  [ -n "$var_unset" ] && exit 1
  return 0
}
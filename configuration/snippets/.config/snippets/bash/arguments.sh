local flag=0
local option=""

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    -f|--flag)
      flag=1
      shift # past argument
      ;;
    -o|--option)
      option="$2"
      shift # past argument
      shift # past value
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

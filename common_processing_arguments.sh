#!/bin/bash -x

#initialize
declare -i argc=0
declare -A argv
declare -A argvalidator=( ["ftpfile"]="^ftp://(.+:.+@)?([\\.a-z0-9]+)/([\\./a-z0-9]+)$" \
                          ["localfile"]="^(.+/)*(.+)$" )

#process arguments
while (( $# > 0 ))
do
  case "${1}" in
    --*)
      key=`echo ${1} | sed -e "s/--//"`
      shift
      ;;
    *)
      ((++argc))
      argv["${key}"]="${1}"
      shift
      ;;
  esac
done

#validate arguments
if [[ argc -ne ${#argvalidator[@]} ]]; then
  printf "wrong number of arguments (given ${argc}, expected ${#argvalidator[@]})\n"
  exit -1
fi

for key in ${!argvalidator[@]} ; do 
  if [[ ! ${argv[${key}]} =~ ${argvalidator[${key}]} ]]; then
     printf "${key}'s format is ${argvalidator[${key}]}.\n"
     exit -2
  fi
done

#eof

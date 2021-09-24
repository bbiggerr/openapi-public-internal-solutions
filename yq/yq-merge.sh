#!/bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -p|--public)
      PUBLIC="$2"
      shift # past argument
      shift # past value
      ;;
    -i|--internal)
      INTERNAL="$2"
      shift # past argument
      shift # past value
      ;;
    -o|--output)
      OUTPUT="$2"
      shift # past argument
      shift # past value
      ;;
    -t|--output-title)
      TITLE="$2"
      shift # past argument
      shift # past value
      ;;
    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL[@]}" # restore positional parameters

# Copy public file
COPY=$PUBLIC-copy
cat ${PUBLIC} > ${COPY}

# Update title of output file
if [[ ${TITLE} != "" ]]; then
  TITLE=$TITLE yq e -i '.info.title = strenv(TITLE)' ${COPY}
fi

# Add internal `*.description` text (excluding array values) to existing, public counterparts in the public definition
for LINE in $(yq e -o=p ${INTERNAL} | grep '[^0-9].description' | awk -F ' = ' '{print "."$1}'); do
  if [[ `yq e "${LINE}" ${COPY}` != null ]]; then
    printf -v TEXT "**INTERNAL**\n`yq e "${LINE}" ${INTERNAL}`\n\n**PUBLIC**\n"
    TEXT=$TEXT yq e -i "${LINE} = strenv(TEXT) + ${LINE}" ${COPY}
  fi
done

# Merge definitions
yq ea 'select(fi == 0) *+ select(fi == 1)' ${INTERNAL} ${COPY} > ${OUTPUT}

# Clean up
rm ${COPY}

echo
echo Files merged to ${OUTPUT}
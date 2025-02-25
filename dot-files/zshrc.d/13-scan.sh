
scan () {
  correspondant=$1
  scan_source=$2
  date=$3

  if [ -z "$correspondant" ]; then
    echo "Enter correspondant:"
    read correspondant
  fi

  if [ -z "$scan_source" ]; then
    echo "Enter source (Flatbed/ADF/ADF Duplex):"
    read scan_source
  fi

  if [ -z "$date" ]; then
    echo "Enter date (YYYY-MM-DD):"
    read date
  fi

  fname="$date-$correspondant.pdf"
  dest="/home/ahal/Documents/Scanned Documents"

  echo "Scanning to $dest/$fname using $scan_source"
  echo "Press Enter to begin"
  read

  WORKDIR=`mktemp -d`
  pushd $WORKDIR
  scanimage --device-name="airscan:e1:Canon MF260 II Series" --format tiff --batch --source="$scan_source" --resolution 150
  convert *.tif "$fname"
  mv "$fname" "$dest"
  popd

  rm -rf $WORKDIR
}

BEGIN { FS="," print "Header line"} # FS - Field seperator, in case it's not " "

/pattern/ {action}
/produce/ {print $2}
$3>1 {print $1}

END {print "Ending line"}

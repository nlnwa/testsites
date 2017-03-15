#!/bin/bash
sites=$NUMBER_OF_SITES
#sites=5000
i=1
start_time=$(date +%s%3N)
while [[ $i -le $sites ]]; do
  mkdir /var/www/html/test/$i.dev
  echo "<!DOCTYPE html>
<html lang='en'>
<head>
<meta charset="UTF-8">
</head>
<h1>HELLO WORLD!</h1>
<script>
function getInt(min, max) {
        return Math.floor(Math.random() * (max - min) ) + min;
} function makeid() {
        var text = 'foo';
        var possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        for( var i=0; i < 8; i++ )text += possible.charAt(Math.floor(Math.random() * possible.length));
        return text;
} var link = document.createElement('a');
link.setAttribute('href', makeid());
link.innerHTML = 'Hello World!';
document.body.appendChild(link);
</script>
</body>
</html>
" >> /var/www/html/test/$i.dev/index.html
  echo -ne "Antall websider generert: "$i"\r"
  i=$[$i+1]
done
echo ""

mkdir /var/www/html/test/0.dev

echo "<!DOCTYPE html>
<html lang='en'>
<head>
<meta charset="UTF-8">
</head>
<body>" >> /var/www/html/test/0.dev/index.html
i=1

while [[ $i -le $sites ]];do
  echo "<a href="http://$i.dev">$i.dev</a>" >> /var/www/html/test/0.dev/index.html
  echo -ne "Generating index.html... : " $i"\r"
  i=$[$i+1]
done
echo ""
echo "</body>
</html>"  >> /var/www/html/test/0.dev/index.html

stop_time=$(date +%s%3N)
totaltime=$((stop_time - start_time))
echo "time in ms: "$totaltime

#!/bin/bash
sites=$NUMBER_OF_SITES
domain_depth=$DOMAIN_DEPTH
i=1
while [[ $i -le $sites ]]; do
  mkdir /var/www/html/test/a$i.com
#creating index.html
  echo "
<!DOCTYPE html>
  <html lang='en'>
    <head>
      <meta charset="UTF-8">
    </head>
    <body>
    <h1>HELLO WORLD!</h1>
    <a href='http://a$i.com'/>LINK TO ROOT</a>
    <img src='http://static.com/apache-icon.gif'/>
    <img src='http://redirect.com/apache-icon.gif'/>
    <img src='http://static.com/apache-icon.gif'/>
    <img src='http://static.com/not-found.gif'/>
    <img src='http://static.com/bigpic.png'/>
      <script>
//Function for creating 'random' pages.
        function makeid() {
          var text = window.location.pathname;
          if (text.length <=1) {
            random='foo'
          } else {
            var random=''
          }
          var possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
          for( var i=0; i < 1; i++ )random += possible.charAt(Math.floor(Math.random() * possible.length));
          return text+random;
        } 
        
        getlink=makeid();
//limit depth
        if (getlink.length-5 < $domain_depth) {
          var link = document.createElement('a');
          link.setAttribute('href', getlink);
          link.innerHTML = 'Hello World!';
          document.body.appendChild(link);
//unlimited depth (if domain_depth == 0)
        } else if ($domain_depth == 0) {
          var link = document.createElement('a');
          link.setAttribute('href', getlink);
          link.innerHTML = 'Hello World!';
          document.body.appendChild(link);
        }
//add link to self
        var link = document.createElement('a');
        link.setAttribute('href', window.location.pathname);
        link.innerHTML = 'LINK TO SELF';
        document.body.appendChild(link);
        //window.location.href = 'http://redirect.com/apache-icon.gif';
      </script>
    </body>
  </html>
  " >> /var/www/html/test/a$i.com/index.html
  echo -ne "Generating websides: "$i" of $sites \r"
  i=$[$i+1]
done
echo ""

#0.com
echo "Generating a0.com/index.html"
i=1
mkdir /var/www/html/test/a0.com
echo "
<!DOCTYPE html>
  <html lang='en'>
    <head>
      <meta charset="UTF-8">
    </head>
    <body>
  " >> /var/www/html/test/a0.com/index.html


while [[ $i -le $sites ]];do
  echo "<a href="http://a$i.com">a$i.com</a>" >> /var/www/html/test/a0.com/index.html
  i=$[$i+1]
done

echo "
    </body>
  </html>"  >> /var/www/html/test/a0.com/index.html

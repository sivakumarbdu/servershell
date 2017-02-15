 echo "Running rails module"

 install_bundler() {
 	echo "installing bundler"
 	gem install bundler
 }

install_rails() {
	gem=$(gem --version | wc -l)
	  if [ "$gem" -eq "1" ]
    then
    	install_bundler
    	gem install --force rails -v $RAILS_VERSION
    else
    	install_bundler
    	gem install --force rails -v $RAILS_VERSION
  fi

  if [ "$?" -eq "0" ]
  	then
  		echo "rails installed successfully"
  	else
  		echo "could not install rails"
  fi
}

install_rails
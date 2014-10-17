Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

exec { 'add-nodesource-repo':
	command => "curl -sL https://deb.nodesource.com/setup | sudo bash -",
}

exec { 'apt-update':
    command => "/usr/bin/apt-get update",
    onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
}

# run apt-get upgrade
exec { 'apt-upgrade':
  command => "/usr/bin/apt-get upgrade -y",
  require => Exec['apt-update'],
}

# install nodejs
exec { 'install nodejs': command => 'apt-get install -y nodejs', require => Exec['apt-upgrade'], }
# install cordova
exec { 'install cordova': command => 'npm install -g cordova', require => Exec['install nodejs'], }
# install Android SDK
exec { 'instal android sdk': command => 'wget http://dl.google.com/android/android-sdk_r23.0.2-linux.tgz || tar xzvf android-sdk_r23.0.2-linux.tgz', }

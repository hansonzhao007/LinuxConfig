wget -c https://www.dropbox.com/s/em961mnesbyqsxi/jdk-8u181-linux-x64.tar.gz?dl=0 -O jdk.tar.gz

mkdir ~/program/usr/lib/jvm
mv jdk.tar.gz ~/program/usr/lib/jvm/

mkdir ~/program/usr/lib/jvm/java

tar zxvf ~/program/usr/lib/jvm/jdk.tar.gz -C ~/program/usr/lib/jvm/java --strip-components 1

rm ~/program/usr/lib/jvm/jdk.tar.gz

echo "export JAVA_HOME=${HOME}/program/usr/lib/jvm/java" >> ~/.installed_package
echo "export PATH=${HOME}/program/usr/lib/jvm/java/bin:$PATH" >> ~/.installed_package

source ~/.installed_package






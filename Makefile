.PHONY: all libs semphy programs clean install

# Copying autoconf style
PACKAGE_NAME=FastML
PACKAGE_VERSION=3.1

all: libs programs

debug: libs.debug

%: libs.% programs.%
	echo $@

libs: libs.all

programs: programs.all

programs.all: libs
programs.debug: libs.debug

semphy: programs.semphy

install: programs.install

programs.install programs.all semphy: libs

clean: libs.clean programs.clean

libs.%:
	+cd libs;make $(*)

programs.%:
	+cd programs;make $(*)

tags: libs/*/*.cpp libs/*/*.h programs/*/*.h programs/*/*.cpp
	etags --members --language=c++ $^ 

dist:
	mkdir ${PACKAGE_NAME}-${PACKAGE_VERSION}
	cp -R -t ${PACKAGE_NAME}-${PACKAGE_VERSION} debian libs programs Makefile README
	tar czvf ${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.gz ${PACKAGE_NAME}-${PACKAGE_VERSION}
	rm -rf ${PACKAGE_NAME}-${PACKAGE_VERSION}

release: dist
	vagrant up
	vagrant provision
	vagrant ssh -c "tar xzvf /vagrant/${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.gz"
	vagrant ssh -c "cd ${PACKAGE_NAME}-${PACKAGE_VERSION} && dpkg-buildpackage -uc -us -rfakeroot"
	vagrant halt

#
#	Provides packages for the sea-console live image.
#
%packages
#
#	To install
#
	@fedora-packager
	fas
	gcc
	git
	rpmlint 
	rpmdevtools 
	rpm-build 
	koji
	koji-builder
	mock
	auto-buildrequires
	livecd-tools
	spin-kickstarts
	createrepo
%end

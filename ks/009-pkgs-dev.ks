#
#	Provides packages for the sea-console live image.
#
%packages
#
#	To install
#
	@fedora-packager
	gcc
	git
	#rpmlint git rpmdevtools rpm-build koji koji-builder mock auto-buildrequires
	livecd-tools
	spin-kickstarts
%end

#
### use gmake
#
# Deploy constants
#
SOURCE=/home/psmith/NAS/Programming/Websites-source/courseguide/
TARGET=/home/psmith/NAS/Programming/Websites-live/courseguide.info/
BOOKS=business705
#

.PHONY: books $(BOOKS)

books: $(BOOKS)

$(BOOKS):
	$(MAKE) -C $@

deploy:
	echo Deploying the ROOT site locally
	cp    $(SOURCE)/*.html  $(TARGET)
	cp    $(SOURCE)/favicon.ico $(TARGET)
	cp -R $(SOURCE)/css         $(TARGET)

	echo Deploying the BUSINESS705  site locally
	rsync -v -r -c -p -t $(SOURCE)/business705/_book/ $(TARGET)/business705
	rsync -v -r -c -p -t $(SOURCE)/business705/images $(TARGET)/business705

	echo Deploying the site to AWS
	#s3cmd sync -P --guess-mime-type --delete-removed  $(TARGET)  s3://www.courseguide.info/
	aws s3 sync $(TARGET)  s3://www.courseguide.info/  --delete --only-show-errors

	# echo Fix MIME types
	# sh Scripts/fixMetaData.sh


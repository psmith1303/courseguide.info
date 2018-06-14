aws s3 cp \
      --exclude "*" \
      --include "*.css" \
      --content-type="text/css"  \
      --metadata-directive="REPLACE" \
      --recursive \
       s3://www.courseguide.info/ \
       s3://www.courseguide.info/

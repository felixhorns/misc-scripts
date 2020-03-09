# Convert image from 16-bit to 8-bit encoding.
# In this example, image is TIF, but this may work for other formats (untested).
# Uses the convert and mogrify tools from the ImageMagick suite of tools.
# Note that if you do this on an 8-bit image, it gets messed up.

# Convert 16-bit to 8-bit image
convert orig.tif -evaluate multiply 16 -depth 8 orig-8bit.tif

# Batch convert 16-bit to 8-bit image
# Output images keep their original names and are placed in the output path.
mogrify -path output/ -evaluate multiply 16 -depth 8 *

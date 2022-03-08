Pkg.add(["FileIO", "ImageMagick", "ImageIO"])

using Images, FileIO
img_path = "Mannheim_quadrate.png"
img = load(img_path)

typeof(img)

size(img)

[234, 1413,1]

img[500,500]

using Random

img = rand(5,5)

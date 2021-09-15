"""
Get the contour from an image that contains a watermark
"""

import argparse
import cv2
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

  

if __name__ == "__main__":
    parser = parser = argparse.ArgumentParser(description='Get the contour from an image that contains a watermark')
    parser.add_argument("-i", "--image", help="Path of the image you want to display", type=str, required=True)
    args = parser.parse_args()
    path = Path(args.image)
    image = cv2.imread(args.image, 0)
    rows, cols = image.shape
    for row in range(rows):
        for col in range(cols):
            value = image[row][col]
            if 80 < value < 120:
                image[row][col] = 0
            else:
                image[row][col] = 255
    outfile = f"contours/{path.name.strip()}"
    
    result = cv2.imwrite(outfile, image)
    if not result:
        print("Something went wrong ...")
    print(f"Saved contour image at {outfile}")
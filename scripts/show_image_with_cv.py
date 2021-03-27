"""
Display an image with opencv. Press a key to exit the program
"""

import argparse

import cv2
  

if __name__ == "__main__":
    parser = parser = argparse.ArgumentParser(description='Show an image with opencv    ')
    parser.add_argument("-i", "--image", help="Path of the image you want to display", type=str, required=True)
    args = parser.parse_args()
    print(f"Launching window for {args.image}")
    image = cv2.imread(args.image) 
  
    # Output img with window name as 'image'
    cv2.imshow('image', image)
    # Exit on keyboard press
    cv2.waitKey(0)
    cv2.destroyAllWindows()
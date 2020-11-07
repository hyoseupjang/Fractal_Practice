import numpy as np
from PIL import Image
xres,yres=np.fromfile('data.dat',dtype=np.int32,count=2,offset=0)
data=np.fromfile('data.dat',dtype=np.int32,offset=8)
print('File loaded...')
data=np.array(data.reshape(yres,xres),dtype=np.uint8)
print('Converted to uint8... Rendering. ')
Image.fromarray(data,'L').save('output.png')
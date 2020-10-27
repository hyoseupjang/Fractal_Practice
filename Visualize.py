import numpy as np
from PIL import Image
data=np.fromfile('data.dat',dtype=np.int32)
print('File loaded...')
data=np.array(data.reshape(80000,120000),dtype=np.uint8)
print('Converted to uint8... Rendering. ')
Image.fromarray(data,'L').save('output.png')
# Fractal_Practice
Just for(tran) practice. 

![Sample_Mandelbrot](./Sample/Mandelbrot.png)

## How to compile. 
You can use your favorite compiler. Before you compile, change thread number 20 to appropriate number for your system. This code dosen't support parallelization for multi-node system. 

### With GCC Fortran
gfortran fractal.f90 -o fractal.bin -fopenmp

### With Intel Fortran
ifort fractal.f90 -o fractal.bin -qopenmp

### Run Binary
./fractal.bin #This will create "data.dat" fortran array binary file. 

### Visualize Image
Use Visualize.ipynb notebook.
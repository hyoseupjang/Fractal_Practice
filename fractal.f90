PROGRAM FRACTAL
        IMPLICIT NONE
        INTEGER X,Y,I,ITER_MAX,XRES,YRES,MARKER
        REAL XMIN,XMAX,YMIN,YMAX,THRESHOLD
! X Part=Real, Y Part=Imagenary, I Max iter. 
        COMPLEX ZN,C
        PARAMETER(ITER_MAX=255,XMIN=-2,XMAX=1,YMIN=-1,YMAX=1,XRES=60000,YRES=40000,THRESHOLD=1024)
        INTEGER Z_ARRAY(XRES,YRES)

        Z_ARRAY=ITER_MAX ! Initialize Z_array as max iter. 
        !$OMP PARALLEL DEFAULT(PRIVATE) SHARED(Z_ARRAY) NUM_THREADS(20)
        !$OMP DO SCHEDULE(DYNAMIC)
        DO X=1,XRES
                DO Y=1,YRES
! Initialize ZN as 0, C to it's complexplain.  
                        ZN=CMPLX(0,0)
                        C=CMPLX(XMIN+(XMAX-XMIN)*X/XRES,YMIN+(YMAX-YMIN)*Y/YRES)
                        DO I=0,ITER_MAX
                                ZN=(ZN+C)**2 !Mandelbrot
                                !ZN=(ABS(REAL(ZN))+CMPLX(0,1)*ABS(AIMAG(ZN)))**2+C !Burning ship
                                IF (ABS(ZN)>THRESHOLD) THEN
                                        Z_ARRAY(X,Y)=I
                                        GOTO 110
                                END IF
                        END DO
110                     CONTINUE
                END DO
        END DO
        !$OMP END DO NOWAIT
        !$OMP END PARALLEL
        INQUIRE(IOLENGTH=MARKER) Z_ARRAY
        OPEN(10,file="data.dat",form="unformatted",access='stream')
        WRITE(10)MARKER,Z_ARRAY,MARKER
        CLOSE(10)
        END PROGRAM FRACTAL

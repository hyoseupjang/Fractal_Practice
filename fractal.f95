PROGRAM FRACTAL
    IMPLICIT NONE
    INTEGER X,Y,I,ITER_MAX,XRES,YRES
    REAL XMIN,XMAX,YMIN,YMAX,THRESHOLD
    COMPLEX ZN,C
    PARAMETER (ITER_MAX=255,XMIN=-2,XMAX=1,YMIN=-1,YMAX=1,XRES=90000,YRES=60000,THRESHOLD=4096)
    INTEGER Z_ARRAY(XRES,YRES)
    WRITE(*,*)'Initialize array... '
    Z_ARRAY=ITER_MAX
    WRITE(*,*)'Calculating... '
    !$OMP PARALLEL DEFAULT(PRIVATE) SHARED(Z_ARRAY) NUM_THREADS(20)
    !$OMP DO SCHEDULE(DYNAMIC,1000)
    DO Y=1,YRES
        DO X=1,XRES
            ZN=CMPLX(0,0)
            C=CMPLX(XMIN+(XMAX-XMIN)*X/XRES,YMIN+(YMAX-YMIN)*Y/YRES)
            DO I=0,ITER_MAX
                ZN=(ZN+C)**2 !Mandelbrot
                !ZN=(ABS(REAL(ZN))+CMPLX(0,1)*ABS(AIMAG(ZN)))**2+C !Burning ship
                IF (ABS(ZN)>THRESHOLD)THEN
                    Z_ARRAY(X,Y)=I
                    GOTO 110
                END IF
            END DO
110         CONTINUE
        END DO
    END DO
    !$OMP END DO NOWAIT
    !$OMP END PARALLEL
    WRITE(*,*)'Write file...'
    OPEN(10,file="data.dat",FORM="unformatted",ACCESS='stream')
    WRITE(10)XRES,YRES,Z_ARRAY
    CLOSE(10)
END PROGRAM FRACTAL

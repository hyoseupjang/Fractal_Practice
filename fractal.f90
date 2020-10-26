PROGRAM FRACTAL
        IMPLICIT NONE
        INTEGER X,Y,I,ITER_MAX,XRES,YRES,THREAD,CHUNKSIZE
        REAL XMIN,XMAX,YMIN,YMAX,THRESHOLD
! X Part=Real, Y Part=Imagenary, I Max iter. 
        COMPLEX ZN,C
        PARAMETER(ITER_MAX=2550,XMIN=-2,XMAX=-1.5,YMIN=-0.2,YMAX=0.2,XRES=50000,YRES=40000,THRESHOLD=1024)
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
                                !ZN=(ZN+C)**2
                                !ZN=(ZN+C)**(5)
                                !ZN=ZN**2+0.19*ZN**3+C
                                ZN=(ABS(REAL(ZN))+CMPLX(0,1)*ABS(AIMAG(ZN)))**2+C
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

        
        PRINT*,Z_ARRAY
        END PROGRAM FRACTAL

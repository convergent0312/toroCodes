*
C       Purpose: to solve the Riemann problem exactly
C                for the time dependent and 1D
C                Euler equation for ideal gas
*
        PROGRAM exact

            IMPLICIT NONE
*
C           Declaration of variables
*
            INTEGER I, CELLS
            REAL GAMMA, G1, G2, G3, G4, G5, G6, G7, G8
            REAL DL, UL, PL, CL, DR, UR, PR, CR 
            REAL DIAPH, DOMLEN, DS, DX, PM, MPA, PS, S
            REAL TIMEOUT, UM, US, XPOS

            COMMON /GAMMAS/ GAMMA,G1,G2,G3,G4,G5,G6,G7,G8
            COMMON /STATES/ DL, UL, PL, CL, DR, UR, PR, CR

            OPEN(UNIT=1,FILE='case4.ini',STATUS='unknown')

            READ(1,*) DOMLEN
            READ(1,*) DIAPH
            READ(1,*) CELLS
            READ(1,*) GAMMA
            READ(1,*) TIMEOUT
            READ(1,*) DL
            READ(1,*) UL
            READ(1,*) PL
            READ(1,*) DR
            READ(1,*) UR
            READ(1,*) PR
            READ(1,*) MPA

            CLOSE(1)

* 
C compute gamma related constants
*

            G1 = (GAMMA-1.0)/(2.0*GAMMA)
            G2 = (GAMMA+1.0)/(2.0*GAMMA)
            G3 = 2.0*GAMMA/(GAMMA-1.0)
            G4 = 2.0/(GAMMA-1.0)
            G5 = 2.0/(GAMMA+1.0)
            G6 = (GAMMA - 1.0) / (GAMMA + 1.0)
            G7 = (GAMMA - 1.0) / 2.0
            G8 = GAMMA - 1.0

* 
C compute sound speeds
*

            CL = SQRT(GAMMA*PL/DL)
            CR = SQRT(GAMMA*PR/DR)

* 
C test the pressure positivity condition
*
            IF(G4*(CL+CR).LE.(UR-UL)) THEN

* 
C initial data shows vacuum is generated
C program stopped
*
                WRITE(6,*)
                WRITE(6,*)'***Vacuum is generated by data***'
                WRITE(6,*)'***Program stopped***'
                WRITE(6,*) 
                STOP 
            ENDIF
* 
C exact solution for pressure and velocity in star region is found
*
            CALL STARPU(PM,UM,MPA)
            DX = DOMLEN/REAL(CELLS)


* 
C Complete solution at times TIMEOUT is found
*
            OPEN(UNIT=2,FILE='case4.out',STATUS='UNKNOWN')

            DO 10 I = 1, CELLS
                XPOS = (REAL(I) - 0.5)*DX
                S    = (XPOS - DIAPH)/TIMEOUT

* 
C Solution at point (X,T) = (XPOS - DIAPH,TIMEOUT)
C is found
*
            CALL SAMPLE(PM,UM,S,DS,US,PS)

* 
C Exact solution profiles are written to exact.out
* 

            WRITE(2,20) XPOS,DS,US,PS/MPA,PS/DS/G8/MPA
  10        CONTINUE
            CLOSE(2)
  20        FORMAT(5(F14.6,2X))

        
        END PROGRAM exact

*
*----------------------------------------------------------------------*
*

        SUBROUTINE STARPU(P,U,MPA)

            IMPLICIT NONE
*
C           Purpose: to compute the solution of pressure and velocity
C           in the star region
*

*
C           Declaration of variables
*
            INTEGER I, NRITER
            REAL DL, UL, PL, CL, DR, UR, PR, CR
            REAL CHANGE, FL, FLD,FR,FRD, P, POLD, PSTART
            REAL TOLPRE, U, UDIFF, MPA

            COMMON /STATES/ DL, UL, PL, CL, DR, UR, PR, CR
            DATA TOLPRE, NRITER/1.0E-06, 20/

* 
C Guessed value PSTART is required 
*
            CALL GUESSP(PSTART)
            POLD = PSTART
            UDIFF = UR - UL
            WRITE(6,*)'--------------------------------------------'
            WRITE(6,*)'     Iteration number        Change         '
            WRITE(6,*)'--------------------------------------------'

            DO 10 I = 1,NRITER
                CALL PREFUN(FL,FLD, POLD, DL, PL, CL)
                CALL PREFUN(FR,FRD, POLD, DR, PR, CR)
                P = POLD - (FL+FR+UDIFF)/(FLD + FRD)
                CHANGE = 2.0*ABS((P-POLD)/(P+POLD))
                WRITE(6,30) I, CHANGE
                IF(CHANGE.LE.TOLPRE) GOTO 20
                IF(P.LT.0.0) P = TOLPRE
                POLD = P
 10         CONTINUE
            WRITE(6,*)'Divergence in Newton-Raphon iteration'
 20         CONTINUE

* 
C Compute velocity in Star Region
*
            U = 0.5*(UL+UR+FR-FL)
            WRITE(6,*)'--------------------------------------------'
            WRITE(6,*)'     Pressure          Velocity             ' 
            WRITE(6,*)'--------------------------------------------'
            WRITE(6,40)P/MPA, U 
            WRITE(6,*)'--------------------------------------------'

 30         FORMAT(5X, I5, 15X, F12.7)
 40         FORMAT(2(F14.6,5X))
            RETURN 
        END SUBROUTINE STARPU

*
*----------------------------------------------------------------------*
*

        SUBROUTINE GUESSP(PM)

            IMPLICIT NONE
*
C           Purpose: provide guess pressure PM in the Star Region
C                    Sec 9.5 chap 1
*

*
C           Declaration of variables
*

            REAL DL,UL,PL,CL,DR,UR,PR,CR
            REAL GAMMA,G1,G2,G3,G4,G5,G6,G7,G8
            REAL CUP,GEL,GER,PM,PMAX,PMIN,PPV,PQ
            REAL PTL,PTR,QMAX,QUSER,UM

            COMMON /GAMMAS/ GAMMA,G1,G2,G3,G4,G5,G6,G7,G8
            COMMON /STATES/ DL,UL,PL,CL,DR,UR,PR,CR

            QUSER=2.0

            CUP  = 0.25*(DL + DR)*(CL + CR)
            PPV  = 0.5*(PL + PR) + 0.5*(UL - UR)*CUP
            PPV  = AMAX1(0.0,PPV)
            PMIN = AMIN1(PL, PR)
            PMAX = AMAX1(PL, PR)
            QMAX = PMAX/PMIN

            IF(QMAX.LE.QUSER.AND.(PMIN.LE.PPV.AND.PPV.LE.PMAX))THEN
*
C               Select PVRS Riemann solver
*
                PM = PPV 
            ELSE
                IF(PPV.LT.PMIN)THEN
*
C                   Select Two-Rarefaction Riemann solver
*
                    PQ  = (PL/PR)**G1
                    UM  = (PQ*UL/CL+UR/CR+G4*(PQ-1.0))/(PQ/CL+1.0/CR)
                    PTL = 1.0+G7*(UL-UM)/CL
                    PTR = 1.0+G7*(UM-UR)/CR
                    PM  = 0.5*(PL*PTL**G3+PR*PTR**G3)
                ELSE
*
C                   Select Two-Shock Riemann solver with
C                   PVRS as estimate
*
                    GEL = SQRT((G5/DL)/(G6*PL+PPV))
                    GER = SQRT((G5/DR)/(G6*PR+PPV))
                    PM  = (GEL*PL+GER*PR-(UR-UL))/(GEL+GER)
                ENDIF
            ENDIF

            RETURN 
        END SUBROUTINE GUESSP

*
*----------------------------------------------------------------------*
*
        SUBROUTINE PREFUN(F, FD, P, DK, PK, CK)
*
C       Purpose: evaluate pressure functions FL and FR 
C                in exact Riemann solver
*
        IMPLICIT NONE
*
C       Declaration of variables
*

        REAL AK,BK,CK,DK,F,FD,P,PK,PRAT,QRT
        REAL GAMMA,G1,G2,G3,G4,G5,G6,G7,G8

        COMMON /GAMMAS/ GAMMA,G1,G2,G3,G4,G5,G6,G7,G8 

        IF(P.LE.PK) THEN
*
C           Rarefaction wave
*
            PRAT = P/PK
            F    = G4*CK*(PRAT**G1 - 1.0)
            FD   = (1.0/(DK*CK))*PRAT**(-G2)
        
        ELSE
*
C           Shock wave
*
            AK  = G5/DK
            BK  = G6*PK
            QRT = SQRT(AK/(BK+P))
            F   = (P-PK)*QRT
            FD  = (1.0-0.5*(P-PK)/(BK+P))*QRT

        ENDIF

        RETURN

        END SUBROUTINE PREFUN
*
*----------------------------------------------------------------------*
*
        SUBROUTINE SAMPLE(PM,UM,S,D,U,P)
*
C       Purpose: sample the solution throughout the wave pattern. 
C                Pressure PM and velocity UM in Star Region are known. 
C                Sampling performed in terms of S = X/T
C                Sampled values are D, U, P
*

        IMPLICIT NONE
*
C       Declaration of variables
*
        REAL    DL, UL, PL, CL, DR, UR, PR, CR
        REAL    GAMMA,G1,G2,G3,G4,G5,G6,G7,G8
        REAL    C,CML,CMR,D,P,PM,PML,PMR,S
        REAL    SHL,SHR,SL,SR,STL,STR,U,UM
     
        COMMON /GAMMAS/ GAMMA,G1,G2,G3,G4,G5,G6,G7,G8
        COMMON /STATES/ DL,UL,PL,CL,DR,UR,PR,CR

        IF(S.LE.UM) THEN 
*
C           Sampling points lie to the left of the contact 
*      
            IF(PM.LE.PL) THEN
*
C               Left rarefaction
*
                SHL = UL - CL
                
                IF(S.LE.SHL) THEN
*
C                   Sample point is left of data state
*
                    D = DL
                    U = UL
                    P = PL 
                ELSE
                    CML = CL*(PM/PL)**G1
                    STL = UM - CML 

                    IF(S.GT.STL) THEN 
*
C                       Sampled point is Star Left state
*
                        D = DL*(PM/PL)**(1.0/GAMMA)
                        U = UM
                        P = PM 
                    ELSE 
*
C                       Sampled point is inside left fan
*   
                        U = G5*(CL + G7*UL + S)
                        C = G5*(CL + G7*(UL - S))
                        D = DL*(C/CL)**G4
                        P = PL*(C/CL)**G3
                    ENDIF
                ENDIF
            ELSE
*
C               Left shock
*
                PM = PM/PL
                SL = UL - CL*SQRT(G2*PML + G1) 

                IF(S.LE.SL)THEN
*
C                   Sampled point is left data state
*
                    D = DL
                    U = UL
                    P = PL
                ELSE
*
C                   Sampled point is Star Left state
*
                    D = DL*(PML + G6)/(PML*G6 + 1.0)
                    U = UM
                    P = PM
                ENDIF
            ENDIF
        ELSE

*
C           Sampling point lies to the right of the contact
C            discontinuity
*
            IF(PM.GT.PR)THEN
*
C               Right shock
*
                PMR = PM/PR
                SR = UR + CR*SQRT(G2*PMR + G1)

                IF(S.GE.SR)THEN
*
C                   Sampled point is right data state
*
                    D = DR
                    U = UR
                    P = PR
                ELSE
*
C                   Sampled point is Star Right state
*
                    D = DR*(PMR + G6)/(PMR*G6 + 1.0)
                    U = UM
                    P = PM
                ENDIF
            ELSE

*
C               Right rarefaction
*
                SHR = UR + CR
                IF(S.GE.SHR)THEN
*
C                   Sampled point is right data state
*
                    D = DR
                    U = UR
                    P = PR
                ELSE
                    CMR = CR*(PM/PR)**G1
                    STR = UM + CMR

                    IF(S.LE.STR)THEN
*
C                       Sampled point is Star Right state
*
                        D = DR*(PM/PR)**(1.0/GAMMA)
                        U = UM
                        P = PM
                    ELSE

*
C                       Sampled point is inside left fan
*
                        U = G5*(-CR + G7*UR + S)
                        C = G5*(CR - G7*(UR - S))
                        D = DR*(C/CR)**G4
                        P = PR*(C/CR)**G3
                    ENDIF
                ENDIF
            ENDIF

        ENDIF
        RETURN
        END SUBROUTINE SAMPLE
*
*----------------------------------------------------------*
*






















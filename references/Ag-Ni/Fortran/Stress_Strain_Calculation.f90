c Stress Strain Calculation – Fortran file that reads the LAMMPS dump files and calculates the stress and strain in the model

c--------------------------------i--------------------------------------
 program dislocation density and stress calculations
c----------------------------------------------------------------------
 implicit none
 
 character*12 inhist,vlfile
 
 real cna
 integer natom,ii,nframe,dummi,nvol,hcp_num,hcp0
 integer timestep,iframe1,iframe2,iframe,j,i,icentro,istart,k
 double precision xcell,ycell,zcell,xx,yy,zz,yytemp1,yytemp2
 double precision zcell0,zcellf,eps,zzcell
 double precision Str_ave,vol_ave,rho,Vhcp
 double precision xmax,xmin,ymax,ymin,zmax,zmin,ystep
 double precision x,y,z,f
c double precision, pointer :: x(:),y(:),z(:),f(:)
c integer, pointer :: cna(:)

c-------Reads in the user input file-------------------------------
 write(vlfile,'(a10)') 'stress.dat'
 open(unit=10,file=vlfile,status='unknown')
 read(*,*) istart
 read(*,*) icentro
 read(*,*) iframe1
 read(*,*) iframe2
 
  do ii=istart,icentro
 if (ii.lt.10) write(inhist,'(a5,i1,a4)')'coord',ii,'.xyz'
 if (ii.ge.10 .and. ii.lt.100)then
 write(inhist,'(a5,i2,a4)')'coord',ii,'.xyz'
 endif
 if (ii.ge.100)write(inhist,'(a5,i3,a4)')'coord',ii,'.xyz' 
c-------Lammps output file is 9, reads in lmps header-------------- 
 write(*,*) '* Opening dump file:',inhist
 write(*,*) '* number of frames:',iframe2-iframe1+1
 open(9,file=inhist,status='old',form='formatted')
 iframe=0
c---------------------------------------------------------------------
c----------This begins the frame by frame reading section-------------

9999 continue
 iframe=iframe+1
 if(iframe.lt.iframe1) go to 9999
 if(iframe.gt.iframe2) go to 500 
 
  write(*,*) '**Reading Frame=',iframe
 read(9,*,end=999)
 read(9,*,end=999) timestep
 read(9,*,end=999)
 read(9,*,end=999) natom
 read(9,*,end=999)
 read(9,*,end=999) xmin,xmax
 xcell=dabs(xmax-xmin)
 read(9,*,end=999) ymin,ymax
 ycell=dabs(ymax-ymin)
 read(9,*,end=999) zmin,zmax
 zcell=dabs(zmax-zmin)
 
  read(9,*,end=999)

c allocate(x(natom))
c allocate(y(natom))
c allocate(z(natom))
c allocate(f(natom))
c allocate(cna(natom))

 Str_ave=0.d0
 hcp_num=0

 do j=1,natom
 read(9,*,end=999) x,y,z,dummi,dummi,cna,f
 Str_ave=Str_ave+f
 if (cna.eq.2) hcp_num=hcp_num+1
 enddo
 
 if ((ii.eq.istart).and.(iframe.eq.iframe1)) then
 hcp0=hcp_num
 zcell0=zcell
 write(*,*) '**Initial size (nm)=',zcell0/10
 endif
 
 if ((ii.eq.icentro).and.(iframe.eq.iframe2)) then
 zcellf=zcell
 write(*,*) '**Final size (nm)=',zcellf/10
 write(*,*) '**Final strain (%)=',(zcellf-zcell0)/zcell0*100
 endif
 
c--------------------------------------------------------------------

 vol_ave=xcell*ycell*zcell
 !density
 Vhcp=dble(hcp_num-hcp0)/dble(natom)*100
 rho=(Vhcp/100)*76.2/108.4 !in nm-2
 !stress in GPa
 Str_ave=Str_ave/vol_ave*0.0001
 
 !strain
 if (zcell0.le.0) then
 write(*,*)'***error: xcell0 should be > 0***'
 stop
 endif
 zzcell=zcell
 eps=dabs(zzcell-zcell0)/zcell0
 eps=log(1+eps)*100
 write((10),'(i10.7,3f12.3,f12.5)') timestep,eps,Str_ave,Vhcp,rho
 write(*,*)'**eps=',eps,' **stress=',Str_ave,' **Vhcp(%)=',Vhcp
 
c deallocate(x,y,z,f)
 go to 9999
500 continue
 close(9)
 enddo
999 close(10)
 stop
end

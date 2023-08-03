! Fortran file that reads the LAMMPS dump file and selects x y and z 
! coordinates along with ID and type to create a smaller output file for OVITO visualization.

c----------------------------------------------------------------------
 program lammps to gz ready 
c---------------------------------------------------------------------
 implicit none
 
 character*25 inhist,snapshot
 character*4 ciframe,piframe
 
 integer natom,istart,icentro,iframe,iframe1,iframe2
 integer timestep,j,i,ii,jj,kk,nack,dumi,iii,id
 double precision xcell,ycell,zcell,xx,yy,zz
 double precision xmax,xmin,ymax,ymin,zmax,zmin
 double precision ycmax,ycmin,zcmax,zcmin,dum,ctr
 double precision, pointer :: x(:),y(:),z(:)
 integer, pointer :: ack(:),typ(:)
 
 read(*,*) istart
 read(*,*) icentro
 read(*,*) iframe1
 read(*,*) iframe2
 
 do ii=istart,icentro
 if (ii.lt.10) write(inhist,'(a5,i1,a4)')'coord',ii,'.xyz'
 if (ii.ge.10 .and. ii.lt.100)then
 write(inhist,'(a5,i2,a4)')'coord',ii,'.xyz'
 endif
 if (ii.ge.100.and.ii.lt.1000) then
 write(inhist,'(a5,i3,a4)')'coord',ii,'.xyz'
 endif
 if (ii.ge.1000) write(inhist,'(a5,i4,a4)')'coord',ii,'.xyz'
 
c-------Lammps output file is 9, reads in lmps header--------------
 write(*,*) '* Opening dump file: ',inhist
 write(*,*) '* number of frames:',iframe2-iframe1+1
 
 open(9,file=inhist,status='old',form='formatted')
 
 iframe=0
 
9999 continue
 iframe=iframe+1
 if(iframe.lt.iframe1) go to 9999
 if(iframe.gt.iframe2) go to 500
 
 iii=(ii-1)*(iframe2-iframe1+1)+iframe
 if (iii.lt.1000) write(snapshot,'(a6,i3,a5)')'coordF',iii,'.dump'
 if (iii.lt.100) write(snapshot,'(a7,i2,a5)')'coordF0',iii,'.dump'
 if (iii.lt.10) write(snapshot,'(a8,i1,a5)')'coordF00',iii,'.dump'
 if (iii.ge.1000) write(snapshot,'(a6,i4,a5)')'coordF',iii,'.dump'
 
 write(*,*)'* creating file: ',snapshot
 open(20,file=snapshot,status='unknown')
 
 read(9,*)
 read(9,*) timestep
 read(9,*)
 read(9,*) natom
 read(9,*)
 read(9,*) xmin,xmax
 xcell=dabs(xmax-xmin)
 read(9,*) ymin,ymax
 ycell=dabs(ymax-ymin)
 read(9,*) zmin,zmax
 zcell=dabs(zmax-zmin)
 read(9,*)
 
 allocate(x(natom))
 allocate(y(natom))
 allocate(z(natom))
 allocate(typ(natom))
c allocate(ack(natom))
 
 nack=0
 
 do j=1,natom
c read(9,*) xx,yy,zz,id,dumi,ctr,dum
 read(9,*) xx,yy,zz,id,dumi
c if (ctr.ne.1) then
 nack=nack+1
 x(id)=xx
 y(id)=yy
 z(id)=zz
 typ(id)=dumi
c ack(id)=ctr
c endif
 enddo
 
 !DUMP FILE header
 write(*,*)'**writing',nack,'atoms in dump frame',iframe
 write(20,'(a14)')'ITEM: TIMESTEP'
 write(20,'(i8)') timestep
 write(20,'(a21)')'ITEM: NUMBER OF ATOMS'
 write(20,'(i8)') nack
 write(20,'(a16)')'ITEM: BOX BOUNDS'
 write(20,'(2f8.3)') xmin,xmax
 write(20,'(2f8.3)') ymin,ymax
 write(20,'(2f8.3)') zmin,zmax
c write(20,'(a21)')'ITEM: ATOMS x y z ack'
 write(20,'(a21)')'ITEM: ATOMS x y z typ'
c write(20,'(a17)')'ITEM: ATOMS x y z'
 do j=1,nack
 xx=x(j)*xcell+xmin
 yy=y(j)*ycell+ymin
 zz=z(j)*zcell+zmin
c write(20,'(3f8.2)')xx,yy,zz
 write(20,'(3f8.2,i2)')xx,yy,zz,typ(j)
c write(*,*) 'id=',ack(j)
 enddo
 deallocate(x,y,z,typ)
c deallocate(x,y,z)
 close(20)
 go to 9999
 
500 continue
 close(9)

 enddo
 stop
end
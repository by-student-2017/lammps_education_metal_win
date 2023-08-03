! Fortran code that reads LAMMPS dump files and determines the force applied by the indenter in the syste

 program force_virtual
 implicit none
 integer i,j,typ,ackland,natom,k
 double precision center,forcez,forcer,r,rs,x,y,z,centro,ener
 character(len=7) inum
 double precision, pointer:: xc(:),yc(:),zc(:)
 i=0
 open(12,file='force.indent',status='unknown')
 write(12,*)'VARIABLES="delta(A)" "force(nN)"'
 
 do while (i.le.10000000)
 !open the file
 if(i.lt.10) then
 write(inum,'(i1)') i
 write(*,*)'indentF000000'//inum(1:1)//'.dump'
 open(11,file='indentF000000'//inum(1:1)//'.dump',status='old')
 open(13,file='contact_000000'//inum(1:1)//'.dump',status='new')
 elseif(i.lt.100) then
 write(inum,'(i2)') i
 write(*,*)'indentF00000'//inum(1:2)//'.dump'
 open(11,file='indentF00000'//inum(1:2)//'.dump',status='old')
 open(13,file='contact_00000'//inum(1:2)//'.dump',status='new')
 elseif(i.lt.1000) then
 write(inum,'(i3)') i
 write(*,*)'indentF0000'//inum(1:3)//'.dump'
 open(11,file='indentF0000'//inum(1:3)//'.dump',status='old')
 open(13,file='contact_0000'//inum(1:3)//'.dump',status='new')
 elseif(i.lt.10000) then
 write(inum,'(i4)') i
 write(*,*)'indentF000'//inum(1:4)//'.dump'
 open(11,file='indentF000'//inum(1:4)//'.dump',status='old')
 open(13,file='contact_000'//inum(1:4)//'.dump',status='new')
 elseif(i.lt.100000) then
 write(inum,'(i5)') i
write(*,*)'indentF00'//inum(1:5)//'.dump'
 open(11,file='indentF00'//inum(1:5)//'.dump',status='old')
 open(13,file='contact_00'//inum(1:5)//'.dump',status='new')
 elseif(i.lt.1000000) then
 write(inum,'(i6)') i
 write(*,*)'indentF0'//inum(1:6)//'.dump'
 open(11,file='indentF0'//inum(1:6)//'.dump',status='old')
 open(13,file='contact_0'//inum(1:6)//'.dump',status='new')
 elseif(i.lt.10000000) then
 write(inum,'(i7)') i
 write(*,*)'indentF'//inum(1:7)//'.dump'
 open(11,file='indentF'//inum(1:7)//'.dump',status='old')
 open(13,file='contact_'//inum(1:7)//'.dump',status='new')
 else
 write(*,*) 'overflow in number of files'
 stop
 endif
 write(13,*)'VARIABLES="x(A)" "y(A)" "z(A)"'
 read(11,*)
 center=765-dble(i)*0.01*0.005
 forcez=0.
 k=10
! natom = 415199
 natom = 7862027
 
 allocate(xc(natom))
 allocate(yc(natom))
 allocate(zc(natom))
 
 read(11,*)
 read(11,*)
 read(11,*)
 read(11,*)
 read(11,*)
 read(11,*)
 read(11,*)
 read(11,*)
 
 do j=1,natom
 read(11,*) x,y,z,typ!e,ackland,ener !in nm
 rs=x**2+(z-center)**2+y**2.
 r=sqrt(rs)
 if(r.lt.500) then
 forcer=-10.0000*(r-500)**2
 forcez=forcez+forcer*(z-center)/r !in eV/A 
 k=k+1
 xc(k)=x
 yc(k)=y
 zc(k)=z
 endif
 enddo
! if (k.ne.0) then
 forcez=forcez*1.60219 !in nN
! endif
 write(12,*) center-765,forcez
 write(13,*) k
 
  do j=1,k
 write(13,*) xc(j),yc(j),zc(j)
 enddo
 
 i=i+2500
 deallocate(xc,yc,zc)
 enddo
end program force_virtual

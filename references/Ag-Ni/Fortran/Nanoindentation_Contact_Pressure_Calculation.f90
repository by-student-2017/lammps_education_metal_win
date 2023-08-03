! Fortran code that takes the results from the Force 
! calculation for the nanoindentation and calculates the contact pressure of the indenter on the material.

 program contact
 implicit none
 integer i,j,natom
 double precision a,b,area,xmin,xmax,ymin,ymax,x,y,z
 character(len=8) inum
 
 i= 0
 open(12,file='contact.dat',status='unknown')
 write(12,*)'a(A) b(A) A(A^2)'
 
 do while (i.le.10000000)
 if(i.lt.10) then
 write(inum,'(i1)') i
 open(11,file='contact_000000'//inum(1:1)//'.dump',status='old')
 write(*,*) 'contact_000000'//inum(1:1)//'.dump'
 elseif(i.lt.10000) then
 write(inum,'(i4)') i
 open(11,file='contact_000'//inum(1:4)//'.dump',status='old')
 write(*,*) 'contact_000'//inum(1:4)//'.dump'
 elseif(i.lt.100000) then
 write(inum,'(i5)') i
 open(11,file='contact_00'//inum(1:5)//'.dump',status='old')
 write(*,*) 'contact_00'//inum(1:5)//'.dump'
 elseif(i.lt.1000000) then
 write(inum,'(i6)') i
 open(11,file='contact_0'//inum(1:6)//'.dump',status='old')
 write(*,*) 'contact_0'//inum(1:6)//'.dump' 
 elseif(i.lt.10000000) then
 write(inum,'(i7)') i
 open(11,file='contact_'//inum(1:7)//'.dump',status='old')
 write(*,*) 'contact_'//inum(1:7)//'.dump' 
 endif
 
 xmin=1000.
 xmax=-1000.
 ymin=1000.
 ymax=-1000.
 
 read(11,*)
 read(11,*) natom
 
 if (natom.eq.0) then
 xmin=0.0
 xmax=0.0
 ymax=0.0
 ymin=0.0
 else
 do j=1,natom
 read(11,*) x,y,z
 if(x.lt.xmin) xmin=x
 if(x.gt.xmax) xmax=x
 if(y.lt.ymin) ymin=y
 if(y.gt.ymax) ymax=y
 enddo
 endif
 
 a=(xmax-xmin)/2.
 b=(ymax-ymin)/2.
 area=3.141592654*a*b
 write(12,*) a,b,area
 write(*,*) 'natom=', natom,'area=',area
 close(11)
 i=i+2500
 enddo
 close(12)
end program contact

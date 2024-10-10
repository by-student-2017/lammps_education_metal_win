! Appendix H
! Fortran90 code to produce the initial ttm/md electron temperature! 
! The purpose of this Fortran code is to generate the input file where to specify
! the Te for each grid point. Each line has four numeric columns (ix,iy,iz,Te). The
! number of lines is equal to the number of specified grid points (Nx x Ny x Nz)
! where ix, iy, iz are grid point indices ranging from 0 to Nx − 1, Ny − 1, Nz − 1
! in each dimension respectively. This example is for samples cut in the middle of
! the simulation box Lx/2.
program Te
implicit none

real, dimension(1) :: T !Temperature array
real :: T_0 !Initial temperature in Kelvin
integer :: i !Increment following x
integer :: j !Increment following y
integer :: k !Increment following z
integer :: N_x !Grid point node index following x
integer :: N_y !Grid point node index following y
integer :: N_z !Grid point node index following z

print*,"Enter the value of Nx:"
read(*,*) N_x
print*,"Enter the value of Ny:"
read(*,*) N_y
print*,"Enter the value of Nz:"
read(*,*) N_z
print*,"Enter the value of T0:"

read(*,*) T_0

open(1,file='T_init')
  do i=0, N_x-1
    do j=0, N_y-1
      do k=0, N_z-1
        IF (i < N_x/2) THEN !Half space for free boundaries
          T(:) = 0 !Vacuum temperature
        ELSE
          T(:) = T_0!Atoms initial temperatures
        END IF
        write(*,*) 'Nx=', i, ', Ny=', j, ', Ny=', k, ', T0=', T,'K'
        write(1,*) i, j, k, T
      enddo
    enddo
  enddo
  close(1)
end program Te

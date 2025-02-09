# Watch
Module to compute and display the CPU and wall time elapsed at break points in a Fortran program. For example, 
compiling the main program

```fortran
program xwatch
use kind_mod , only: dp
use watch_mod, only: watch,print_elapsed_times
implicit none
integer          , parameter :: n = 5*10**7, iunit = 20
character (len=*), parameter :: xfile = "temp.bin"
real(kind=dp)                :: x(n),xchk(n)
call random_seed()
call watch("init")
call random_number(x)
call watch("random_number()")
print*,"sum(x) =",sum(x)
call watch("sum(x)")
print*,"sum(sin(x)) =",sum(sin(x))
call watch("sum(sin(x))")
open (unit=iunit,file=xfile,action="write",status="replace",form="unformatted")
write (iunit) x
close (iunit)
call watch("wrote x")
open (unit=iunit,file=xfile,action="read",status="old",form="unformatted")
read (iunit) xchk
call watch("read x")
print*,"max_diff =",maxval(abs(x-xchk))
call watch("check")
call print_elapsed_times()
end program xwatch
```
with `gfortran watch.f90 xwatch.f90` gives sample output
```
 sum(x) =   25005176.453633938     
 sum(sin(x)) =   22989252.503119886     
 max_diff =   0.0000000000000000     

                                    task    cpu_time   wall_time
                         random_number()    0.234375    0.250000
                                  sum(x)    0.031250    0.047000
                             sum(sin(x))    0.203125    0.219000
                                 wrote x    0.015625    0.234000
                                  read x    0.140625    0.172000
                                   check    0.062500    0.047000
                                   TOTAL    0.687500    0.969000
```

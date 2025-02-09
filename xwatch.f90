program xwatch
! 11/20/2021 08:15 PM driver for watch and print_elapsed_times
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

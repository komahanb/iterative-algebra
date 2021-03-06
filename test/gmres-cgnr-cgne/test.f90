!=====================================================================!
! Run gradient-based descent algorithms to solve linear algebra
!=====================================================================!

program test

  implicit none

  call check_solvers

end program test

subroutine check_solvers

  use linear_algebra
  use system
 
  implicit none  
  
  system1 : block

    integer, parameter :: npts = 1000
    real(8), parameter :: max_tol = 1.0d-8
    integer, parameter :: max_it = 100000
    real(8) :: x(npts,3), b(npts), A(npts,npts)
    integer :: iter, flag, i, j
    real(8) :: tol

    ! Solve using LU factorization
    call assemble_system1(npts, A, b, x(:,1))
    x(:,1) = solve(A,b)

    ! Solve using CGNE
    call assemble_system1(npts, A, b, x(:,2))
    call dcgne(A, b, max_it, max_tol, x(:,2), iter, tol, flag)
    print *, 'cgne', tol, iter

    ! Solve using CGNR
    call assemble_system1(npts, A, b, x(:,3))
    call dcgnr(A, b, max_it, max_tol, x(:,3), iter, tol, flag)
    print *, 'cgnr', tol, iter

    open(11, file='system1.dat')
    do i = 1, npts
       ! exact, cgne, cgnr
       write(11, *) i, x(i,1), x(i,2), x(i,3)
    end do
    close(11)

  end block system1

  system2 : block

    integer, parameter :: npts = 1000
    real(8), parameter :: max_tol = 1.0d-8
    integer, parameter :: max_it = 100000
    real(8) :: x(npts,3), b(npts), A(npts,npts)
    integer :: iter, flag, i, j
    real(8) :: tol
    complex(8) :: eigs(npts)

    ! Solve using LU factorization
    call assemble_system2(npts, A, b, x(:,1))
    x(:,1) = solve(A,b)

    ! Solve using CGNE
    call assemble_system2(npts, A, b, x(:,2))
    call dcgne(A, b, max_it, max_tol, x(:,2), iter, tol, flag)
    print *, 'cgne', tol, iter

    ! Solve using CGNR
    call assemble_system2(npts, A, b, x(:,3))
    call dcgnr(A, b, max_it, max_tol, x(:,3), iter, tol, flag)
    print *, 'cgnr', tol, iter

    open(11, file='system2.dat')
    do i = 1, npts
       ! exact, cgne, cgnr
       write(11, *) i, x(i,1), x(i,2), x(i,3)
    end do
    close(11)

  end block system2

end subroutine check_solvers

!
! Copyright (c) 2019, NVIDIA CORPORATION.  All rights reserved.
!
! Licensed under the Apache License, Version 2.0 (the "License");
! you may not use this file except in compliance with the License.
! You may obtain a copy of the License at
!
!     http://www.apache.org/licenses/LICENSE-2.0
!
! Unless required by applicable law or agreed to in writing, software
! distributed under the License is distributed on an "AS IS" BASIS,
! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
! See the License for the specific language governing permissions and
! limitations under the License.
!
module dot_acc_m
contains
   subroutine dot_acc(A, B, C, m, n)
      implicit none
      real, intent(in) :: A(m,n)
      real, intent(in) :: B(m,n)
      real, intent(inout) :: C(n)
      integer, intent(in) :: m, n
    
      real :: temp
      integer :: i, j
    
!$acc parallel loop gang private(temp) copyin(A,B) copyout(C)
      do j = 1,n
         temp = 0.0
!$acc loop vector reduction(+:temp)
         do i = 1,m
            temp = temp + A(i,j) * B(i,j)
         end do
         C(j) = temp
      end do

      return
  end subroutine dot_acc
  
end module dot_acc_m


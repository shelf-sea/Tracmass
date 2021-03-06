test_suite mod_subdomain

! test_suite for mod_subdomain
! Contains 6 tests
!  3 -> init_subdomain
!  3 -> update_subindex

SETUP
    ! Define the grid
    imt = 20; jmt = 20; km = 10

    ! Subdomain
    imindom = 5;  imaxdom = 15
    jmindom = 10; jmaxdom = 15

    ! exitType
    exitType = 1

    ! Boundary condition
    iene(1) = 4; iene(2) = 10; iene(3) = 17

    ! l_subdom
    l_subdom = .FALSE.

END SETUP

TEARDOWN
    ! This code runs immediately after each test
END TEARDOWN

TEST test_init_subdomain_1

   ! Test for init_subdomain

   PRINT *, ' * Test init_subdomain  : no subdomain '

   CALL init_subdomain

   ASSERT_EQUAL(imt, imtdom)
   ASSERT_EQUAL(jmt, jmtdom)
   ASSERT_EQUAL(imindom,1)
   ASSERT_EQUAL(jmindom,1)

END TEST

TEST test_init_subdomain_2

   ! Test for init_subdomain

   PRINT *, ' * Test init_subdomain  : subdomain (RB)'

   ! Activate subdomain
   l_subdom = .TRUE.

   CALL init_subdomain

   ASSERT_EQUAL(imt, 11)
   ASSERT_EQUAL(jmt, 6)
   ASSERT_EQUAL(iene(1),0)
   ASSERT_EQUAL(iene(2),6)
   ASSERT_EQUAL(iene(3),13)
   ASSERT_EQUAL(jens(7), 2)
   ASSERT_EQUAL(jens(8), 5)
   ASSERT_EQUAL(iene(9), 2)
   ASSERT_EQUAL(iene(10), 10)

END TEST

TEST test_init_subdomain_3

   ! Test for init_subdomain

   PRINT *, ' * Test init_subdomain  : subdomain (SB)'

   ! Activate subdomain
   l_subdom = .TRUE.

   ! Change values of imindom / imaxdom
   imindom = 15;  imaxdom = 10

   CALL init_subdomain

   ASSERT_EQUAL(imt, 16)
   ASSERT_EQUAL(imthalf1, 6)
   ASSERT_EQUAL(imthalf2, 10)
   ASSERT_EQUAL(jmt, 6)
   ASSERT_EQUAL(iene(1),10)
   ASSERT_EQUAL(iene(2),16)
   ASSERT_EQUAL(iene(3), 3)
   ASSERT_EQUAL(jens(7), 2)
   ASSERT_EQUAL(jens(8), 5)
   ASSERT_EQUAL(iene(9), 2)
   ASSERT_EQUAL(iene(10),15)

END TEST

TEST test_update_subindex_1

   INTEGER :: ji, jj

   ! Test for update_subindex
   PRINT *, ' * Test update_subindex : no subdomain'

   ! Indexes
   ji = 7; jj = 3

   CALL init_subdomain
   CALL update_subindex(ji,jj)

   ASSERT_EQUAL(ji, 7)
   ASSERT_EQUAL(jj, 3)

END TEST

TEST test_update_subindex_2

   INTEGER :: ji, jj

   ! Test for update_subindex
   PRINT *, ' * Test update_subindex : subdomain (RB)'

   ! Indexes
   ji = 7; jj = 12

   ! l_subdom
   l_subdom = .TRUE.

   CALL init_subdomain
   CALL update_subindex(ji,jj)

   ASSERT_EQUAL(ji, 3)
   ASSERT_EQUAL(jj, 3)

END TEST

TEST test_update_subindex_3

   INTEGER :: ji, jj

   ! Test for update_subindex
   PRINT *, ' * Test update_subindex : subdomain (SB)'

   ! Indexes
   ji = 2; jj = 12

   ! l_subdom
   l_subdom = .TRUE.

   ! Change values of imindom / imaxdom
   imindom = 15;  imaxdom = 10

   CALL init_subdomain
   CALL update_subindex(ji,jj)

   ASSERT_EQUAL(ji, 8)
   ASSERT_EQUAL(jj, 3)

END TEST

end test_suite

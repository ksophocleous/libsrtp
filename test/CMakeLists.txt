cmake_minimum_required(VERSION 3.1)

project(test)

list(APPEND incdirs
	"${CMAKE_CURRENT_SOURCE_DIR}/../crypto/include")

#----
add_executable(dtls_srtp_driver "dtls_srtp_driver.c" "getopt_s.c")
set_target_properties(dtls_srtp_driver PROPERTIES INCLUDE_DIRECTORIES "${incdirs}")
target_link_libraries(dtls_srtp_driver libsrtp_static)
add_test(NAME dtls_srtp_driver
	COMMAND "${EXECUTABLE_OUTPUT_PATH}/dtls_srtp_driver")

#----
add_executable(rdbx_driver "rdbx_driver.c" "getopt_s.c" "../crypto/replay/ut_sim.c")
set_target_properties(rdbx_driver PROPERTIES 
	INCLUDE_DIRECTORIES "${incdirs}"
	COMPILE_DEFINITIONS "HAVE_CONFIG_H")
target_link_libraries(rdbx_driver libsrtp_static)

add_test(NAME rdbx_driver_v
	COMMAND "${EXECUTABLE_OUTPUT_PATH}/rdbx_driver" -v)

add_test(NAME rdbx_driver_t
	COMMAND "${EXECUTABLE_OUTPUT_PATH}/rdbx_driver" -t)

#----
add_executable(replay_driver "replay_driver.c" "getopt_s.c" "../crypto/replay/ut_sim.c")
set_target_properties(replay_driver PROPERTIES 
	INCLUDE_DIRECTORIES "${incdirs}"
	COMPILE_DEFINITIONS "HAVE_CONFIG_H")
target_link_libraries(replay_driver libsrtp_static)

add_test(NAME replay_driver
	COMMAND "${EXECUTABLE_OUTPUT_PATH}/replay_driver")

#----
add_executable(srtp_driver "srtp_driver.c" "getopt_s.c" "../crypto/replay/ut_sim.c")
set_target_properties(srtp_driver PROPERTIES 
	INCLUDE_DIRECTORIES "${incdirs}"
	COMPILE_DEFINITIONS "HAVE_CONFIG_H")
target_link_libraries(srtp_driver libsrtp_static)

add_test(NAME srtp_driver_rejection_timing
	COMMAND "${EXECUTABLE_OUTPUT_PATH}/srtp_driver" -r)

add_test(NAME srtp_driver_codec_timing
	COMMAND "${EXECUTABLE_OUTPUT_PATH}/srtp_driver" -c)

add_test(NAME srtp_driver_validation
	COMMAND "${EXECUTABLE_OUTPUT_PATH}/srtp_driver" -v)

add_test(NAME srtp_driver_timing
	COMMAND "${EXECUTABLE_OUTPUT_PATH}/srtp_driver" -t)
cmake_minimum_required(VERSION 3.0)

project(libsrtp)

include(TestBigEndian)
include(CheckCCompilerFlag)
include(CheckIncludeFiles)
include(CheckFunctionExists)
include(CheckSymbolExists)
include(CheckTypeSize)
include(CheckLibraryExists)

option(LIBSRTP_ENABLE_DEBUGGING "Enable Debugging" OFF)
option(LIBSRTP_ENABLE_ERROR_TO_STDOUT "Enable errors to stdout" OFF)
option(LIBSRTP_GENERIC_AESICM "Enable to use ISMAcryp code" OFF)
option(LIBSRTP_USE_OPENSSL "Enable usage of openssl" OFF)
option(LIBSRTP_USE_X86_ASSEMBLY "Enable use of X86 assembly" ON)
option(LIBSRTP_USE_GDOI "Enable use of GDOI" OFF)
option(LIBSRTP_BUILD_FOR_KERNEL "Build for kernel context" OFF)
option(LIBSRTP_BUILD_FOR_LINUX_KERNEL "Build for linux kernel context" OFF)
option(LIBSRTP_USE_SYSLOG "Enable syslog logging" OFF)
option(LIBSRTP_ENABLE_TESTS "Enable building of tests" OFF)
option(LIBSRTP_BUILD_SHARED_LIB "Enable building of the shared library" ON)
option(LIBSRTP_GEN_INSTALL_TARGETS "Enable generation of install targets" ON)
OPTION(LIBSRTP_USE_STATIC_LINKING "Use static linking of msvc runtime" OFF)

if(MSVC)
	foreach(OUTPUTCONFIG ${CMAKE_CONFIGURATION_TYPES})
		string(TOUPPER ${OUTPUTCONFIG} OUTPUTCONFIG)
		set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${OUTPUTCONFIG} ${CMAKE_BINARY_DIR}/bin)
		set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${OUTPUTCONFIG} ${CMAKE_BINARY_DIR}/lib)
		set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${OUTPUTCONFIG} ${CMAKE_BINARY_DIR}/lib)
	endforeach(OUTPUTCONFIG CMAKE_CONFIGURATION_TYPES)
endif()

set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_DEBUG_POSTFIX "d")

# statically link msvc runtime
if(MSVC AND LIBSRTP_USE_STATIC_LINKING)
	foreach(flag_var
		CMAKE_C_FLAGS CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE
		CMAKE_C_FLAGS_MINSIZEREL CMAKE_C_FLAGS_RELWITHDEBINFO)

		if(${flag_var} MATCHES "/MD")
			string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
		endif(${flag_var} MATCHES "/MD")
	endforeach(flag_var)
endif()

if(LIBSRTP_ENABLE_TESTS)
	enable_testing()
endif()

#### Config file

# TODO: Improve this
if(CMAKE_SYSTEM_PROCESSOR MATCHES "^arm")
	set(CPU_RISC TRUE)
else()
	set(CPU_CISC TRUE)
endif()

if(CMAKE_SYSTEM_NAME MATCHES "Linux")
	set(DEV_URANDOM "/dev/urandom")
endif()

if(TRUE OR LIBSRTP_ENABLE_DEBUGGING)
	set(ENABLE_DEBUGGING 1)
endif()

if(NOT "${LIBSRTP_ENABLE_ERRORS_TO_FILE}" STREQUAL "")
	set(ERR_REPORTING_FILE ON)
	set(USE_ERR_REPORTING_FILE ON)
	set(ERROR_REPORTING_FILE_NAME "${LIBSRTP_ENABLE_ERRORS_TO_FILE}")
else()
	set(USE_ERR_REPORTING_FILE OFF)
	set(ERR_REPORTING_FILE OFF)
endif()

if(TRUE OR LIBSRTP_ENABLE_ERROR_TO_STDOUT)
	set(ERR_REPORTING_STDOUT ON)
endif()

set(GENERIC_AESICM ${LIBSRTP_GENERIC_AESICM})

CHECK_INCLUDE_FILES(arpa/inet.h HAVE_ARPA_INET_H)
CHECK_INCLUDE_FILES(byteswap.h HAVE_BYTESWAP_H)
CHECK_INCLUDE_FILES(inttypes.h HAVE_INTTYPES_H)
CHECK_INCLUDE_FILES(machine/types.h HAVE_MACHINE_TYPES_H)
CHECK_INCLUDE_FILES(memory.h HAVE_MEMORY_H)
CHECK_INCLUDE_FILES(netinet/in.h HAVE_NETINET_IN_H)
CHECK_INCLUDE_FILES(stdint.h HAVE_STDINT_H)
CHECK_INCLUDE_FILES(stdlib.h HAVE_STDLIB_H)
CHECK_INCLUDE_FILES(strings.h HAVE_STRINGS_H)
CHECK_INCLUDE_FILES(string.h HAVE_STRING_H)
CHECK_INCLUDE_FILES(syslog.h HAVE_SYSLOG_H)
CHECK_INCLUDE_FILES(sys/int_types.h HAVE_SYS_INT_TYPES_H)
CHECK_INCLUDE_FILES(sys/socket.h HAVE_SYS_SOCKET_H)
CHECK_INCLUDE_FILES(sys/stat.h HAVE_SYS_STAT_H)
CHECK_INCLUDE_FILES(sys/types.h HAVE_SYS_TYPES_H)
CHECK_INCLUDE_FILES(sys/uio.h HAVE_SYS_UIO_H)
CHECK_INCLUDE_FILES(unistd.h HAVE_UNISTD_H)
CHECK_INCLUDE_FILES(windows.h HAVE_WINDOWS_H)
CHECK_INCLUDE_FILES(winsock2.h HAVE_WINSOCK2_H)

CHECK_TYPE_SIZE(int8_t INT8_T)
CHECK_TYPE_SIZE(int16_t INT16_T)
CHECK_TYPE_SIZE(int32_t INT32_T)
CHECK_TYPE_SIZE(size_t SIZE_T)

CHECK_TYPE_SIZE(uint8_t HAVE_UINT8_T)
CHECK_TYPE_SIZE(uint16_t HAVE_UINT16_T)
CHECK_TYPE_SIZE(uint32_t HAVE_UINT32_T)
CHECK_TYPE_SIZE(uint64_t HAVE_UINT64_T)

CHECK_SYMBOL_EXISTS(inet_aton "sys/socket.h;netinet/in.h;arpa/inet.h" HAVE_INET_ATON)
CHECK_SYMBOL_EXISTS(sigaction "signal.h" HAVE_SIGACTION)
CHECK_SYMBOL_EXISTS(socket "sys/socket.h" HAVE_SOCKET)
CHECK_SYMBOL_EXISTS(usleep "unistd.h" HAVE_USLEEP)

# figure out target architecture (32 vs 64 bits)
# if(CMAKE_SIZEOF_VOID_P EQUAL 8)
# endif()

set(HAVE_X86 ${LIBSRTP_USE_X86_ASSEMBLY})

CHECK_LIBRARY_EXISTS(socket socket "" HAVE_LIBSOCKET)

set(OPENSSL ${LIBSRTP_USE_OPENSSL})
if(LIBSRTP_USE_OPENSSL)
	find_package(OpenSSL)
endif()

CHECK_TYPE_SIZE("unsigned long" SIZEOF_UNSIGNED_LONG)
CHECK_TYPE_SIZE("unsigned long long" SIZEOF_UNSIGNED_LONG_LONG)

set(SRTP_GDOI ${LIBSRTP_USE_GDOI})
set(SRTP_KERNEL ${LIBSRTP_BUILD_FOR_KERNEL})
set(SRTP_KERNEL_LINUX ${LIBSRTP_BUILD_FOR_LINUX_KERNEL})
set(USE_SYSLOG ${LIBSRTP_USE_SYSLOG})

TEST_BIG_ENDIAN(WORDS_BIGENDIAN)

if(MSVC)
	set(inline "__inline")
endif()

# TODO: detect this better
if(WIN32)
	set(STDC_HEADERS ON)
else()
	set(STDC_HEADERS ON)
endif()

###############

list(APPEND srcs
	"srtp/ekt.c"
	"srtp/srtp.c"
	"crypto/cipher/aes.c"
	"crypto/cipher/aes_cbc.c"
	"crypto/cipher/cipher.c"
	"crypto/cipher/null_cipher.c"
	"crypto/hash/auth.c"
	"crypto/hash/null_auth.c"
	"crypto/kernel/alloc.c"
	"crypto/kernel/crypto_kernel.c"
	"crypto/kernel/err.c"
	"crypto/kernel/key.c"
	"crypto/math/datatypes.c"
	#"crypto/math/gf2_8.c"
	#"crypto/math/math.c"
	"crypto/math/stat.c"
	"crypto/replay/rdb.c"
	"crypto/replay/rdbx.c"
	#"crypto/replay/ut_sim.c"
	#"crypto/rng/prng.c"
	"crypto/rng/ctr_prng.c"
	#"crypto/rng/rand_linux_kernel.c"
	#"tables/aes_tables.c" #???
	)

if(LINUX)
	list(APPEND srcs "crypto/rng/rand_linux_kernel.c")
else()
	list(APPEND srcs "crypto/rng/rand_source.c")
endif()

if(LIBSRTP_USE_OPENSSL)
	list(APPEND srcs
		"crypto/cipher/aes_icm_ossl.c"
		"crypto/cipher/aes_gcm_ossl.c"
		"crypto/rng/rand_source_ossl.c"
		"crypto/hash/hmac_ossl.c"
		)
	list(APPEND priv_inc
		"crypto/include/aes_gcm_ossl.h"
		"crypto/include/aes_icm_ossl.h"
		)
else()
	list(APPEND srcs
		"crypto/hash/sha1.c"
		"crypto/cipher/aes_icm.c"
		"crypto/hash/hmac.c")
	list(APPEND priv_inc
		"crypto/include/aes_icm.h"
		"crypto/include/hmac.h"
		)
endif()

list(APPEND priv_inc
	"crypto/include/aes.h"
	"crypto/include/aes_cbc.h"
	"crypto/include/alloc.h"
	"crypto/include/auth.h"
	"crypto/include/cipher.h"
	"crypto/include/crypto_kernel.h"
	"crypto/include/crypto_math.h"
	"crypto/include/cryptoalg.h"
	"crypto/include/datatypes.h"
	"crypto/include/gf2_8.h"
	"crypto/include/integers.h"
	"crypto/include/kernel_compat.h"
	"crypto/include/key.h"
	"crypto/include/null_auth.h"
	"crypto/include/null_cipher.h"
	#"crypto/include/prng.h"
	"crypto/include/rand_source.h"
	"crypto/include/rdb.h"
	"crypto/include/rdbx.h"
	"crypto/include/sha1.h"
	"crypto/include/stat.h"
	"crypto/include/xfm.h"
	"crypto/include/rtp_priv.h"
	"crypto/include/srtp_priv.h"
	"crypto/include/ekt.h"
	"crypto/include/getopt_s.h"
	"crypto/include/rtp.h"
	)

list(APPEND pub_inc
	"include/srtp/srtp.h"
	"include/srtp/crypto.h"
	"include/srtp/crypto_types.h"
	"include/srtp/err.h")

list(APPEND pub_inc_dirs
	"$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
	"$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>"
	"$<INSTALL_INTERFACE:include>")

list(APPEND priv_inc_dirs
	"${pub_inc_dirs}"
	"${CMAKE_CURRENT_SOURCE_DIR}/crypto/include")

# Generate config
configure_file("config.h.in.cmake"
	"${CMAKE_CURRENT_BINARY_DIR}/include/config.h")
list(APPEND priv_inc
	"${CMAKE_CURRENT_BINARY_DIR}/include/config.h")

list(APPEND priv_definitions
	"HAVE_CONFIG_H")

if(WIN32)
	list(APPEND system_libs "wsock32")
	list(APPEND win32_def "srtp.def")
endif()

if(LIBSRTP_USE_OPENSSL)
	list(APPEND system_libs "${OPENSSL_LIBRARIES}")
endif()

message(STATUS "system_libs: ${system_libs}")

if(LIBSRTP_BUILD_SHARED_LIB)
	add_library(libsrtp SHARED ${srcs} ${priv_inc} ${pub_inc} ${win32_def})
	set_target_properties(libsrtp PROPERTIES
		PUBLIC_HEADER "${pub_inc}"
		COMPILE_DEFINITIONS "${priv_definitions}"
		INCLUDE_DIRECTORIES "${priv_inc_dirs}"
		INTERFACE_INCLUDE_DIRECTORIES "${pub_inc_dirs}"
		PREFIX ""
		IMPORT_PREFIX ""
		IMPORT_SUFFIX "_implib${CMAKE_IMPORT_LIBRARY_SUFFIX}"
		)
	target_link_libraries(libsrtp ${system_libs})
	if(LIBSRTP_GEN_INSTALL_TARGETS)
		install(TARGETS libsrtp
			EXPORT ${CMAKE_PROJECT_NAME}Config
			PUBLIC_HEADER DESTINATION "include/srtp"
			LIBRARY DESTINATION lib COMPONENT lib
			ARCHIVE DESTINATION lib COMPONENT lib
			RUNTIME DESTINATION bin COMPONENT bin)
	endif()
endif()

add_library(libsrtp_static STATIC ${srcs} ${priv_inc} ${pub_inc})
set_target_properties(libsrtp_static PROPERTIES
	PUBLIC_HEADER "${pub_inc}"
	COMPILE_DEFINITIONS "${priv_definitions}"
	INCLUDE_DIRECTORIES "${priv_inc_dirs}"
	INTERFACE_INCLUDE_DIRECTORIES "${pub_inc_dirs}"
	PREFIX ""
	IMPORT_PREFIX "")
target_link_libraries(libsrtp_static ${system_libs})

if(LIBSRTP_GEN_INSTALL_TARGETS)
	install(TARGETS libsrtp_static
		EXPORT ${CMAKE_PROJECT_NAME}Config
		PUBLIC_HEADER DESTINATION "include/srtp"
		LIBRARY DESTINATION lib COMPONENT lib
		ARCHIVE DESTINATION lib COMPONENT lib
		RUNTIME DESTINATION bin COMPONENT bin)

	install(EXPORT ${CMAKE_PROJECT_NAME}Config
		DESTINATION lib/cmake)
endif()

if(LIBSRTP_ENABLE_TESTS)
	add_subdirectory(test)
endif()

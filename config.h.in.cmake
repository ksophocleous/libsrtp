/* config_in.h.  Generated from configure.in by autoheader.  */

/* Define if building for a CISC machine (e.g. Intel). */
#cmakedefine CPU_CISC 1

/* Define if building for a RISC machine (assume slow byte access). */
#cmakedefine CPU_RISC 1

/* Path to random device */
#cmakedefine DEV_URANDOM "${DEV_URANDOM}"

/* Define to compile in dynamic debugging system. */
#cmakedefine ENABLE_DEBUGGING

/* Report errors to this file. */
#cmakedefine ERR_REPORTING_FILE "@ERROR_REPORTING_FILE_NAME@"

/* Define to use logging to stdout. */
#cmakedefine ERR_REPORTING_STDOUT

/* Define this to use ISMAcryp code. */
#cmakedefine GENERIC_AESICM

/* Define to 1 if you have the <arpa/inet.h> header file. */
#cmakedefine HAVE_ARPA_INET_H 1

/* Define to 1 if you have the <byteswap.h> header file. */
#cmakedefine HAVE_BYTESWAP_H 1

/* Define to 1 if you have the `inet_aton' function. */
#cmakedefine HAVE_INET_ATON 1

/* Define to 1 if the system has the type `int16_t'. */
#cmakedefine HAVE_INT16_T 1

/* Define to 1 if the system has the type `int32_t'. */
#cmakedefine HAVE_INT32_T 1

/* Define to 1 if the system has the type `int8_t'. */
#cmakedefine HAVE_INT8_T 1

/* Define to 1 if you have the <inttypes.h> header file. */
#cmakedefine HAVE_INTTYPES_H 1

/* Define to 1 if you have the `socket' library (-lsocket). */
#cmakedefine HAVE_LIBSOCKET 1

/* Define to 1 if you have the <machine/types.h> header file. */
#cmakedefine HAVE_MACHINE_TYPES_H 1

/* Define to 1 if you have the <memory.h> header file. */
#cmakedefine HAVE_MEMORY_H 1

/* Define to 1 if you have the <netinet/in.h> header file. */
#cmakedefine HAVE_NETINET_IN_H 1

/* Define to 1 if you have the `sigaction' function. */
#cmakedefine HAVE_SIGACTION 1

/* Define to 1 if you have the `socket' function. */
#cmakedefine HAVE_SOCKET 1

/* Define to 1 if you have the <stdint.h> header file. */
#cmakedefine HAVE_STDINT_H 1

/* Define to 1 if you have the <stdlib.h> header file. */
#cmakedefine HAVE_STDLIB_H 1

/* Define to 1 if you have the <strings.h> header file. */
#cmakedefine HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#cmakedefine HAVE_STRING_H 1

/* Define to 1 if you have the <syslog.h> header file. */
#cmakedefine HAVE_SYSLOG_H 1

/* Define to 1 if you have the <sys/int_types.h> header file. */
#cmakedefine HAVE_SYS_INT_TYPES_H 1

/* Define to 1 if you have the <sys/socket.h> header file. */
#cmakedefine HAVE_SYS_SOCKET_H 1

/* Define to 1 if you have the <sys/stat.h> header file. */
#cmakedefine HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#cmakedefine HAVE_SYS_TYPES_H 1

/* Define to 1 if you have the <sys/uio.h> header file. */
#cmakedefine HAVE_SYS_UIO_H 1

/* Define to 1 if the system has the type `uint16_t'. */
#cmakedefine HAVE_UINT16_T 1

/* Define to 1 if the system has the type `uint32_t'. */
#cmakedefine HAVE_UINT32_T 1

/* Define to 1 if the system has the type `uint64_t'. */
#cmakedefine HAVE_UINT64_T 1

/* Define to 1 if the system has the type `uint8_t'. */
#cmakedefine HAVE_UINT8_T 1

/* Define to 1 if you have the <unistd.h> header file. */
#cmakedefine HAVE_UNISTD_H 1

/* Define to 1 if you have the `usleep' function. */
#cmakedefine HAVE_USLEEP 1

/* Define to 1 if you have the <windows.h> header file. */
#cmakedefine HAVE_WINDOWS_H 1

/* Define to 1 if you have the <winsock2.h> header file. */
#cmakedefine HAVE_WINSOCK2_H 1

/* Define to use X86 inlined assembly code */
#cmakedefine HAVE_X86

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT "${PACKAGE_BUGREPORT}"

/* Define to the full name of this package. */
#define PACKAGE_NAME "${PACKAGE_NAME}"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "${PACKAGE_NAME} ${PACKAGE_VERSION}"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "${PACKAGE_TARNAME}"

/* Define to the version of this package. */
#define PACKAGE_VERSION "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}"

/* The size of a `unsigned long', as computed by sizeof. */
#cmakedefine SIZEOF_UNSIGNED_LONG ${SIZEOF_UNSIGNED_LONG}

/* The size of a `unsigned long long', as computed by sizeof. */
#cmakedefine SIZEOF_UNSIGNED_LONG_LONG ${SIZEOF_UNSIGNED_LONG_LONG}

/* Define to use GDOI. */
#cmakedefine SRTP_GDOI

/* Define to use OpenSSL crypto. */
#cmakedefine OPENSSL

/* Define to compile for kernel contexts. */
#cmakedefine SRTP_KERNEL

/* Define to compile for Linux kernel context. */
#cmakedefine SRTP_KERNEL_LINUX

/* Define to 1 if you have the ANSI C header files. */
#cmakedefine STDC_HEADERS 1

/* Write errors to this file */
#cmakedefine USE_ERR_REPORTING_FILE

/* Define to use syslog logging. */
#cmakedefine USE_SYSLOG

/* Define to 1 if your processor stores words with the most significant byte
   first (like Motorola and SPARC, unlike Intel and VAX). */
#cmakedefine WORDS_BIGENDIAN 1

/* Define to empty if `const' does not conform to ANSI C. */
#cmakedefine const

/* Define to `__inline__' or `__inline' if that's what the C compiler
   calls it, or to nothing if 'inline' is not supported under any name.  */
#ifndef __cplusplus
#cmakedefine inline @inline@
#endif

/* Define to `unsigned' if <sys/types.h> does not define. */
#cmakedefine size_t @size_t@

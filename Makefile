ARCH := $(shell uname -m)
MELANGE_DIR ?= ../melange
MELANGE ?= ${MELANGE_DIR}/melange
KEY ?= local-melange.rsa
REPO ?= $(shell pwd)/packages

GLIBC_VERSION ?= 2.36-r0
BUILD_BASE_VERSION ?= 1-r3
BUSYBOX_VERSION ?= 1.35.0-r2
OPENSSL_VERSION ?= 3.0.5-r3
BINUTILS_VERSION ?= 2.39-r1
FLEX_VERSION ?= 2.6.4-r0
BISON_VERSION ?= 3.8.2-r1
PAXUTILS_VERSION ?= 1.3.4-r0
TEXINFO_VERSION ?= 6.8-r0
GZIP_VERSION ?= 1.12-r1


MELANGE_OPTS ?= \
	--repository-append ${REPO} \
	--keyring-append ${KEY}.pub \
	--signing-key ${KEY} \
	--pipeline-dir ${MELANGE_DIR}/pipelines \
	--arch ${ARCH}

MELANGE_DEFOPTS ?= --empty-workspace

PACKAGES = \
	packages/${ARCH}/glibc-${GLIBC_VERSION}.apk \
	packages/${ARCH}/build-base-${BUILD_BASE_VERSION}.apk \
	packages/${ARCH}/openssl-${OPENSSL_VERSION}.apk
	packages/${ARCH}/binutils-${BINUTILS_VERSION}.apk \
	packages/${ARCH}/flex-${FLEX_VERSION}.apk \
	packages/${ARCH}/bison-${BISON_VERSION}.apk \
	packages/${ARCH}/texinfo-${TEXINFO_VERSION}.apk \
	packages/${ARCH}/pax-utils-${PAXUTILS_VERSION}.apk \
	packages/${ARCH}/busybox-${BUSYBOX_VERSION}.apk \
	packages/${ARCH}/gzip-${GZIP_VERSION}.apk \

all: ${KEY} ${PACKAGES}

packages/${ARCH}/glibc-${GLIBC_VERSION}.apk:
	${MELANGE} build glibc.yaml ${MELANGE_OPTS} --source-dir ./glibc/

packages/${ARCH}/build-base-${BUILD_BASE_VERSION}.apk:
	${MELANGE} build build-base.yaml ${MELANGE_OPTS} ${MELANGE_DEFOPTS}

packages/${ARCH}/openssl-${OPENSSL_VERSION}.apk:
	${MELANGE} build openssl.yaml ${MELANGE_OPTS} ${MELANGE_DEFOPTS}
	
packages/${ARCH}/binutils-${BINUTILS_VERSION}.apk:
	${MELANGE} build binutils.yaml ${MELANGE_OPTS} ${MELANGE_DEFOPTS}

packages/${ARCH}/flex-${FLEX_VERSION}.apk:
	${MELANGE} build flex.yaml ${MELANGE_OPTS} ${MELANGE_DEFOPTS}

packages/${ARCH}/bison-${BISON_VERSION}.apk:
	${MELANGE} build bison.yaml ${MELANGE_OPTS} ${MELANGE_DEFOPTS}

packages/${ARCH}/texinfo-${TEXINFO_VERSION}.apk:
	${MELANGE} build texinfo.yaml ${MELANGE_OPTS} ${MELANGE_DEFOPTS}

packages/${ARCH}/pax-utils-${PAXUTILS_VERSION}.apk:
	${MELANGE} build pax-utils.yaml ${MELANGE_OPTS} ${MELANGE_DEFOPTS}

${KEY}:
	${MELANGE} keygen ${KEY}

clean:
	rm -rf packages/${ARCH}
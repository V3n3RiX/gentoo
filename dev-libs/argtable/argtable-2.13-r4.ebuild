# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="$(ver_rs 1 '-')"
MY_P=${PN}${MY_PV}

DESCRIPTION="An ANSI C library for parsing GNU-style command-line options with minimal fuss"
HOMEPAGE="https://argtable.sourceforge.net"
SRC_URI="https://downloads.sourceforge.net/${PN}/${MY_P}.tar.gz"
S="${WORKDIR}"/${MY_P}

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm64 ~loong ppc ppc64 ~riscv sparc x86"
IUSE="doc debug examples static-libs"

PATCHES=(
	"${FILESDIR}"/${PN}-2.13-Fix-implicit-function-declaration.patch
	"${FILESDIR}"/${PN}-2.13-Fix-undeclared-library-function.patch
)

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable static-libs static)
}

src_install() {
	default

	rm -rf "${ED}"/usr/share/doc/${PF}/

	if use doc ; then
		cd "${S}"/doc || die
		dodoc *.pdf *.ps
		docinto html
		dodoc *.html *.gif
	fi

	if use examples ; then
		cd "${S}"/example || die
		docinto examples
		dodoc Makefile *.[ch] README.txt
	fi

	find "${ED}" -name "*.la" -delete || die "failed to delete .la files"
}

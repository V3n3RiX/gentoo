# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A tool to provide access to statistics about the system on which it's run"
HOMEPAGE="https://www.i-scream.org/libstatgrab/"
SRC_URI="https://www.mirrorservice.org/sites/ftp.i-scream.org/pub/i-scream/libstatgrab/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ~loong ppc ~riscv x86"
IUSE="examples test"
RESTRICT="!test? ( test )"

RDEPEND="sys-libs/ncurses:="
DEPEND="${RDEPEND}"

DOCS=( ChangeLog PLATFORMS NEWS AUTHORS README )

src_configure() {
	local myeconfargs=(
		--disable-setgid-binaries
		--disable-setuid-binaries
		--with-ncurses
		--disable-static
		$(use_enable test tests)
	)

	econf "${myeconfargs[@]}"
}

src_install() {
	default

	if use examples; then
		docompress -x /usr/share/doc/${PF}/examples
		docinto examples
		dodoc -r examples/*
	fi

	find "${ED}" -name '*.la' -delete || die
}

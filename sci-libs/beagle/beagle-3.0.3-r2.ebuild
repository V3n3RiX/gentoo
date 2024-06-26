# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Open BEAGLE, a versatile EC/GA/GP framework"
HOMEPAGE="https://chgagne.github.io/beagle/"
SRC_URI="mirror://sourceforge/beagle/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples static-libs"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}"
BDEPEND="doc? ( app-text/doxygen )"

PATCHES=(
	"${FILESDIR}/${PN}-3.0.3-gcc43.patch"
	"${FILESDIR}/${PN}-3.0.3-gcc47.patch"
	"${FILESDIR}/${PN}-3.0.3-fix-c++14.patch"
)

src_prepare() {
	default
	sed -e "s:@LIBS@:& -lpthread:" -i PACC/Threading/Makefile.in || die

	# fix build with C++17, bug #898274
	sed -e "s/register //" -i PACC/Util/{MTRand.hpp,Tokenizer.cpp} || die
}

src_configure() {
	econf \
		--enable-optimization \
		$(use_enable static-libs static)
}

src_compile() {
	default
	use doc && emake doc
}

src_install() {
	use doc && local HTML_DOCS=( refman/. )
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi

	default

	if ! use static-libs; then
		find "${D}" -name '*.la' -delete || die
	fi
}

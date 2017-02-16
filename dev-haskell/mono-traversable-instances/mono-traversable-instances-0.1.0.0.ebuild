# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

# ebuild generated by hackport 0.5.1

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Extra typeclass instances for mono-traversable"
HOMEPAGE="https://github.com/snoyberg/mono-traversable#readme"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/comonad-3.0.3:=[profile?]
	>=dev-haskell/dlist-0.6:=[profile?] <dev-haskell/dlist-1.0:=[profile?]
	>=dev-haskell/dlist-instances-0.1:=[profile?] <dev-haskell/dlist-instances-0.2:=[profile?]
	>=dev-haskell/mono-traversable-1.0:=[profile?] <dev-haskell/mono-traversable-1.1:=[profile?]
	>=dev-haskell/semigroupoids-3.0:=[profile?]
	dev-haskell/semigroups:=[profile?]
	dev-haskell/vector-instances:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
"

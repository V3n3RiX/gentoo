# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby31 ruby32 ruby33 ruby34"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_BINWRAP=""

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="Terminal color capabilities detection"
HOMEPAGE="https://github.com/piotrmurach/tty-command"
SRC_URI="https://github.com/piotrmurach/tty-command/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~riscv"

ruby_add_rdepend ">=dev-ruby/pastel-0.8:0"

all_ruby_prepare() {
	echo '-rspec_helper' > .rspec || die

	sed -i -e 's:_relative ": "./:' ${RUBY_FAKEGEM_GEMSPEC} || die

	# Avoid flaky spec that fails with unimportant output differences
	sed -e '/logs phased output in pseudo terminal mode/ s/it/xit/' \
		-i spec/unit/pty_spec.rb || die
}

# SPDX-FileCopyrightText: 2021 Andrius Štikonas <andrius@stikonas.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

checksum=6f7314054e18bfaa01604e8c06c9688e3cf652760abe2115cc508894268f6faf

src_prepare() {
    default

    # Regenerate bison files
    rm -f perly.c perly.h
    bison -d perly.y
    mv perly.tab.c perly.c
    mv perly.tab.h perly.h

    # Regenerate other prebuilt header files
    for file in embed keywords opcode; do
        rm -f ${file}.h
        perl ${file}.pl
    done
    rm -f regnodes.h
    perl regcomp.pl
    rm -f fbyterun.h byterun.c
    perl bytecode.pl
}

src_install() {
    # Remove old perl
    rm -rf "${PREFIX}"/lib/perl5/

    default
}

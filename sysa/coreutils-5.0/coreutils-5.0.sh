# SPDX-FileCopyrightText: 2021 Paul Dersey <pdersey@gmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

checksum=748512d89578c2b454cee350c81707c4a27bc02637429ee5f5d9b32c6d76f73a

src_unpack() {
    src_dir="${base_dir}/src"

    # Remove previous source diretory
    rm -rf "${pkg}"

    tar -xf "${src_dir}/${pkg}.tar"
}

src_prepare() {
    cp lib/fnmatch_.h lib/fnmatch.h
    cp lib/ftw_.h lib/ftw.h
    cp lib/search_.h lib/search.h
    touch config.h

    patch -Np0 -i ../../patches/touch-getdate.patch

    # Bison pre-generated file
    rm lib/getdate.c

    cp "${mk_dir}/pass2.mk" Makefile
}

src_install() {
    default

    # perl later requires /bin/pwd
    ln -s "${PREFIX}/bin/pwd" /bin/pwd
}

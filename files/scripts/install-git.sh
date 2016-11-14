#!/bin/bash -e

git_version=${1}
git_source="git-${git_version}"
git_archive="${git_source}.tar.gz"

echo "curl -L https://www.kernel.org/pub/software/scm/git/${git_archive} > ${git_archive}"
curl -L "https://www.kernel.org/pub/software/scm/git/${git_archive}" > ${git_archive}
tar xzvf ${git_archive}
cd ${git_source}
make configure
./configure --prefix=/usr
make
make install
cd ..
rm -rf ${git_source} ${git_archive}

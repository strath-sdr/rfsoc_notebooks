import os
import shutil
from distutils.dir_util import copy_tree

from setuptools import find_packages, setup

# global variables
nb_dir = os.environ['PYNQ_JUPYTER_NOTEBOOKS']
package_name = 'pystrath_rfsoc'
pip_name = 'pystrath-rfsoc'
data_files = []

for f in /etc/profile.d/*.sh; do source $f; done

# copy common notebooks to jupyter home
def copy_common_notebooks():
    src_dir = os.path.join(f'common')
    dst_dir = os.path.join(nb_dir, 'rfsoc-notebooks')
    if os.path.exists(dst_dir):
        shutil.rmtree(dst_dir)
    copy_tree(src_dir, dst_dir)

copy_common_notebooks()

setup(
    name=package_name,
    version='0.2.0',
    install_requires=[
        'plotly==5.1.0',
        'pynq==2.7'
    ],
    author="David Northcote",
    packages=find_packages(),
    package_data={
        '': data_files,
    },
    description="A collection of RFSoC introductory notebooks for PYNQ.")

import os
import shutil
from distutils.dir_util import copy_tree

from setuptools import find_packages, setup

# global variables
board = os.environ['BOARD']
nb_dir = os.environ['PYNQ_JUPYTER_NOTEBOOKS']
package_name = 'pystrath_rfsoc'
pip_name = 'pystrath-rfsoc'

repo_board_folder = f'boards/{board}/{package_name}'
data_files = []

# check whether board is supported
def check_env():
    if not os.path.isdir(f'boards/{board}'):
        raise ValueError("Board {} is not supported.".format(board))
    if not os.path.isdir(nb_dir):
        raise ValueError(
            "Directory {} does not exist.".format(nb_dir))

# copy unique notebooks to jupyter home
def copy_notebooks():
    src_dir = os.path.join(f'boards/{board}/{package_name}/notebooks')
    dst_dir = os.path.join(nb_dir, 'rfsoc-notebooks')
    if os.path.exists(dst_dir):
        shutil.rmtree(dst_dir)
    copy_tree(src_dir, dst_dir)

# copy board specific drivers
def copy_drivers():
    src_dr_dir = os.path.join(repo_board_folder, 'drivers')
    dst_dr_dir = os.path.join(package_name)
    copy_tree(src_dr_dir, dst_dr_dir)
    data_files.extend(
        [os.path.join("..", dst_dr_dir, f) for f in os.listdir(dst_dr_dir)])
    
# copy overlays to python package
def copy_overlays():
    src_ol_dir = os.path.join(repo_board_folder, 'bitstream')
    dst_ol_dir = os.path.join(package_name, 'bitstream')
    copy_tree(src_ol_dir, dst_ol_dir)
    data_files.extend(
        [os.path.join("..", dst_ol_dir, f) for f in os.listdir(dst_ol_dir)])

check_env()
copy_notebooks()
copy_drivers()
copy_overlays()

setup(
    name=package_name,
    version='0.1',
    install_requires=[
        'plotly==4.5.2',
        'pynq==2.6'
    ],
    author="David Northcote",
    packages=find_packages(),
    package_data={
        '': data_files,
    },
    description="A collection of RFSoC introductory notebooks for PYNQ.")

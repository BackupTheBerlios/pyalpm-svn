#!/usr/bin/env python

from distutils.core import setup
from distutils.extension import Extension
from Pyrex.Distutils import build_ext

setup (
		name = "PyAlpm -  Python archlinux package manager",
		ext_package = "alpm",
		ext_modules = [
			Extension(
				"pyalpm", 
				["src/pyalpm.pyx",
				 "src/alpm.pyx",
				 "src/database.pyx",
				 "src/group.pyx",
				 "src/package.pyx"
				],
				libraries=['alpm']
			)
		],
		cmdclass = { 'build_ext': build_ext },
		packages = ["alpm"],
		package_dir = {'alpm': 'src/'}
)

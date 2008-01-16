#!/usr/bin/env python

from distutils.core import setup
from distutils.extension import Extension
from Pyrex.Distutils import build_ext

setup(
		name = "pyAlpm",
		ext_modules=[
			Extension("alpm", ["alpm.pyx"], libraries = ["alpm"])
			],
		cmdclass = {'build_ext': build_ext}
)


#!/usr/bin/env python
# Copyright (C) 2007 - Stefano Esposito <stefano.esposito87@gmail.com>
#
# This file is part of PyAlpm.
# PyAlpm is free software; you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation; either version 3 of the license, or
# (at your option) any later version.
# 
# PyAlpm is distributed in the hope that it will be usefull,
# bu WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PUORPOSE. See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not see <http://www.gnu.org/licenses>

from distutils.core import setup
from distutils.extension import Extension
from Pyrex.Distutils import build_ext

setup (
	name = "pyalpm",
	version = "0.0.2",
	author = "Stefano Esposito",
	author_email = "stefano.esposito87@gmail.com",
	description="Python bindings for pacman's libalpm",
	ext_modules=[
		Extension(
						"alpm", 
						["pyalpm/alpm.pyx","pyalpm/package.pyx", "pyalpm/db.pyx",
						 "pyalpm/group.pyx", "pyalpm/config.pyx", "pyalpm/depend.pyx",
						 "pyalpm/conflict.pyx", "pyalpm/sync.pyx", "pyalpm/transaction.pyx",
						 "pyalpm/exceptions.pyx"],
					libraries=["alpm"])
		],
	cmdclass = {'build_ext': build_ext},
	license="GNU Lesser General Public License (LGPL)",
	platforms=["ArchLinux"],
	long_description="""Python bindings writte in Pyrex to the ArchLinux package manager library (libalpm). The libalpm API has been "translated" in a more pythonic API, with classes and modules. See Documentation for further informations."""
)

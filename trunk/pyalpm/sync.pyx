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

cimport package
from package cimport Package

cdef class SyncPkg:
				def get_type (self):
								return alpm_sync_get_type (self.sync)

				def get_package (self):
								cdef Package pkg

								#just make a python Package out of a pmpkg_t*
								pkg = Package ()
								pkg.pkg = alpm_sync_get_pkg (self.sync)
								return pkg

				#TODO: def get_data (self):
				#need to know what type could be the data field

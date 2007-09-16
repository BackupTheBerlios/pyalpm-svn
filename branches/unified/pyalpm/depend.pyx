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

cdef class Depend:
				def get_mod (self):
								return alpm_dep_get_mod (self.depend)

				def get_name (self):
								return alpm_dep_get_name (self.depend)

				def get_version (self):
								return alpm_dep_get_version (self.depend)

				def __str__ (self):
								return self.get_name()

cdef class DepMissing:
				def get_target (self):
								return alpm_miss_get_target (self.miss)

				def get_type (self):
								return alpm_miss_get_type (self.miss)

				def get_depend (self):
								cdef Depend dep
								
								#create a python Depend out of a pmdepend_t*
								dep = Depend ()
								dep.depend = alpm_miss_get_dep (self.miss)
								return dep
				
				def __str__ (self):
								self.get_target()

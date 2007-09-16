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

cimport alpm
from alpm cimport alpm_list_t, alpm_list_first, alpm_list_next
from alpm cimport alpm_list_getdata

cdef class Group:
				def get_name (self):
								return alpm_grp_get_name (self.grp)

				def get_packages (self):
								cdef alpm_list_t *pkgs
								cdef alpm_list_t *i

								pkgs = <alpm_list_t *>alpm_grp_get_pkgs (self.grp)
								i = alpm_list_first (pkgs)

								#Pyrex doesn't like alpm_list_t*, so we translate it to a python
								#list
								ret = []
								while (i):
												ret.append(<char *>alpm_list_getdata(i))
												i = alpm_list_next (i)
												continue
								return ret


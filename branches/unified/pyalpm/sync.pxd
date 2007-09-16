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
from package cimport pmpkg_t

cdef extern from "alpm.h":
				ctypedef enum pmsynctype_t:
								PM_SYNC_TYPE_REPLACE = 1,
								PM_SYNC_TYPE_UPGRADE,
								PM_SYNC_TYPE_DEPEND

				ctypedef struct pmsyncpkg_t

				pmsynctype_t alpm_sync_get_type (pmsyncpkg_t *sync)
				pmpkg_t * alpm_sync_get_pkg (pmsyncpkg_t *sync)
				void * alpm_sync_get_data (pmsyncpkg_t *sync)

cdef class SyncPkg:
				cdef pmsyncpkg_t *sync


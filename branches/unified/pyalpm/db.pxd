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
cimport package
from alpm cimport alpm_list_t
from package cimport pmpkg_t

cdef extern from "alpm.h":
				ctypedef struct pmdb_t

				pmdb_t * alpm_db_register_local ()
				pmdb_t * alpm_db_register_sync (char *treename)
				int alpm_db_unregister (pmdb_t *db)
				pmpkg_t * alpm_db_get_pkg (pmdb_t *db, char *name)
				char * alpm_db_get_name (pmdb_t *db)
				alpm_list_t * alpm_db_getpkgcache (pmdb_t *db)
				alpm_list_t * alpm_db_search (pmdb_t *db, alpm_list_t *needles)
				int alpm_db_update (int level, pmdb_t *db)

cdef class Database:
				cdef pmdb_t *db
				cdef char *name

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

cdef extern from "alpm.h":

				ctypedef enum pmdepmod_t:
								PM_DEP_MOD_ANY = 1,
								PM_DEP_MOD_EQ,
								PM_DEP_MOD_GE,
								PM_DEP_MOD_LE

				ctypedef enum pmdeptype_t:
								PM_DEP_TYPE_DEPEND = 1,
								PM_DEP_TYPE_CONFLICT

				ctypedef struct pmdepend_t
				ctypedef struct pmdepmissing_t

				char * alpm_miss_get_target (pmdepmissing_t *miss)
				pmdeptype_t alpm_miss_get_type (pmdepmissing_t *miss)
				pmdepend_t * alpm_miss_get_dep (pmdepmissing_t *miss)

				pmdepmod_t alpm_dep_get_mod (pmdepend_t *dep)
				char * alpm_dep_get_name (pmdepend_t *dep)
				char * alpm_dep_get_version (pmdepend_t *dep)

cdef class Depend:
				cdef pmdepend_t *depend

cdef class DepMissing:
				cdef pmdepmissing_t *miss


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
from alpm cimport alpm_list_t

cdef extern from "alpm.h":
				ctypedef enum pmpkgreason_t:
								PM_PKG_REASON_EXPLICIT = 0,
								PM_PKG_REASON_DEPEND = 1

				ctypedef struct pmpkg_t
				int alpm_pkg_load (char *filename, pmpkg_t **pkg)
				char *alpm_pkg_get_filename(pmpkg_t *pkg)
				char *alpm_pkg_get_name(pmpkg_t *pkg)
				char *alpm_pkg_get_version(pmpkg_t *pkg)
				char *alpm_pkg_get_desc(pmpkg_t *pkg)
				char *alpm_pkg_get_url(pmpkg_t *pkg)
				char *alpm_pkg_get_builddate(pmpkg_t *pkg)
				char *alpm_pkg_get_buildtype(pmpkg_t *pkg)
				char *alpm_pkg_get_installdate(pmpkg_t *pkg)
				char *alpm_pkg_get_packager(pmpkg_t *pkg)
				char *alpm_pkg_get_md5sum(pmpkg_t *pkg)
				char *alpm_pkg_get_arch(pmpkg_t *pkg)
				unsigned long alpm_pkg_get_size(pmpkg_t *pkg)
				unsigned long alpm_pkg_get_isize(pmpkg_t *pkg)
				pmpkgreason_t alpm_pkg_get_reason(pmpkg_t *pkg)
				alpm_list_t *alpm_pkg_get_licenses(pmpkg_t *pkg)
				alpm_list_t *alpm_pkg_get_groups(pmpkg_t *pkg)
				alpm_list_t *alpm_pkg_get_depends(pmpkg_t *pkg)
				alpm_list_t *alpm_pkg_get_requiredby(pmpkg_t *pkg)
				alpm_list_t *alpm_pkg_get_conflicts(pmpkg_t *pkg)
				alpm_list_t *alpm_pkg_get_provides(pmpkg_t *pkg)
				alpm_list_t *alpm_pkg_get_replaces(pmpkg_t *pkg)
				alpm_list_t *alpm_pkg_get_files(pmpkg_t *pkg)
				alpm_list_t *alpm_pkg_get_backup(pmpkg_t *pkg)
				unsigned short alpm_pkg_has_scriptlet(pmpkg_t *pkg)

cdef class Package:
				cdef pmpkg_t *pkg

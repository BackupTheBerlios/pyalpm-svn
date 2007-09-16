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

				ctypedef enum pmtranstype_t:
								PM_TRANS_TYPE_ADD = 1,
								PM_TRANS_TYPE_REMOVE,
								PM_TRANS_TYPE_REMOVEUPGRADE,
								PM_TRANS_TYPE_UPGRADE,
								PM_TRANS_TYPE_SYNC

				ctypedef enum pmtransflag_t:
								PM_TRANS_FLAG_NODEPS = 0x01,
								PM_TRANS_FLAG_FORCE = 0x02,
								PM_TRANS_FLAG_NOSAVE = 0x04,
								PM_TRANS_FLAG_FRESHEN = 0x08,
								PM_TRANS_FLAG_CASCADE = 0x10,
								PM_TRANS_FLAG_RECURSE = 0x20,
								PM_TRANS_FLAG_DBONLY = 0x40,
								PM_TRANS_FLAG_DEPENDSONLY = 0x80,
								PM_TRANS_FLAG_ALLDEPS = 0x100,
								PM_TRANS_FLAG_DOWNLOADONLY = 0x200,
								PM_TRANS_FLAG_NOSCRIPTLET = 0x400,
								PM_TRANS_FLAG_NOCONFLICTS = 0x800,
								PM_TRANS_FLAG_PRINTURIS = 0x1000

				ctypedef enum pmtransevt_t:
								PM_TRANS_EVT_CHECKDEPS_START = 1,
								PM_TRANS_EVT_CHECKDEPS_DONE,
								PM_TRANS_EVT_FILECONFLICTS_START,
								PM_TRANS_EVT_FILECONFLICTS_DONE,
								PM_TRANS_EVT_RESOLVEDEPS_START,
								PM_TRANS_EVT_RESOLVEDEPS_DONE,
								PM_TRANS_EVT_INTERCONFLICTS_START,
								PM_TRANS_EVT_INTERCONFLICTS_DONE,
								PM_TRANS_EVT_ADD_START,
								PM_TRANS_EVT_ADD_DONE,
								PM_TRANS_EVT_REMOVE_START,
								PM_TRANS_EVT_REMOVE_DONE,
								PM_TRANS_EVT_UPGRADE_START,
								PM_TRANS_EVT_UPGRADE_DONE,
								PM_TRANS_EVT_EXTRACT_DONE,
								PM_TRANS_EVT_INTEGRITY_START,
								PM_TRANS_EVT_INTEGRITY_DONE,
								PM_TRANS_EVT_PRINTURI,
								PM_TRANS_EVT_RETRIEVE_START,
				
				ctypedef enum pmtransconv_t:
								PM_TRANS_CONV_INSTALL_IGNOREPKG = 0x01,
								PM_TRANS_CONV_REPLACE_PKG = 0x02,
								PM_TRANS_CONV_CONFLICT_PKG = 0x04,
								PM_TRANS_CONV_CORRUPTED_PKG = 0x08,
								PM_TRANS_CONV_LOCAL_NEWER = 0x10,
								PM_TRANS_CONV_LOCAL_UPTODATE = 0x20,
								PM_TRANS_CONV_REMOVE_HOLDPKG = 0x40

				ctypedef enum pmtransprog_t:
								PM_TRANS_PROGRESS_ADD_START,
								PM_TRANS_PROGRESS_UPGRADE_START,
								PM_TRANS_PROGRESS_REMOVE_START,
								PM_TRANS_PROGRESS_CONFLICTS_START

				ctypedef void (*alpm_trans_cb_event) (pmtransevt_t, void *, void *)
				ctypedef void (*alpm_trans_cb_conv) (pmtransconv_t, void *, void *, void *, int *)
				ctypedef void (*alpm_trans_cb_progress) (pmtransprog_t, char *, int, int, int)

				pmtranstype_t alpm_trans_get_type ()
				unsigned int alpm_trans_get_flags ()
				alpm_list_t * alpm_trans_get_targets ()
				alpm_list_t * alpm_trans_get_pkgs ()
				int alpm_trans_init (pmtranstype_t type, pmtransflag_t flags, alpm_trans_cb_event cb_event, alpm_trans_cb_conv cb_conv, alpm_trans_cb_progress cb_progress)
				int alpm_trans_sysupgrade ()
				int alpm_trans_addtarget (char *target)
				int alpm_trans_prepare (alpm_list_t **data)
				int alpm_trans_commit (alpm_list_t **data)
				int alpm_trans_release ()


cdef class Transaction:
				pass

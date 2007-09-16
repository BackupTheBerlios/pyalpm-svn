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

cdef extern from "alpm_list.h":
				#Just defines the type and most usefule functions which we'll use
				#all around pyalpm
				ctypedef struct alpm_list_t
				alpm_list_t * alpm_list_first (alpm_list_t *list)
				alpm_list_t * alpm_list_next (alpm_list_t *list)
				alpm_list_t * alpm_list_new ()
				alpm_list_t * alpm_list_add (alpm_list_t *list, void *data)
				void * alpm_list_getdata (alpm_list_t *list)

cdef extern from "alpm.h":
				#define the download and log callback types, the logleve enum and some
				#function basic for the alpm
				ctypedef enum pmloglevel_t:
								PM_LOG_ERROR = 0x01,
								PM_LOG_WARNING = 0x02,
								PM_LOG_DEBUG = 0x04,
								PM_LOG_FUNCTION = 0x08

				ctypedef enum _pmerrno_t:
								PM_ERR_MEMORY = 1,
								PM_ERR_SYSTEM,
								PM_ERR_BADPERMS,
								PM_ERR_NOT_A_FILE,
								PM_ERR_NOT_A_DIR,
								PM_ERR_WRONG_ARGS,
								PM_ERR_HANDLE_NULL,
								PM_ERR_HANDLE_NOT_NULL,
								PM_ERR_HANDLE_LOCK,
								PM_ERR_DB_OPEN,
								PM_ERR_DB_CREATE,
								PM_ERR_DB_NULL,
								PM_ERR_DB_NOT_NULL,
								PM_ERR_DB_NOT_FOUND,
								PM_ERR_DB_WRITE,
								PM_ERR_DB_REMOVE,
								PM_ERR_SERVER_BAD_URL,
								PM_ERR_OPT_LOGFILE,
								PM_ERR_OPT_DBPATH,
								PM_ERR_OPT_LOCALDB,
								PM_ERR_OPT_SYNCDB,
								PM_ERR_OPT_USESYSLOG,
								PM_ERR_TRANS_NOT_NULL,
								PM_ERR_TRANS_NULL,
								PM_ERR_TRANS_DUP_TARGET,
								PM_ERR_TRANS_NOT_INITIALIZED,
								PM_ERR_TRANS_NOT_PREPARED,
								PM_ERR_TRANS_ABORT,
								PM_ERR_TRANS_TYPE,
								PM_ERR_TRANS_COMMITING,
								PM_ERR_TRANS_DOWNLOADING,
								PM_ERR_PKG_NOT_FOUND,
								PM_ERR_PKG_INVALID,
								PM_ERR_PKG_OPEN,
								PM_ERR_PKG_LOAD,
								PM_ERR_PKG_INSTALLED,
								PM_ERR_PKG_CANT_FRESH,
								PM_ERR_PKG_CANT_REMOVE,
								PM_ERR_PKG_INVALID_NAME,
								PM_ERR_PKG_CORRUPTED,
								PM_ERR_PKG_REPO_NOT_FOUND,
								PM_ERR_GRP_NOT_FOUND,
								PM_ERR_UNSATISFIED_DEPS,
								PM_ERR_CONFLICTING_DEPS,
								PM_ERR_FILE_CONFLICTS,
								PM_ERR_USER_ABORT,
								PM_ERR_INTERNAL_ERROR,
								PM_ERR_LIBARCHIVE_ERROR,
								PM_ERR_DB_SYNC,
								PM_ERR_RETRIEVE,
								PM_ERR_PKG_HOLD,
								PM_ERR_INVALID_REGEX,
								PM_ERR_CONNECT_FAILED,
								PM_ERR_FORK_FAILED

				ctypedef void (*alpm_cb_download)(char *filename, int xfered, int total)
				ctypedef void (*alpm_cb_log) (pmloglevel_t, char *, va_list)
				cdef extern _pmerrno_t pm_errno
				int alpm_initialize ()
				int alpm_release ()
				int alpm_option_set_dbpath (char *path)
				int alpm_option_set_root (char *root)
				char * alpm_strerror (_pmerrno_t errno)
				void alpm_option_set_dlcb (alpm_cb_download dn)
				void alpm_option_set_logcb (alpm_cb_log log)


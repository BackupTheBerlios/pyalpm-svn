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

cimport db
cimport package
cimport config
cimport depend
cimport conflict
cimport group
cimport sync
cimport transaction
from db cimport pmdb_t, Database
from package cimport pmpkg_t, Package, alpm_pkg_load
from config cimport Config
from depend cimport pmdepend_t, pmdepmissing_t, Depend, DepMissing
from conflict cimport pmconflict_t, Conflict
from group cimport pmgrp_t, Group
from sync cimport pmsyncpkg_t, SyncPkg
from transaction cimport Transaction, pmtransevt_t, pmtransconv_t
from transaction cimport pmtranstype_t, pmtransprog_t, pmtransflag_t

#includes python variables that translates the enums
include "enums.pxi"


cdef extern from "stdarg.h":
				# for the alpm_cb_log
				ctypedef void *va_list

cdef extern from "Python.h":
				# for the alpm_cb_log
				object PyString_FromFormatV (char *fmt, va_list ap)

				
# we defines some dummy callbacks, wich will be redefined by the user with
# the appropriate functions
def pycb_dl (filename, transfered, total):
				return None

def pycb_log (level, log):
				return None

cdef void clog (pmloglevel_t lev, char *fmt, va_list args):
				#Pyrex doesn't know anything about va_list, so we translate it to a
				#char*, which Pyrex can translate to a python str
								
				string = PyString_FromFormatV(fmt, args)
				pycb_log(lev, string)
				return
				
cdef void cdown(char *filename, int trans, int tot):
				#we know everything we need... so just call the python callback
				pydl_cb (filename, trans, tot)
				return


def init (dbpath, root):
				#We get the dbpath and root from the user and initialize alpm, setting
				#dbpath, root, dlcb and logcb
				if alpm_initialize() < 0:
								raise RuntimeError, "%s" %alpm_strerror(pm_errno)

				if alpm_option_set_dbpath (dbpath) < 0:
								raise SetOptError("dbpath")

				if alpm_option_set_root (root) < 0:
								raise SetOptError("root")

				alpm_option_set_dlcb (<alpm_cb_download>cdown)
				if pm_errno == PM_ERR_HANDLE_NULL:
								raise SetOptError("download callback")

				alpm_option_set_logcb (<alpm_cb_log>clog)
				if pm_errno == PM_ERR_HANDLE_NULL:
								raise SetOptError("log callback")

def release ():
				alpm_release()
				return

def package_new_from_file (filename):
				#Create a new package from a file
				cdef Package pypkg
				cdef pmpkg_t *pkg

				alpm_pkg_load (filename, &pkg)
				pypkg = Package()
				pypkg.pkg = pkg
				return pypkg

def set_dlcb(down):
				#Set the python download callback
				pycb_dl = down
				return

def set_logcb (logcb):
				#Set the python log callback
				pycb_log = logcb
				return

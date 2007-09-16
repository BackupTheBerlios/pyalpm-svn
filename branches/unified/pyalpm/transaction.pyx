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
cimport depend
cimport conflict
from alpm cimport alpm_strerror, alpm_list_t, alpm_list_first, alpm_list_next
from alpm cimport alpm_list_getdata, pm_errno, _pmerrno_t
from package cimport Package, pmpkg_t
from depend cimport pmdepmissing_t, DepMissing
from conflict cimport pmconflict_t, Conflict

from exceptions import LockError

include 'enums.pxi'

def pycb_event (event, data1, data2):
				return None

def pycb_conv (conv, data1, data2, data3):
				return 0

def pycb_prog (prog, data1, data2, data3, data4):
				return None


cdef void cevent (pmtransevt_t ev, void *data1, void *data2):
				#we need to know of which types are data1 and data2
				cdef Package pkg1
				cdef Package pkg2

				if ev == TRANS_EVT_UPGRADE_DONE:
								#Here we know that data1 and data2 are both pmpkg_t, so we
								#create two Package and call the python callback with 'em
								pkg1 = Package ()
								pkg1.pkg = <pmpkg_t *>data1
								pkg2 = Package
								pkg2.pkg = <pmpkg_t *>data2
								pycb_event (ev, pkg1, pkg2)

				elif ev == TRANS_EVT_PRINTURI:
								#Here we know that data1 and data2 are both char*, so allo we
								#need to do is cast 'em to <char *> while passing 'em to the
								#python callback
								pycb_event (ev, <char *>data1, <char *>data2)
				elif ev == TRANS_EVT_RETRIEVE_START:
								#Here we know that data1 is a char* and data2 is NULL, so we
								#cast data1 to <char *> and pass None for data2
								pycb_event (ev, <char *>data1, None)

				else:
								#Both data1 and data2 are NULL, so we need to pass only the
								#event information
								pycb_event (ev, None, None)
				return

cdef void cconv (pmtransconv_t cv, void *data1, void *data2, void *data3, int *response):
				#Same as before, but with many more cases and void*
				cdef Package pkg1
				cdef Package pkg2

				if cv == TRANS_CONV_INSTALL_IGNOREPKG:
								pkg1 = Package()
								pkg1.pkg = <pmpkg_t *>data1

								#TODO: this is like what they do in pacman... maybe we have to
								#      find a better way (or maybe this works just fine)
								if data2 != NULL:
												pkg2 = Package()
												pkg2.pkg = <pmpkg_t *>data2
												response[0] = pycb_conv (cv, pkg1, pkg2, None)
								else:
												response[0] = pycb_conv (cv, pkg1, None, None)

				elif cv == TRANS_CONV_REMOVE_HOLDPKG:
								pkg1 = Package()
								pkg1.pkg = <pmpkg_t *>data1
								response[0] = pycb_conv (cv, pkg1, None, None)

				elif cv == TRANS_CONV_REPLACE_PKG:
								pkg1 = Package()
								pkg2 = Package()

								pkg1.pkg = <pmpkg_t *>data1
								pkg2.pkg = <pmpkg_t *>data2
								
								response[0] = pycb_conv (cv, pkg1, pkg2, <char *>data3)

				elif cv == TRANS_CONV_CONFLICT_PKG:
								response[0] = pycb_conv (cv, <char *>data1, <char *>data2, None)

				elif cv == TRANS_CONV_LOCAL_NEWER:
								pkg1 = Package()
								pkg1.pkg = <pmpkg_t *>data1
								response[0] = pycb_conv (cv, pkg1, None, None)

				elif cv == TRANS_CONV_LOCAL_UPTODATE:
								pkg1 = Package()
								pkg1.pkg = <pmpkg_t *>data1
								response[0] = pycb_conv (cv, pkg1, None, None)

				elif cv == TRANS_CONV_CORRUPTED_PKG:
								response[0] = pycb_conv (cv, <char *>data1, None, None)

				else:
								response[0] = pycb_conv (cv, None, None, None)
				return

cdef void cprog (pmtransprog_t pr, char *data1, int data2, int data3, int data4):
				pycb_prog (pr, data1, data2, data3, data4)
				return


cdef class Transaction:
				def __new__ (self, type, flags, cb_event, cb_conv, cb_progress):
								#this module-level variables are defined above. We assign
								#the user provided callbacks to them...
								pycb_event = cb_event
								pycb_conv = cb_conv
								pycb_prog = cb_progress

								#... and call alpm_trans_init passing the c callback defined
								#in alpm.pyx and checking for errors
								if alpm_trans_init (type, flags, cevent, cconv, cprog) < 0:
												raise LockError

				def __dealloc__ (self):
								#python user destroyed the transaction... just for sake we 
								#call alpm_trans_relase
								if alpm_trans_release() < 0:
												raise RuntimeError, "Cannot release transaction: %s" %alpm_strerror(pm_errno)

				def get_type (self):
								return alpm_trans_get_type()

				def get_flags (self):
								return alpm_trans_get_flags()

				def sys_upgrade (self):
								if alpm_trans_sysupgrade () < 0:
												raise RuntimeError, "%s" %alpm_strerror(pm_errno)
								return True

				def add_target (self, targ):
								if alpm_trans_addtarget (targ) < 0:
												if pm_errno == ERR_PKG_NOT_FOUND:
																raise PackageNotFound(targ)
												else:
																return False
								return True

				def prepare (self):
								cdef alpm_list_t *data
								cdef alpm_list_t *i
								cdef pmdepmissing_t *miss
								cdef DepMissing missing

								if alpm_trans_prepare (&data) < 0:
												i = alpm_list_first (data)
												missings = []
												while (i):
																missing = DepMissing()
																miss = <pmdepmissing_t *>alpm_list_getdata(i)
																missing.miss = miss
																missings.append(missing)
																i = alpm_list_next (i)
																continue
												if pm_errno == ERR_UNSATISFIED_DEPS:
																raise UnsatisfiedDeps(missings)
												elif pm_errno == ERR_CONFLICTING_DEPS:
																raise ConflictingDeps(missings)
								
				def commit (self):
								cdef alpm_list_t *data
								cdef alpm_list_t *i
								cdef Conflict conf

								if alpm_trans_commit (&data) < 0:
												if pm_errno == ERR_FILE_CONFLICTS:
																i = alpm_list_first(data)
																conflicts = []
																while (i):
																				conf = Conflict()
																				conf.conflict = <pmconflict_t *>alpm_list_getdata(i)
																				conflicts.append(conf)
																				i = alpm_list_next (i)
																				continue
																raise ConflictingFiles(conflicts)
												elif pm_errno == ERR_PKG_CORRUPTED:
																i = alpm_list_first (data)
																corrupts = []
																while (i):
																				corrupts.append(<char *>alpm_list_getdata(i))
																				i = alpm_list_next (i)
																				continue
																raise PackageCorrupted(corrupts)
								

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
from alpm cimport alpm_list_getdata, _pmerrno_t, pm_errno

cdef class Config:
				def __new__ (self, cdirs=[], logfile="", usyslog=None, noup=[], noext=[], ignore=[], hold=[], updelay=None, xfercommand="", nopasv=None):
								if len(cdirs) > 0:
												self.set_cachedirs (cdirs)

								if len(logfile) > 0:
												self.set_logfile (logfile)

								if type (usyslog) is type (True):
												self.set_usesyslog (usyslog)

								if len(noup) > 0:
												self.set_noupgrades (noup)

								if len(noext) > 0:
												self.set_noextracts (noext)

								if len(ignore) > 0:
												self.set_ignorepkg (ignore)

								if len(hold) > 0:
												self.set_holdpkgs (hold)

								if type (updelay) is type(0):
												self.set_upgradedelay(updelay)

								if len (xfercommand) > 0:
												self.set_xfercommand (xfercommand)

								if type (nopasv) is type (True):
												self.set_nopassiveftp (nopasv)

				def set_cachedirs (self, cdirs):
								for dir in cdirs:
												self.add_cachedir (dir)
												continue
								return True

				def add_cachedir (self, dir):
								if alpm_option_add_cachedir (dir) != 0:
												raise RuntimeError, "problem adding cachedir %s: %s" %(dir, alpm_strerror(pm_errno))
								return TRUE

				def get_cachedirs (self):
								cdef alpm_list_t *cdirs
								cdef alpm_list_t *i

								cdirs = alpm_option_get_cachedirs ()
								if cdirs == NULL:
												raise RuntimeError, "you should set at least one cachedir, first!"
								i = alpm_list_first (cdirs)
								ret = []
								while (i):
												ret.append (<char *>alpm_list_getdata(i))
												i = alpm_list_next (i)
												continue
								return ret

				def get_logfile (self):
								return alpm_option_get_logfile ()

				def set_logfile (self, logfile):
								if alpm_option_set_logfile(logfile) != 0:
												raise SetOptError("logfile")
								return True

				def get_lockfile (self):
								return alpm_option_get_lockfile ()

				def get_usesyslog (self):
								return bool(alpm_option_get_usesyslog ())

				def set_usesyslog (self, usesyslog):
								cdef int use
								use = int(usesyslog)

								alpm_option_set_usesyslog (<unsigned short>use)
								if pm_errno == PM_ERR_HANDLE_NULL:
												raise SetOptError("usesyslog")
								return True

				def get_noupgrades (self):
								cdef alpm_list_t *res
								cdef alpm_list_t *i

								res = alpm_option_get_noupgrades ()
								if res == NULL:
												return []

								i = alpm_list_first (res)
								ret = []
								while (i):
												ret.append (<char *>alpm_list_getdata(i))
												i = alpm_list_next (i)
												continue
								return ret

				def set_noupgrades (self, noups):
								for noup in noups:
												self.add_noupgrade (noup)
												continue
								return True

				def add_noupgrade (self, noup):
								alpm_option_add_noupgrade (noup)
								if pm_errno == PM_ERR_HANLDE_NULL:
												raise RuntimeError, "failed to add noupgrade package %s: %s" %(noup, alpm_strerror(pm_errno))
								return True

				def set_noextracts (self, noexts):
								for noext in noexts:
												self.add_noextract (noext)
												continue
								return True

				def add_noextract (self, noext):
								alpm_option_add_noextract (noext)
								if pm_errno == PM_ERR_HANDLE_NULL:
												raise RuntimeError, "failed to add %s to noextract: %s" %(noext, alpm_strerror(pm_errno))
								return True

				def get_noextracts (self):
								cdef alpm_list_t *noexts
								cdef alpm_list_t *i

								noexts = alpm_option_get_noextracts ()
								if noexts == NULL:
												return []

								i = alpm_list_first (noexts)
								ret = []
								while (i):
												ret.append (<char *>alpm_list_getdata(i))
												i = alpm_list_next (i)
												continue
								return ret

				def set_ignorepkgs (self, igns):
								for ign in igns:
												self.add_ignorepkg (ign)
												continue
								return True

				def add_ignorepkg (self, ign):
								if alpm_add_ignorepkg (ign) != 0:
												raise RuntimeError, "problem adding %s to ignore packages: %s" %(ign, alpm_strerror(pm_errno))
								return True

				def get_ignorepkgs (self):
								cdef alpm_list_t *igns
								cdef alpm_list_t *i

								igns = alpm_option_get_ignorepkgs ()
								if igns == NULL:
												return []

								i = alpm_list_first (igns)
								ret = []
								while (i):
												ret.append (<char *>alpm_list_getdata (i))
												i = alpm_list_next (i)
												continue
								return ret

				def set_holdpkgs (self, holds):
								for hold in holds:
												self.add_holdpkg (hold)
												continue
								return True

				def add_holdpkg (self, hold):
								alpm_option_add_holdpkg (hold)
								if pm_errno == PM_ERR_HANDLE_NULL:
												raise RuntimeError, "problem adding %s to hold packages: %s" %(hold, alpm_strerror(pm_errno))
								return True

				def get_holdpkgs (self):
								cdef alpm_list_t *holds
								cdef alpm_list_t *i

								holds = alpm_option_get_holdpkgs ()
								if holds == NULL:
												return []

								i = alpm_list_first (holds)
								ret = []
								while (i):
												ret.append(<char *>alpm_list_getdata(i))
												i = alpm_list_next (i)
												continue
								return ret

				def get_upgradedelay (self):
								return alpm_option_get_upgradedelay()
				
				def set_upgradedelay (self, delay):
								alpm_option_set_upgradedelay (delay)
								if pm_errno == PM_ERR_HANDLE_NULL:
												raise SetOptError("upgradedelay")
								return True

				def get_xfercommand (self):
								return alpm_option_get_xfercommand ()

				def set_xfercommand (self, command):
								alpm_option_set_xfercommand (command)
								if pm_errno == PM_ERR_HANDLE_NULL:
												raise SetOptError ("xfercommand")
								return True

				def get_nopassiveftp (self):
								return alpm_option_get_nopassiveftp()

				def set_nopassiveftp (self, nopassv):
								cdef int np

								np = nopassv
								alpm_option_set_nopassiveftp (<unsigned short>np)
								if pm_errno == PM_ERR_HANDLE_NULL:
												raise SetOptError ("nopassiveftp")
								return True

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

cdef extern from "time.h":
				ctypedef long time_t

cdef extern from "alpm.h":
				alpm_list_t * alpm_option_get_cachedirs ()
				int alpm_option_add_cachedir (char *cache)
				void alpm_option_set_cachedirs (alpm_list_t *cachedirs)

				char * alpm_option_get_logfile ()
				int alpm_option_set_logfile (char *logfile)

				char * alpm_option_get_lockfile ()

				unsigned short alpm_option_get_usesyslog ()
				void alpm_option_set_usesyslog (unsigned short usesyslog)

				alpm_list_t * alpm_option_get_noupgrades ()
				void alpm_option_add_noupgrade (char *pkg)
				void alpm_option_set_noupgrades (alpm_list_t *noupgrade)

				alpm_list_t * alpm_option_get_noextracts ()
				void alpm_option_add_noextract (char *pkg)
				void alpm_option_set_noextracts (alpm_list_t *noextracts)

				alpm_list_t * alpm_option_get_ignorepkgs ()
				void alpm_option_add_ignorepkg ()
				void alpm_option_set_ignorepkgs (alpm_list_t *ignorepkgs)

				alpm_list_t * alpm_option_get_holdpkgs ()
				void alpm_option_add_holdpkg (char *pkg)
				void alpm_option_set_holdpkgs (alpm_list_t *holdpkgs)

				time_t alpm_option_get_upgradedelay ()
				void alpm_option_set_upgradedelay (time_t delay)

				char * alpm_option_get_xfercommand ()
				void alpm_option_set_xfercommand (char *command)

				unsigned short alpm_option_get_nopassiveftp ()
				void alpm_option_set_nopassiveftp (unsigned short nopasv)

cdef class Config:
				pass

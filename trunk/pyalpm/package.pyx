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
from alpm cimport alpm_list_getdata

cdef class Package:
				def get_name (self):
								return alpm_pkg_get_name (self.pkg)

				def get_filename (self):
								name = alpm_pkg_get_filename (self.pkg)
								if name == None:
												raise RuntimeError, "%s" %alpm_strerror(pm_errno)
								return name

				def get_version (self):
								return alpm_pkg_get_version (self.pkg)

				def get_description (self):
								return alpm_pkg_get_desc (self.pkg)

				def get_url (self):
								return alpm_pkg_get_url (self.pkg)

				def get_builddate (self):
								return alpm_pkg_get_builddate (self.pkg)

				def get_installdate (self):
								return alpm_pkg_get_installdate (self.pkg)

				def get_packager (self):
								return alpm_pkg_get_packager (self.pkg)

				def get_md5sum (self):
								return alpm_pkg_get_md5sum (self.pkg)

				def get_arch (self):
								return alpm_pkg_get_arch (self.pkg)

				def get_size (self):
								return alpm_pkg_get_size (self.pkg)

				def get_isize (self):
								return alpm_pkg_get_isize (self.pkg)

				def get_reason (self):
								if (alpm_pkg_get_reason (self.pkg) == PM_PKG_REASON_EXPLICIT):
												return False
								else:
												return True

				def has_scriptlet (self):
								if (alpm_pkg_has_scriptlet (self.pkg)):
												return True
								else:
												return False

#Methods belows get an alpm_list_t* from the alpm function, which pyrex can't
#handle. So we here translate alpm_list_t * to a python list, assuming (and we
#know that it's so) that those alpm_lists contain only char*
				def get_licenses (self):
								cdef alpm_list_t *lic
								cdef alpm_list_t *i

								lic = alpm_pkg_get_licenses (self.pkg)
								i = alpm_list_first (lic)

								ret = []
								while (i):
												ret.append (<char *>alpm_list_getdata(i))
												i = alpm_list_next (i)
												continue
								return ret

				def get_group (self):
								cdef alpm_list_t *grp
								cdef alpm_list_t *i

								grp = alpm_pkg_get_groups (self.pkg)
								i = alpm_list_first (grp)

								ret = []
								while (i):
												ret.append (<char *>alpm_list_getdata(i))
												i = alpm_list_next (i)
												continue
								return ret

				def get_depends (self):
								cdef alpm_list_t *dep
								cdef alpm_list_t *i

								dep = alpm_pkg_get_depends (self.pkg)
								i = alpm_list_first (dep)

								ret = []
								while (i):
												ret.append (<char *>alpm_list_getdata (i))
												i = alpm_list_next (i)
												continue
								return ret

				def get_requiredby (self):
								cdef alpm_list_t *req
								cdef alpm_list_t *i

								req = alpm_pkg_get_requiredby (self.pkg)
								i = alpm_list_first (req)

								ret = []
								while (i):
												ret.append (<char *>alpm_list_getdata(i))
												i = alpm_list_next (i)
												continue
								return ret

				def get_conflicts (self):
								cdef alpm_list_t *conf
								cdef alpm_list_t *i

								conf = alpm_pkg_get_conflicts(self.pkg)
								i = alpm_list_first (conf)

								ret = []
								while (i):
												ret.append (<char *>alpm_list_getdata(i))
												i = alpm_list_next (i)
												continue
								return ret
				
				def get_provides (self):
								cdef alpm_list_t *prov
								cdef alpm_list_t *i
								
								prov = alpm_pkg_get_provides(self.pkg)
								i = alpm_list_first (prov)
								
								ret = []
								while (i):
												ret.append (<char *>alpm_list_getdata(i))
												i = alpm_list_next (i)
												continue
								return ret
				
				def get_replaces (self):
								cdef alpm_list_t *rep
								cdef alpm_list_t *i
								
								rep = alpm_pkg_get_replaces(self.pkg)
								i = alpm_list_first (rep)
								
								ret = []
								while (i):
												ret.append (<char *>alpm_list_getdata(i))
												i = alpm_list_next (i)
												continue
								return ret

				def get_files (self):
								cdef alpm_list_t *files
								cdef alpm_list_t *i
								
								files = alpm_pkg_get_files(self.pkg)
								i = alpm_list_first (files)

								ret = []
								while (i):
												ret.append (<char *>alpm_list_getdata(i))
												i = alpm_list_next (i)
												continue
								return ret
				
				def get_backup (self):
								cdef alpm_list_t *bck
								cdef alpm_list_t *i
								
								bck = alpm_pkg_get_backup(self.pkg)
								i = alpm_list_first (bck)

								ret = []
								while (i):
												ret.append(<char *>alpm_list_getdata(i))
												i = alpm_list_next (i)
												continue
								return ret

def package_new_from_file (filename):
				#Create a new package from a file
				cdef Package pypkg
				cdef pmpkg_t *pkg

				alpm_pkg_load (filename, &pkg)
				pypkg = Package()
				pypkg.pkg = pkg
				return pypkg


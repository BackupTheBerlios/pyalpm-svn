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
from alpm cimport alpm_strerror, alpm_list_t, alpm_list_first, alpm_list_next
from alpm cimport alpm_list_getdata, alpm_list_new, alpm_list_add, pm_errno
from package cimport pmpkg_t, Package

cdef class Database:
				def __new__(self, name = None):
								if name is None:
												#we assume user wants to register the local repo
												self.db = alpm_db_register_local()
												if self.db is NULL:
																err = alpm_strerror(pm_errno)
																raise RuntimeError, "Cannot create db local: %s" %err
								else:
												#register the 'name' repo
												self.db = alpm_db_register_sync (name)
												if self.db is NULL:
																err = alpm_strerror(pm_errno)
																raise RuntimeError, "Cannot create db %s: %s" %(name, err)


				def __dealloc__(self):
								#unregister the repo stored in self.db
								alpm_db_unregister (self.db)

				def get_name (self):
								self.name = <char *>alpm_db_get_name (self.db)
								if self.name is NULL:
												raise RuntimeError, "cannot get database name: %s" %alpm_strerror(pm_errno)
								return self.name

				def get_package (self, name):
								cdef pmpkg_t *pkg
								cdef Package pypkg

								#we get a pmpkg_t from alpm and return a python Package
								pkg = alpm_db_get_pkg (self.db, name)
								pypkg = Package()
								pypkg.pkg = pkg
								return pypkg

				def get_packages (self):
								cdef alpm_list_t *pkgs
								cdef alpm_list_t *i
								cdef Package pkg

								#translate the return alpm_list_t* which contains pmpkg_t*
								#to a python list which contains python Packages
								ret = []
								pkgs = alpm_db_getpkgcache (self.db)
								i = alpm_list_first (pkgs)
								while (i):												
												pkg = Package()
												pkg.pkg = <pmpkg_t *>alpm_list_getdata(i)
												i = alpm_list_next(i)
												ret.append(pkg)
												continue	
								return ret

				def search (self, keys):
								cdef alpm_list_t *k
								cdef alpm_list_t *res
								cdef alpm_list_t *i
								cdef Package pkg
								cdef char *key

								#we get a python list of keys from the user, but the alpm
								#function wants an alpm_list_t*, so we have to create one
								k = alpm_list_new()
								ret = []
								for l in keys:
												key = l
												k = alpm_list_add (k, key)
												continue

								#now that we have our alpm_list of keys, we can call
								#alpm_db_search, which return an alpm_list_t* containing 
								#pmpkg_t*... pyrex doesn't like it, so we translate it to 
								#a python list containing python Package
								res = alpm_db_search (self.db, k)
								i = alpm_list_first (res)
								while (i):
												pkg = Package()
												pkg.pkg = <pmpkg_t *>alpm_list_getdata (i)
												ret.append(pkg)
												i = alpm_list_next(i)
												continue

								return ret

				def update(self, level):
								alpm_db_update (level, self.db)

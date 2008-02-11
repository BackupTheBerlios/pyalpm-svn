initpackage()

from package cimport Package, alpm_pkg_get_name
from list cimport alpm_list_t, alpm_list_first, alpm_list_next, alpm_list_add, alpm_list_new, alpm_list_getdata
from group cimport Group, alpm_grp_get_name

cdef class Database:
	
	def get_name(self):
		return alpm_db_get_name(self.db)

	def get_url(self):
		return alpm_db_get_url(self.db)

	def set_server(self, server):
		return alpm_db_setserver(self.db, server)

	def update (self, level):
		return alpm_db_update(level, self.db)

	def get_package(self, pkg_name):
		cdef pmpkg_t *pkg
		cdef Package py_pkg

		pkg = alpm_db_get_pkg(self.db, pkg_name)
		py_pkg = Package()
		py_pkg.pkg = pkg
		return py_pkg

	def get_pkgcache(self):
		cdef alpm_list_t *pkgcache
		cdef alpm_list_t *i
		cdef pmpkg_t *tmp
		cdef Package py_tmp

		ret = {}
		
		pkgcache = alpm_db_getpkgcache(self.db)
		
		i = alpm_list_first(pkgcache)
		while i != NULL:
			tmp = <pmpkg_t*>alpm_list_getdata(i)
			py_tmp = Package()
			py_tmp.pkg = tmp
			ret[alpm_pkg_get_name(tmp)] = py_tmp

			i = alpm_list_next(i)
			continue

		return ret

	def what_provides(self, pkg_name):
		cdef alpm_list_t *provides
		cdef alpm_list_t *i
		
		ret = []

		provides = alpm_db_whatprovides(self.db, pkg_name)
		i = alpm_list_first(provides)
		
		while i:
			ret.append(<char *>alpm_list_getdata(i))
			i = alpm_list_next(i)
			continue

		return ret

	def read_grp(self, grp_name):
		cdef pmgrp_t *grp
		cdef Group py_grp

		grp = alpm_db_readgrp(self.db, grp_name)
		py_grp = Group()
		py_grp.grp = grp
		return py_grp

	#def get_grpcache(self):
	#	cdef alpm_list_t *grpcache
	#	cdef alpm_list_t *i
	#	cdef Group py_tmp
	#
	#	ret = {}
	#
	#	grpcahce = alpm_db_getgrpcache(self.db)
	#	i = alpm_list_first(grpcache)
	#
	#	while i:
	#		py_tmp = Group()
	#		py_tmp.grp = <pmgrp_t *>alpm_list_getdata(i)
	#		ret[alpm_grp_get_name(py_tmp.grp)] = py_tmp
	#		i = alpm_list_next(i)
	#		continue
	#	return ret

	def search(self, needles):
		cdef alpm_list_t *pmneedles
		cdef alpm_list_t *results
		cdef alpm_list_t *i
		cdef Package py_tmp

		res = {}

		pmneedles = alpm_list_new()
		for needle in needles:
			pmneedles = alpm_list_add(pmneedles, <void *>needle)
			continue

		results = alpm_db_search(self.db, pmneedles)
		
		i = alpm_list_first(results)
		while i:
			py_tmp = Package()
			py_tmp.pkg = <pmpkg_t *>alpm_list_getdata(i)
			res[alpm_pkg_get_name(py_tmp.pkg)] = py_tmp
			continue

		return res




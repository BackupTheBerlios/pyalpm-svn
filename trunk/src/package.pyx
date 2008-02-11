from list cimport alpm_list_t, alpm_list_first, alpm_list_getdata, alpm_list_next
from database cimport Database

cdef class Depends:
	def get_mod(self):
		return alpm_dep_get_mod(self.dep)

	def get_name(self):
		return alpm_dep_get_name(self.dep)

	def get_version(self):
		return alpm_dep_get_version(self.dep)

	def get_string(self):
		return alpm_dep_get_string(self.dep)


cdef class Package:
	
	def check_md5sum(self):
		return alpm_pkg_checkmd5sum(self.pkg)

	def fetch_pkgurl(self, url):
		return alpm_fetch_pkgurl(url)

	def compute_requiredby(self):
		cdef alpm_list_t *reqby
		cdef alpm_list_t *i

		ret = []

		reqby = alpm_pkg_compute_requiredby(self.pkg)
		i = alpm_list_first(reqby)
		while i:
			ret.append(<char *>alpm_list_getdata(i))
			i = alpm_list_next(i)
			continue
		return ret

	def get_filename(self):
		return alpm_pkg_get_filename(self.pkg)

	def get_name(self):
		return alpm_pkg_get_name(self.pkg)

	def get_version(self):
		return alpm_pkg_get_version(self.pkg)

	def get_desc(self):
		return alpm_pkg_get_desc(self.pkg)

	def get_url(self):
		return alpm_pkg_get_url(self.pkg)

	def get_builddate(self):
		return alpm_pkg_get_builddate(self.pkg)

	def get_installdate(self):
		return alpm_pkg_get_installdate(self.pkg)

	def get_packager(self):
		return alpm_pkg_get_packager(self.pkg)

	def get_md5sum(self):
			return alpm_pkg_get_md5sum(self.pkg)

	def get_arch(self):
		return alpm_pkg_get_arch(self.pkg)

	def get_size(self):
		return alpm_pkg_get_size(self.pkg)

	def get_isize(self):
		return alpm_pkg_get_isize(self.pkg)

	def get_reason(self):
		cdef pmpkgreason_t reason

		reason = alpm_pkg_get_reason(self.pkg)

		if reason == PM_PKG_REASON_EXPLICIT:
			return 0
		else:
			return 1

	def get_licenses(self):
		cdef alpm_list_t *licenses
		cdef alpm_list_t *i

		ret = []

		licenses = alpm_pkg_get_licenses(self.pkg)
		i = alpm_list_first(licenses)

		while i:
			ret.append(<char *>alpm_list_getdata(i))
			i = alpm_list_next(i)
			continue
		return ret

	def get_groups(self):
		cdef alpm_list_t *groups
		cdef alpm_list_t *i

		ret = []

		groups = alpm_pkg_get_groups(self.pkg)
		i = alpm_list_first(groups)

		while i:
			ret.append(<char *>alpm_list_getdata(i))
			i = alpm_list_next(i)
			continue
		return ret

	def get_depends(self):
		cdef alpm_list_t *deps
		cdef alpm_list_t *i
		cdef Depends py_tmp

		ret = {}

		deps = alpm_pkg_get_depends(self.pkg)
		i = alpm_list_first(deps)

		while i:
			py_tmp = Depends()
			py_tmp.dep = <pmdepend_t *>alpm_list_getdata(i)
			ret[alpm_dep_get_name(py_tmp.dep)] = py_tmp
			
			i = alpm_list_next(i)
			continue
		return ret

	def get_optdepends(self):
		cdef alpm_list_t *deps
		cdef alpm_list_t *i
		cdef Depends py_tmp

		ret = {}

		deps = alpm_pkg_get_optdepends(self.pkg)
		i = alpm_list_first(deps)

		while i:
			py_tmp = Depends()
			py_tmp.dep = <pmdepend_t *>alpm_list_getdata(i)
			ret[alpm_dep_get_name(py_tmp.dep)] = py_tmp

			i = alpm_list_next(i)
			continue
		return ret

	def get_conflicts(self):
		cdef alpm_list_t *conflicts
		cdef alpm_list_t *i
		
		ret = []

		conflicts = alpm_pkg_get_conflicts(self.pkg)
		i = alpm_list_first(conflicts)

		while i:
			ret.append(<char *>alpm_list_getdata(i))
			i = alpm_list_next(i)
			continue
		return ret

	def get_provides(self):
		cdef alpm_list_t *provides
		cdef alpm_list_t *i

		ret = []

		provides = alpm_pkg_get_provides(self.pkg)
		i = alpm_list_first(provides)

		while i:
			ret.append(<char *>alpm_list_getdata(i))
			i = alpm_list_next(i)
			continue
		return ret

	def get_replaces(self):
		cdef alpm_list_t *replace
		cdef alpm_list_t *i

		ret = []

		replace = alpm_pkg_get_replaces(self.pkg)
		i = alpm_list_first(replace)

		while i:
			ret.append(<char *>alpm_list_getdata(i))
			i = alpm_list_next(i)
			continue
		return ret

	def get_files(self):
		cdef alpm_list_t *files
		cdef alpm_list_t *i

		ret = []

		files = alpm_pkg_get_files(self.pkg)
		i = alpm_list_first(files)

		while i:
			ret.append(<char *>alpm_list_getdata(i))
			i = alpm_list_next(i)
			continue
		return ret

	def get_backup(self):
		cdef alpm_list_t *backup
		cdef alpm_list_t *i

		ret = []

		backup = alpm_pkg_get_backup(self.pkg)
		i = alpm_list_first(backup)

		while i:
			ret.append(<char *>alpm_list_getdata(i))
			i = alpm_list_next(i)
			continue
		return ret

	def has_scriptlet(self):
		return alpm_pkg_has_scriptlet(self.pkg)


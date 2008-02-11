from list cimport alpm_list_t

cdef extern from "alpm.h":
	ctypedef long time_t
	ctypedef long size_t
	ctypedef struct pmpkg_t
	ctypedef struct pmdb_t
	ctypedef enum pmpkgreason_t:
		PM_PKG_REASON_EXPLICIT = 0
		PM_PKG_REASON_DEPEND = 1

	ctypedef struct pmdepend_t
	ctypedef enum pmdepmod_t:
		PM_DEP_MOD_ANY = 1
		PM_DEP_MOD_EQ
		PM_DEP_MOD_GE
		PM_DEP_MOD_LE
		PM_DEP_MOD_GT
		PM_DEP_MOD_LT

	pmdepmod_t alpm_dep_get_mod(pmdepend_t *dep)
	char *alpm_dep_get_name(pmdepend_t *dep)
	char *alpm_dep_get_version(pmdepend_t *dep)
	char *alpm_dep_get_string(pmdepend_t *dep)

	int alpm_pkg_load (char *fname, unsigned short full, pmpkg_t **pkg)
	int alpm_pkg_free(pmpkg_t *pkg)
	int alpm_pkg_checkmd5sum(pmpkg_t *pkg)
	char *alpm_fetch_pkgurl(char *url)
	alpm_list_t *alpm_pkg_compute_requiredby(pmpkg_t *pkg)

	char *alpm_pkg_get_filename(pmpkg_t *pkg)
	char *alpm_pkg_get_name(pmpkg_t *pkg)
	char *alpm_pkg_get_version(pmpkg_t *pkg)
	char *alpm_pkg_get_desc(pmpkg_t *pkg)
	char *alpm_pkg_get_url(pmpkg_t *pkg)
	time_t alpm_pkg_get_builddate(pmpkg_t *pkg)
	time_t alpm_pkg_get_installdate(pmpkg_t *pkg)
	char *alpm_pkg_get_packager(pmpkg_t *pkg)
	char *alpm_pkg_get_md5sum(pmpkg_t *pkg)
	char *alpm_pkg_get_arch(pmpkg_t *pkg)
	unsigned long alpm_pkg_get_size(pmpkg_t *pkg)
	unsigned long alpm_pkg_get_isize(pmpkg_t *pkg)
	pmpkgreason_t alpm_pkg_get_reason(pmpkg_t *pkg)
	alpm_list_t *alpm_pkg_get_licenses(pmpkg_t *pkg)
	alpm_list_t *alpm_pkg_get_groups(pmpkg_t *pkg)
	alpm_list_t *alpm_pkg_get_depends(pmpkg_t *pkg)
	alpm_list_t *alpm_pkg_get_optdepends(pmpkg_t *pkg)
	alpm_list_t *alpm_pkg_get_conflicts(pmpkg_t *pkg)
	alpm_list_t *alpm_pkg_get_provides(pmpkg_t *pkg)
	alpm_list_t *alpm_pkg_get_deltas(pmpkg_t *pkg)
	alpm_list_t *alpm_pkg_get_replaces(pmpkg_t *pkg)
	alpm_list_t *alpm_pkg_get_files(pmpkg_t *pkg)
	alpm_list_t *alpm_pkg_get_backup(pmpkg_t *pkg)
	void *alpm_pkg_changelog_open(pmpkg_t *pkg)
	size_t alpm_pkg_changelog_read(void *ptr, size_t size, pmpkg_t *pkg, void *fp)
	int alpm_pkg_changelog_close(pmpkg_t *pkg, void *fp)
	unsigned short alpm_pkg_has_scriptlet(pmpkg_t *pkg)
	unsigned long alpm_pkg_download_size(pmpkg_t *newpkg, pmdb_t *dblocal)

cdef class Depends:
	cdef pmdepend_t *dep

cdef class Package:
	cdef pmpkg_t *pkg


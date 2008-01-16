cdef extern from "Python.h":
	ctypedef void* va_list
	object PyString_FromFormatV(char *format, va_list vargs)

cdef extern from "alpm_list.h":
	ctypedef struct alpm_list_t

	alpm_list_t *alpm_list_new()
	void alpm_list_free(alpm_list_t *list)
	
	alpm_list_t *alpm_list_add(alpm_list_t *list, void *data)
	alpm_list_t *alpm_list_join(alpm_list_t *first, alpm_list_t *second)
	alpm_list_t *alpm_list_first(alpm_list_t *list)
	alpm_list_t *alpm_list_nth(alpm_list_t *list, int n)
	alpm_list_t *alpm_list_next(alpm_list_t *list)
	alpm_list_t *alpm_list_last(alpm_list_t *list)
	void *alpm_list_getdata(alpm_list_t *entry)
	int alpm_list_count(alpm_list_t *list)
	
cdef extern from "alpm.h":
	ctypedef long time_t
	ctypedef long size_t
	ctypedef struct pmdb_t
	ctypedef struct pmpkg_t
	ctypedef struct pmdelta_t
	ctypedef struct pmgrp_t
	ctypedef struct pmserver_t
	ctypedef struct pmtrans_t
	ctypedef struct pmsyncpkg_t
	ctypedef struct pmdepend_t
	ctypedef struct pmdepmissing_t
	ctypedef struct pmconflict_t
	ctypedef struct pmfileconflict_t
	ctypedef struct pmgraph_t

	int alpm_initialize ()
	int alpm_release ()
	
	ctypedef enum pmloglevel_t:
		PM_LOG_ERROR = 0x01
		PM_LOG_WARNING = 0x02
		PM_LOG_DEBUG = 0x04
		PM_LOG_FUNCTION = 0x08

	int alpm_logaction (char *fmt, ...)
	
	ctypedef void (*alpm_cb_log) (pmloglevel_t, char *, va_list)
	ctypedef void (*alpm_cb_download) (char *filename, int file_xfered,
			int file_total, int list_xfered, int list_total)
	
	alpm_cb_log alpm_option_get_logcb()
	void alpm_option_set_logcb(alpm_cb_log cb)

	alpm_cb_download alpm_option_get_dlcb()
	void alpm_option_set_dlcb(alpm_cb_download cb)

	char *alpm_option_get_root()
	int alpm_option_set_root(char *root)

	char *alpm_option_get_dbpath ()
	int alpm_option_set_dbpath (char *dbpath)

	alpm_list_t *alpm_option_get_cachedirs()
	int alpm_option_add_cachedir(char *cachedir)
	void alpm_option_set_cachedirs(alpm_list_t *cachedirs)
	int alpm_option_remove_cacehdir(char *cachedir)

	char *alpm_option_get_logfile()
	int alpm_option_set_logfile(char *logfile)

	char *alpm_get_lockfile()

	unsigned short alpm_option_get_usesyslog()
	void alpm_option_set_usesyslog(unsigned short usesyslog)

	alpm_list_t *alpm_option_get_noupgrades()
	void alpm_option_add_noupgrade(char *pkg)
	void alpm_option_set_noupgrades(alpm_list_t *noupgrade)
	int alpm_option_remove_noupgrade(char *pkg)

	alpm_list_t *alpm_option_get_noextracts()
	void alpm_option_add_noextract(char *pkg)
	void alpm_option_set_noextracts(alpm_list_t *noextract)
	int alpm_option_remove_noextract(char *pkg)

	alpm_list_t *alpm_option_get_ignorepkgs()
	void alpm_option_add_ignorepkg(char *pkg)
	void alpm_option_set_ignorepkgs(alpm_list_t *ignorepkgs)
	int alpm_option_remove_ignorepkg(char *pkg)

	alpm_list_t *alpm_option_get_holdpkgs()
	void alpm_option_add_holdpkg(char *pkg)
	void alpm_option_set_holdpkgs(alpm_list_t *holdpkgs)
	int alpm_option_remove_holdpkg(char *pkg)

	alpm_list_t *alpm_option_get_ignoregrps()
	void alpm_option_add_ignoregrp(char *grp)
	void alpm_option_set_ignoregrps(alpm_list_t *ignoregrps)
	int alpm_option_remove_ignoregrp(char *grp)

	char *alpm_option_get_xfercommand()
	void alpm_option_set_xfercommand(char *cmd)

	unsigned short alpm_option_get_nopassiveftp()
	void alpm_option_set_nopasiveftp(unsigned short nopasv)
	void alpm_option_set_usedelta (unsigned short usedelta)

	pmdb_t *alpm_option_get_localdb()
	alpm_list_t *alpm_option_get_syncdbs()

	pmdb_t *alpm_db_register_local()
	pmdb_t *alpm_db_register_sync(char *treename)
	int alpm_db_unregister (pmdb_t *db)
	int alpm_db_unregistera_all ()

	char *alpm_db_get_name(pmdb_t *db)
	char *alpm_db_get_url(pmdb_t *db)

	int alpm_db_setserver(pmdb_t *db, char *url)

	int alpm_db_update(int level, pmdb_t *db)

	pmpkg_t *alpm_db_get_pkg(pmdb_t *db, char *name)
	alpm_list_t *alpm_db_getpkgcache (pmdb_t *db)
	alpm_list_t *alpm_db_search(pmdb_t *db, alpm_list_t *needles)

	ctypedef enum pmpkgreason_t:
		PM_PKG_REASON_EXPLICIT = 0
		PM_PKG_REASON_DEPEND

	int alpm_pkg_load(char *filename, unsigned short full, pmpkg_t **pkg)
	int alpm_pkg_free(pmpkg_t *pkg)
	int alpm_pkg_checkmd5sum(pmpkg_t *pkg)
	char *alpm_fetch_pkgurl(char *url)
	int alpm_pkg_vercmp(char *ver1, char *ver2)
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
	size_t alpm_pkg_chengelog_read(void *ptr, size_t size, pmpkg_t *pkg,
			void *fp)
	int alpm_pkg_changelog_close(pmpkg_t *pkg, void *fp)
	unsigned short alpm_pkg_has_scriptlet(pmpkg_t *pkg)
	unsigned long alpm_pkg_download_size(pmpkg_t *newpkg, pmdb_t *db_local)

	char *alpm_delta_get_from(pmdelta_t *delta)
	char *alpm_delta_get_to(pmdelta_t *delta)
	unsigned long alpm_delta_get_size(pmdelta_t *delta)
	char *alpm_delta_get_filename(pmdelta_t *delta)
	char *alpm_delta_get_md5sum(pmdelta_t *delta)

	char *alpm_grp_get_name(pmgrp_t *grp)
	alpm_list_t *alpm_grp_get_pkgs(pmgrp_t *grp)

	ctypedef enum pmsynctype_t:
		PM_SYNC_TYPE_REPLACE = 1
		PM_SYNC_TYPE_UPGRADE
		PM_SYNC_TYPE_DEPEND

	pmsynctype_t alpm_sync_get_type(pmsyncpkg_t *sync)
	pmpkg_t *alpm_sync_get_pkg(pmsyncpkg_t *sync)
	void *alpm_sync_get_data(pmsyncpkg_t *sync)
	int alpm_sync_sysupgrade(pmdb_t *db_local, alpm_list_t *dbs_sync,
			alpm_list_t **syncpkgs)

	ctypedef enum pmtranstype_t:
		PM_TRANS_TYPE_ADD = 1
		PM_TRANS_TYPE_REMOVE
		PM_TRANS_TYPE_REMOVEUPGRADE
		PM_TRANS_TYPE_UPGRADE
		PM_TRANS_TYPE_SYNC

	ctypedef enum pmtransflag_t:
		PM_TRANS_FLAG_NODEPS = 0x01
		PM_TRANS_FLAG_FORCE = 0x02
		PM_TRANS_FLAG_NOSAVE = 0x04
		PM_TRANS_FLAG_CASCADE = 0x10
		PM_TRANS_FLAG_RECURSE = 0x20
		PM_TRANS_FLAG_DBONLY = 0x40
		PM_TRANS_FLAG_DEPENDSONLY = 0x80
		PM_TRANS_FLAG_ALLDEPS = 0x100
		PM_TRANS_FLAG_DOWNLOADONLY = 0x200
		PM_TRANS_FLAG_NOSCRIPTLET = 0x400
		PM_TRANS_FLAG_NOCLONFLICTS = 0x800
		PM_TRANS_FLAG_PRINTURIS = 0x1000
		PM_TRANS_FLAG_NEEDED = 0x2000

	ctypedef enum pmtranevt_t:
		PM_TRANS_EVT_CHECKDEPS_START = 1
		PM_TRANS_EVT_CHECKDEPS_DONE
		PM_TRANS_EVT_FILECONFLICTS_START
		PM_TRANS_EVT_FILECONFLICTS_DONE
		PM_TRANS_EVT_RESOLVEDEPS_START
		PM_TRANS_EVT_RESOLVEDEPS_DONE
		PM_TRANS_EVT_INTERCONFLICTS_START
		PM_TRANS_EVT_INTERCONFLICTS_DONE
		PM_TRANS_EVT_ADD_START
		PM_TRANS_EVT_ADD_DONE
		PM_TRANS_EVT_REMOVE_START
		PM_TRANS_EVT_REMOVE_DONE
		PM_TRANS_EVT_UPGRADE_START
		PM_TRANS_EVT_UPGRADE_DONE
		PM_TRANS_EVT_EXTRACT_DONE
		PM_TRANS_EVT_INTEGRITY_START
		PM_TRANS_EVT_DELTA_INTEGRITY_START
		PM_TRANS_EVT_DELTA_INTEGRITY_DONE
		PM_TRANS_EVT_DELTA_PATCHES_START
		PM_TRANS_EVT_DELTA_PATCHES_DONE
		PM_TRANS_EVT_DELTA_PATCH_START
		PM_TRANS_EVT_DELTA_PATCH_DONE
		PM_TRANS_EVT_DELTA_PATCH_FAILED
		PM_TRANS_EVT_SCRIPTLET_INFO
		PM_TRANS_EVT_PRINTURI
		PM_TRANS_EVT_RETRIVE_START
	
	ctypedef enum pmtransconv_t:
		PM_TRANS_CONV_INSTALL_IGNOREPKG = 0x01
		PM_TRANS_CONV_REPLACE_PKG
		PM_TRANS_CONV_CONFLICT_PKG
		PM_TRANS_CONV_CORRUPTED_PKG
		PM_TRANS_CONV_LOCAL_NEWER
		PM_TRANS_CONV_REMOVE_HOLDPKG

	ctypedef enum pmtransprog_t:
		PM_TRANS_PROGRESS_ADD_START
		PM_TRANS_PROGRESS_UPGRADE_START
		PM_TRANS_PROGRESS_REMOVE_START
		PM_TRANS_PROGRESS_CONFLICTS_START

	ctypedef void (*alpm_trans_cb_event)(pmtransevt_t, void *, void *)
	ctypedef void (*alpm_trans_cb_conv)(pmtransconv_t, void *, void *,
			void *, int *)
	ctypedef void (*alpm_trans_cb_progress)(pmtransprog_t, char *, int, int, int)

	pmtranstype_t alpm_trans_get_type()
	unsigned int alpm_trans_get_flags()
	alpm_list_t *alpm_trans_get_targets()
	alpm_list_t *alpm_trans_get_pkgs()
	int alpm_trans_init(pmtranstype_t type, pmtransflag_t flags, 
			alpm_trans_cb_event cb_event, alpm_trans_cb_conv conv,
			alpm_trans_cb_progress cb_progress)
	int alpm_trans_sysupgrade()
	int alpm_trans_addtarget(char *target)
	int alpm_trans_prepare(alpm_list_t **data)
	int alpm_trans_commit(alpm_list_t **data)
	int alpm_trans_interrupt()
	int alpm_trans_release()

	ctypedef enum pmdepmod_t:
		PM_DEP_MOD_ANY = 1
		PM_DEP_MOD_EQ
		PM_DEP_MOD_GE
		PM_DEP_MOD_LE
		PM_DEP_MOD_GT
		PM_DEP_MOD_LT

	pmdepend_t *alpm_splitdep(char *depstring)
	int alpm_depcmp(pmpkg_t *pkg, pmdepend_t *dep)
	alpm_list_t *alpm_checkdeps(pmdb_t *db, int reversedeps,
			alpm_list_t *remove, alpm_list_t *upgrade)

	char *alpm_miss_get_target(pmdepmissing_t *miss)
	pmdepend_t *alpm_miss_get_dep(pmdepmissing_t *miss)

	char *alpm_conflict_get_package1(pmconflict_t *conflict)
	char *alpm_conflict_get_package2(pmconflict_t *conflict)

	pmdepmod_t alpm_dep_get_mod(pmdepend_t *dep)
	char *alpm_dep_get_name(pmdepend_t *dep)
	char *alpm_dep_get_version(pmdepend_t *dep)
	char *alpm_dep_get_string(pmdepend_t *dep)

	ctypedef enum pmfileconflicttype_t:
		PM_FILECONFLICT_TARGET = 1
		PM_FILECONFLICT_FILESYSTEM

	char *alpm_fileconflict_get_target(pmfileconflict_t *conflict)
	pmfileconflicttype_t alpm_fileconflict_get_type(pmfileconflict_t *conflict)
	char *alpm_fileconflict_get_file(pmfileconflict_t *conflict)
	char *alpm_fileconflict_get_ctarget(pmfileconflict_t *conflict)

	char *alpm_get_md5sum (char *name)

	ctypedef enum _pmerrno_t:
		PM_ERR_MEMORY = 1
		PM_ERR_SYSTEM
		PM_ERR_BADPERMS
		PM_ERR_NOT_A_FILE
		PM_ERR_NOT_A_DIR
		PM_ERR_WRONG_ARGS
		PM_ERR_HANDLE_NULL
		PM_ERR_HANDLE_NOT_NULL
		PM_ERR_HANDLE_LOCK
		PM_ERR_DB_OPEN
		PM_ERR_DB_CREATE
		PM_ERR_DB_NULL
		PM_ERR_DB_NOT_NULL
		PM_ERR_DB_NOT_FOUND
		PM_ERR_DB_WRITE
		PM_ERR_DB_REMOVE
		PM_ERR_SERVER_BAD_URL
		PM_ERR_OPT_LOGFILE
		PM_ERR_OPT_DBPATH
		PM_ERR_OPT_LOCALDB
		PM_ERR_OPT_SYNCDB
		PM_ERR_OPT_USESYSLOG
		PM_ERR_TRANS_NOT_NULL
		PM_ERR_TRANS_NULL
		PM_ERR_TRANS_DUP_TARGET
		PM_ERR_TRANS_NOT_INITILIZED
		PM_ERR_TRANS_NOT_PREPARED
		PM_ERR_TRANS_ABORT
		PM_ERR_TRANS_TYPE
		PM_ERR_TRANS_COMMITING
		PM_ERR_TRANS_DOWNLOADING
		PM_ERR_PKG_NOT_FOUND
		PM_ERR_PKG_INVALID
		PM_ERR_PKG_OPEN
		PM_ERR_PKG_LOAD
		PM_ERR_PKG_INSTALLED
		PM_ERR_PKG_CANT_REFRESH
		PM_ERR_PKG_CANT_REMOVE
		PM_ERR_PKG_INVALID_NAME
		PM_ERR_PKG_CORRUPTED
		PM_ERR_PKG_REPO_NOT_FOUND
		PM_ERR_DLT_CORRUPTED
		PM_ERR_DLT_PATCHFAILED
		PM_ERR_GRP_NOT_FOUND
		PM_ERR_UNSATISFIED_DEPS
		PM_ERR_CONFLICTING_DEPS
		PM_ERR_FILE_CONFLICTS
		PM_ERR_USER_ABORT
		PM_ERR_INTERNAL_ERROR
		PM_ERR_LIBARCHIVE_ERROR
		PM_ERR_DB_SYNC
		PM_ERR_RETRIVE
		PM_ERR_PKG_HOLD
		PM_ERR_INVALID_REGEX
		PM_ERR_CONNECT_FAILED
		PM_ERR_FORK_FAILED

	char *alpm_strerror(int err)
	char *alpm_strerrorlast()

alpm_initialize()

cdef object alpm_list_to_py_list (alpm_list_t *list):
	cdef alpm_list_t *i

	pylist = []
	i = alpm_list_first(list)

	while i:
		pylist.append(<char *>alpm_list_getdata(i))
		i = alpm_list_next(i)
		continue
	return pylist

cdef alpm_list_t * py_list_to_alpm_list (object list):
	cdef alpm_list_t *i

	i = alpm_list_new()
	for item in list:
		i = alpm_list_add(i, <char *>item)
		continue
	return i

cdef class Package:
	cdef pmpkg_t *pkg

	def __init__(self):
		pass

	def check_md5sum(self):
		alpm_pkg_checkmd5sum(self.pkg)

	def get_filename(self):
		cdef char *filename

		filename = alpm_pkg_get_filename(self.pkg)
		return filename

	def get_name(self):
		cdef char *name

		name = alpm_pkg_get_name(self.pkg)
		return name

	def get_version(self):
		cdef char *version

		version = alpm_pkg_get_version(self.pkg)
		return version

	def get_description(self):
		cdef char *desc

		desc = alpm_pkg_get_desc(self.pkg)
		return desc

	def get_url(self):
		cdef char *url

		url = alpm_pkg_get_url(self.pkg)
		return url

	def get_builddate(self):
		cdef time_t bdate

		bdate = alpm_pkg_get_builddate(self.pkg)
		return bdate

	def get_installdate(self):
		cdef time_t idate

		idate = alpm_pkg_get_installdate(self.pkg)
		return idate

	def get_packager(self):
		cdef char *packager

		packager = alpm_pkg_get_packager(self.pkg)
		return packager

	def get_md5sum(self):
		cdef char *md5sum

		md5sum = alpm_pkg_get_md5sum(self.pkg)
		return md5sum

	def get_arch(self):
		cdef char *arch

		arch = alpm_pkg_get_arch(self.pkg)
		return arch

	def get_size(self):
		return alpm_pkg_get_size(self.pkg)

	def get_isize(self):
		return alpm_pkg_get_isize(self.pkg)

	def get_reason(self):
		cdef pmpkgreason_t reason

		reason = alpm_pkg_get_reason(self.pkg)
		return reason

	def get_licenses(self):
		cdef alpm_list_t *list

		list = alpm_pkg_get_licenses(self.pkg)
		pylist = alpm_list_to_py_list(list)
		return pylist

cdef class Database:
	cdef pmdb_t *db

	def __init__(self, name = None):
		if name:
			self.db = alpm_db_register_sync(name)

	def get_name(self):
		cdef char *name

		name = alpm_db_get_name(self.db)
		return name

	def get_url(self):
		cdef char *url

		url = alpm_db_get_url(self.db)
		return url

	def set_server(self, url):
		alpm_db_setserver(self.db, url)

	def db_update(self, level):
		alpm_db_update(level, self.db)

cdef class Alpm:
	cdef char *fname

	def __init__(self, fname = "/etc/pacman.conf"):
		#if (alpm_initialize() != 0):
		#	raise RuntimeError, alpm_strerrorlast()

		if (alpm_option_set_root("/") != 0):
			raise RuntimeError, alpm_strerrorlast()
		if (alpm_option_set_dbpath("/var/lib/pacman/") != 0):
			raise RuntimeError, alpm_strerrorlast()
		if (alpm_option_add_cachedir("/var/cache/pacman/pkg/") != 0):
			raise RuntimeError, alpm_strerrorlast()
		if (alpm_option_set_logfile("/var/log/pacman.log") != 0):
			raise RuntimeError, alpm_strerrorlast()

		alpm_db_register_local()
		self._parse(fname)
	
	def get_syncdbs(self):
		cdef alpm_list_t *dbs
		cdef alpm_list_t *db
		cdef Database tmp_db

		dbs = alpm_option_get_syncdbs()
		db = alpm_list_first(dbs)
		pydbs = []
		while db:
			tmp_db = Database()
			tmp_db.db = <pmdb_t*>alpm_list_getdata(db)
			pydbs.append(tmp_db)
			db = alpm_list_next(db)
			continue
		return pydbs

	def get_root(self):
		return alpm_option_get_root()

	def set_root(self, root):
		alpm_option_set_root(root)
		return

	def get_dbpath(self):
		return alpm_option_get_dbpath()

	def set_dbpath(self, dbpath):
		alpm_option_set_dbpath(dbpath)
		return

	def get_cachedirs(self):
		cdef alpm_list_t *cdirs
		
		cdirs = alpm_option_get_cachedirs()
		pycdirs = alpm_list_to_py_list(cdirs)
		return pycdirs

	def set_cahcedirs(self, pycdirs):
		cdef alpm_list_t *cdirs

		cdirs = py_list_to_alpm_list(pycdirs)
		alpm_option_set_cachedirs(cdirs)
		return

	def add_cachedir(self, cache):
		alpm_option_add_cachedir(cache)
		return

	def remove_cachedir(self, cache):
		alpm_option_remove_cachedir(cache)
		return

	def get_logfile(self):
		return alpm_option_get_logfile()

	def set_logfile(self, logfile):
		alpm_option_set_logfile(logfile)
		return

	def get_lockfile(self):
		return alpm_option_get_lockfile()

	def get_usesyslog(self):
		if alpm_option_get_usesyslog():
			return True
		else:
			return False

	def set_usesyslog(self, use):
		if use:
			alpm_option_set_usesyslog(1)
		else:
			alpm_option_set_usesyslog(0)
		return

	def get_noupgrades(self):
		cdef alpm_list_t *noup

		noup = alpm_option_get_noupgrades()
		pynoup = alpm_list_to_py_list(noup)
		return pynoup

	def add_noupgrade(self, pkg):
		alpm_option_add_noupgrade(pkg)
		return

	def set_noupgrades(self, noups):
		cdef alpm_list_t *alpm_noups

		alpm_noups = py_list_to_alpm_list(noups)
		alpm_option_set_noupgrades(alpm_noups)
		return

	def remove_noupgrade(self, pkg):
		alpm_option_remove_noupgrade(pkg)
		return

	def get_noextracts(self):
		cdef alpm_list_t *noext

		noext = alpm_option_get_noextracts()
		pynoext = alpm_list_to_py_list(noext)
		return pynoext

	def add_noextract(self, pkg):
		alpm_option_add_noextract(pkg)
		return

	def set_noextracts(self, noexts):
		cdef alpm_list_t *noext

		noext = py_list_to_alpm_list(noexts)
		alpm_option_set_noextracts(noext)
		return

	def remove_noextracts(self, noex):
		alpm_option_remove_noextract(noex)
		return

	def get_ignorepkgs(self):
		cdef alpm_list_t *ipkgs

		ipkgs = alpm_option_get_ignorepkgs()
		pyipkgs = alpm_list_to_py_list(ipkgs)
		return pyipkgs

	def add_ignorepkg(self, pkg):
		alpm_option_add_ignorepkg(pkg)
		return

	#def set_ignorepkgs(self, ipkgs):
	#	cdef alpm_list_t *alpm_ipkgs

	#	alpm_ipkgs = py_list_to_alpm_list(ipkgs)
	#	alpm_option_set_ignorepkgs(alpm_ipkgs)
	#	return

	def remove_ignorepkg(self, ipkg):
		alpm_option_remove_ignorepkg(ipkg)
		return

	def get_holdpkgs(self):
		cdef alpm_list_t *hpkg
		
		hpkg = alpm_option_get_holdpkgs()
		if hpkg == NULL:
			raise RuntimeError, alpm_strerrorlast()
		pyhpkgs = alpm_list_to_py_list(hpkg)
		return pyhpkgs

	def add_holdpkg(self, pkg):
		alpm_option_add_holdpkg(pkg)
		return

	def set_holdpkgs(self, hpkgs):
		cdef alpm_list_t *alpm_hpkgs

		alpm_hpkgs = py_list_to_alpm_list(hpkgs)
		alpm_option_set_holdpkgs(alpm_hpkgs)
		return

	def remove_holdpkg(self, hpkg):
		alpm_option_remove_holdpkg(hpkg)
		return

	def get_ignoregrps(self):
		cdef alpm_list_t *grps

		grps = alpm_option_get_ignoregrps()
		pygrps = alpm_list_to_py_list(grps)
		return pygrps

	def add_ignoregrp(self, grp):
		alpm_option_add_ignoregrp(grp)
		return

	#def set_ignoregrps(self, igrps):
	#	cdef alpm_list_t *alpm_igrps

	#	alpm_igrps = py_list_to_alpm_list(igrps)
	#	alpm_option_set_ignoregrps(alpm_igrps)
	#	return

	def remove_ignoregrp(self, grp):
		alpm_option_remove_ignoregrp(grp)
		return

	def get_xfercommand(self):
		return alpm_option_get_xfercommand()

	def set_xfercommand(self, cmd):
		alpm_option_set_xfercommand(cmd)
		return

	def get_nopassiveftp(self):
		if alpm_option_get_nopassiveftp():
			return True
		else:
			return False
		return

	def set_nopassiveftp(self, nopasv):
		if nopasv:
			alpm_option_set_nopassiveftp(1)
		else:
			alpm_option_set_nopassiveftp(0)
		return

	def set_usedelta(self, delta):
		if delta:
			alpm_option_set_usedelta(1)
		else:
			alpm_option_set_usedelta(0)
		return

	def get_localdb(self):
		cdef Database pydb
		cdef pmdb_t *db

		db = alpm_option_get_localdb()
		if not db:
			raise RuntimeError, alpm_strerrorlast()
		pydb = Database()
		pydb.db = db
		return pydb
	
	def _parse (self, fname):
		cdef pmdb_t *db
		db = NULL
		fp = file(fname, "r")
		if not fp:
			return
		for line in fp:
			if len(line) < 1:
				continue
			elif line[0] == "#":
				continue
			elif line[0] == "[":
				line = line.strip()
				section = line[1:-1]
				if section == "options":
					continue
				else:
					db = alpm_db_register_sync (section)
					if db == NULL:
						raise RuntimeError, alpm_strerrorlast()
				continue
			else:
				try:
					(key, value) = line.split(" = ")
					key = key.strip()
					value = value.strip()
				except Exception:
					continue
				print "%s => %s" %(key, value)
				if key == "Include":
					self._parse(value)
					continue
				elif key == "RootDir":
					alpm_option_set_root(value)
					continue
				elif key == "DBPath":
					alpm_option_set_dbpath(value)
					continue
				elif key == "CacheDir":
					values = value.split(" ")
					for val in values:
						alpm_option_add_cachedir(val)
						continue
					continue
				elif key == "LogFile":
					alpm_option_set_logfile(value)
					continue
				elif key == "HoldPkg":
					values = value.split(" ")
					for val in values:
						alpm_option_add_holdpkg(val)
						continue
					continue
				elif key == "IgnorePkg":
					values = value.split(" ")
					for val in values:
						alpm_option_add_ignorepkg(val)
						continue
					continue
				elif key == "IgnoreGroup":
					values = value.split(" ")
					for val in values:
						alpm_option_add_ignoregrp(val)
						continue
					continue
				elif key == "XferCommand":
					alpm_option_set_xfercommand(value)
					continue
				elif key == "NoPassiveFtp":
					alpm_option_set_nopassiveftp(1)
					continue
				elif key == "NoUpgrade":
					values = value.split(" ")
					for val in values:
						alpm_option_add_noupgrade(val)
						continue
					continue
				elif key == "NoExtract":
					values = value.split(" ")
					for val in values:
						alpm_option_add_noextract(val)
						continue
					continue
				elif key == "UseSyslog":
					alpm_option_set_usesyslog(1)
					continue
				elif key == "UseDelta":
					alpm_option_set_usedelta(1)
					continue
				elif key == "Server":
					if db:
						alpm_db_setserver(db, value)
					continue
				continue
			continue
		return


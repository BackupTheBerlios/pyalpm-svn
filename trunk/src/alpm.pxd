from database cimport pmdb_t
from list cimport alpm_list_t

cdef extern from "Python.h":
	ctypedef void *va_list
	object PyString_FromFormatV(char *format, va_list args)

cdef extern from "alpm.h":

	int alpm_initialize()
	int alpm_release()

	ctypedef enum pmloglevel_t:
		PM_LOG_ERROR = 0x01
		PM_LOG_WARNING = 0x02
		PM_LOG_DEBUG = 0x04
		PM_LOG_FUNCTION = 0x08
	
	ctypedef void (*alpm_cb_log)(pmloglevel_t, char *, va_list)
	int alpm_logaction(char *fmt, ...)
	
	ctypedef void (*alpm_cb_download)(char *fname, int xfered, int total,
			int list_xfered, int list_total)

	void alpm_option_set_logcb(alpm_cb_log cb)
	void alpm_option_set_dlcb(alpm_cb_download cb)

	char * alpm_option_get_root()
	int alpm_option_set_root(char *root)

	char * alpm_option_get_dbpath()
	int alpm_option_set_dbpath(char *dbpath)

	alpm_list_t *alpm_option_get_cachedirs()
	int alpm_option_add_cachedir(char *cachedir)
	int alpm_option_remove_cachedir(char *cachedir)

	char *alpm_option_get_logfile()
	int alpm_option_set_logfile(char *logfile)

	char *alpm_option_get_lockfile()

	unsigned short alpm_option_get_usesyslog()
	void alpm_option_set_usesyslog(unsigned short usesyslog)

	alpm_list_t *alpm_option_get_noupgrades()
	void alpm_option_add_noupgrade(char *pkg)
	int alpm_option_remove_noupgrade(char *pkg)

	alpm_list_t *alpm_option_get_noextracts()
	void alpm_option_add_noextract(char *pkg)
	int alpm_option_remove_noextract(char *pkg)

	alpm_list_t *alpm_option_get_holdpkgs()
	void alpm_option_add_holdpkg(char *pkg)
	int alpm_option_remove_holdpkg(char *pkg)

	alpm_list_t *alpm_option_get_ignorepkgs()
	void alpm_option_add_ignorepkg(char *pkg)
	int alpm_option_remove_ignorepkg(char *pkg)

	alpm_list_t *alpm_option_get_ignoregrps()
	void alpm_option_add_ignoregrp(char *grp)
	void alpm_option_remove_ignoregrp(char *grp)

	char *alpm_option_get_xfercommand()
	void alpm_option_set_xfercommand(char *cmd)

	unsigned short alpm_option_get_nopassiveftp()
	void alpm_option_set_nopassiveftp(unsigned short nopasv)
	void alpm_option_set_usedelta(unsigned short usedelta)

	pmdb_t *alpm_option_get_localdb()
	alpm_list_t *alpm_option_get_syncdbs()

	char *alpm_strerrorlast()

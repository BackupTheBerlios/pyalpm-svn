from database cimport Database, alpm_db_get_name, alpm_db_register_local, alpm_db_register_sync, alpm_db_setserver
from list cimport alpm_list_t, alpm_list_first, alpm_list_next, alpm_list_getdata

cdef class Alpm:
	cdef char *fname

	def __init__(self, fname = "/etc/pacman.conf"):

		alpm_initialize()

		self.fname = fname

		alpm_option_set_root("/")
		alpm_option_set_dbpath("/var/lib/pacman/")
		alpm_option_add_cachedir("/var/cache/pacman/pkg/")
		alpm_option_set_logfile("/var/log/pacman.log")

		alpm_db_register_local()

		self._parse(self.fname)

	def get_root(self):
		return alpm_option_get_root()

	def set_root(self, root):
		return alpm_option_set_root(root)

	def get_dbpath(self):
		return alpm_option_get_dbpath()

	def set_dbpath(self, dbpath):
		return alpm_option_set_dbpath(dbpath)

	def get_cachedirs(self):
		cdef alpm_list_t *cdirs
		cdef alpm_list_t *i
		
		ret = []
		
		cdirs = alpm_option_get_cachedirs()
		i = alpm_list_first(cdirs)

		while i != NULL:
			ret.append(<char *>alpm_list_getdata(i))
			i = alpm_list_next(i)
			continue
		return ret

	def add_cachedir(self, cdir):
		alpm_option_add_cachedir(cdir)

	def set_cachedirs(self, cdirs):
		for cdir in cdirs:
			alpm_option_add_cachedir(cdir)
			continue

	def remove_cachedir(self, cdir):
		alpm_option_remove_cachedir(cdir)

	def get_logfile(self):
		return alpm_option_get_logfile()

	def set_logfile(self, fname):
		alpm_option_set_logfile(fname)

	def get_lockfile(self):
		return alpm_option_get_lockfile()

	def get_usesyslog(self):
		return alpm_option_get_usesyslog()

	def set_usesyslog(self, use):
		if use:
			alpm_option_set_usesyslog(1)
		else:
			alpm_option_set_usesyslog(0)
	
	def get_noupgrades(self):
		cdef alpm_list_t *noup
		cdef alpm_list_t *i

		ret = []

		noup = alpm_option_get_noupgrades()
		i = alpm_list_first(noup)

		while i:
			ret.append(<char *>alpm_list_getdata(i))
			i = alpm_list_next(i)
			continue

		return ret

	def add_noupgrade(self, pkg):
		alpm_option_add_noupgrade(pkg)

	def set_noupgrades(self, pkgs):
		for pkg in pkgs:
			alpm_option_add_noupgrade(pkg)
			continue
		
	def remove_noupgrade(self, pkg):
		alpm_option_remove_noupgrade(pkg)

	def get_noextracts(self):
		cdef alpm_list_t *noex
		cdef alpm_list_t *i

		ret = []

		noex = alpm_option_get_noextracts()
		i = alpm_list_first(i)

		while i:
			ret.append(<char *>alpm_list_getdata(i))
			i = alpm_list_next(i)
			continue
		return ret

	def add_noextract(self, pkg):
		alpm_option_add_noextract(pkg)

	def set_noextract(self, pkgs):
		for pkg in pkgs:
			alpm_option_add_noextract(pkg)
			continue
	
	def remove_noextract(self, pkg):
		alpm_option_remove_noextract(pkg)

	def get_ignorpkgs(self):
		cdef alpm_list_t *ipkg
		cdef alpm_list_t *i

		ret = []

		ipkg = alpm_option_get_ignorepkgs()
		i = alpm_list_first(i)

		while i:
			ret.append(<char *>alpm_list_getdata(i))
			i = alpm_list_next(i)
			continue
		return ret

	def add_ignorepkg(self, pkg):
		alpm_option_add_ignorepkg(pkg)

	def set_ignorepkgs(self, pkgs):
		for pkg in pkgs:
			alpm_option_add_ignorepkg(pkg)
			continue

	def remove_ignorepkg(self, pkg):
		alpm_option_remove_ignorepkg(pkg)

	def get_holdpkgs(self):
		cdef alpm_list_t *hpkg
		cdef alpm_list_t *i

		ret = []

		hpkg = alpm_option_get_holdpkgs()
		i = alpm_list_first(hpkg)

		while i:
			ret.append(<char *>alpm_list_getdata(i))
			i = alpm_list_next(i)
			continue

		return ret

	def add_holdpkg(self, pkg):
		alpm_option_add_holdpkg(pkg)

	def set_holdpkgs(self, pkgs):
		for pkg in pkgs:
			alpm_option_add_holdpkg(pkg)
			continue
	
	def remove_holdpkg(self, pkg):
		alpm_option_remove_holdpkg(pkg)

	def get_ignoregrps(self):
		cdef alpm_list_t *igrps
		cdef alpm_list_t *i

		ret = []

		igrps = alpm_option_get_ignoregrps()
		i = alpm_list_first(i)

		while i:
			ret.append(<char *>alpm_list_getdata(i))
			i = alpm_list_next(i)
			continue
		return ret

	def add_ignoregrp(self, grp):
		alpm_option_add_ignoregrp(grp)

	def set_ignoregrps(self, grps):
		for grp in grps:
			alpm_option_add_ignoregrp(grp)
			continue

	def remove_ignoregrp(self, grp):
		alpm_option_remove_ignoregrp(grp)

	def get_xfercommand(self):
		return alpm_option_get_xfercommand()

	def set_xfercommand(self, cmd):
		alpm_option_set_xfercommand(cmd)

	def get_nopassivefrp(self):
		if alpm_option_get_nopassiveftp() == 0:
			return False
		else:
			return True

	def set_nopassiveftp(self, nopasv):
		if nopasv:
			alpm_option_set_nopassiveftp(1)
		else:
			alpm_option_set_nopassiveftp(0)
	
	def set_usedelta(self, delta):
		if delta:
			alpm_option_set_usedelta(1)
		else:
			alpm_option_set_usedelta(0)

	def get_localdb(self):
		cdef Database pydb

		pydb = Database()
		pydb.db = alpm_option_get_localdb()
		return pydb

	def get_syncdbs(self):
		cdef Database pytmp
		cdef pmdb_t *tmp
		cdef alpm_list_t *dbs
		cdef alpm_list_t *i

		ret = {}

		dbs = alpm_option_get_syncdbs()
		i = alpm_list_first(dbs)

		while i != NULL:
			tmp = <pmdb_t *>alpm_list_getdata(i)
			pytmp = Database()
			pytmp.db = tmp
			ret[alpm_db_get_name(tmp)] = pytmp
			i = alpm_list_next(i)
			continue
		return ret

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
						raise RuntimeError, "Error registering %s: %s" %(section, alpm_strerrorlast())
				continue
			else:
				try:
					(key, value) = line.split(" = ")
					key = key.strip()
					value = value.strip()
				except Exception:
					continue
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
	


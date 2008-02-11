from list cimport alpm_list_t
from package cimport pmpkg_t
from group cimport pmgrp_t

cdef extern from "alpm.h":
	ctypedef struct pmdb_t

	pmdb_t *alpm_db_register_local()
	pmdb_t *alpm_db_register_sync(char *treename)

	int alpm_db_unregister(pmdb_t *db)
	int alpm_db_unregister_all()

	char *alpm_db_get_name(pmdb_t *db)
	char *alpm_db_get_url(pmdb_t *db)

	int alpm_db_setserver(pmdb_t *db, char *url)

	int alpm_db_update(int level, pmdb_t *db)

	pmpkg_t *alpm_db_get_pkg(pmdb_t *db, char *name)
	alpm_list_t *alpm_db_getpkgcache(pmdb_t *db)
	alpm_list_t *alpm_db_whatprovides(pmdb_t *db, char *name)

	pmgrp_t *alpm_db_readgrp(pmdb_t *db, char *name)
	alpm_list_t *alpm_db_getgrpcache(pmdb_t *db)
	alpm_list_t *alpm_db_search(pmdb_t *db, alpm_list_t *needles)

cdef extern void initpackage()

cdef class Database:
	cdef pmdb_t *db

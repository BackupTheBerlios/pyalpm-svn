from package cimport pmpkg_t

cdef extern from "alpm.h":
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

cdef extern void initpackage()

cdef class Depends:
	cdef pmdepend_t *dep

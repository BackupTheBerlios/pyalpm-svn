from list cimport alpm_list_t, alpm_list_first, alpm_list_next, alpm_list_getdata

cdef extern from "alpm.h":
	ctypedef struct pmgrp_t

	char *alpm_grp_get_name(pmgrp_t *grp)
	alpm_list_t *alpm_grp_get_pkgs(pmgrp_t *grp)

cdef class Group:
	cdef pmgrp_t *grp

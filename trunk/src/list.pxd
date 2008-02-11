cdef extern from "alpm_list.h":
	ctypedef struct alpm_list_t

	alpm_list_t *alpm_list_first(alpm_list_t *list)
	alpm_list_t *alpm_list_nth(alpm_list_t *list, int n)
	alpm_list_t *alpm_list_next(alpm_list_t *list)
	alpm_list_t *alpm_list_last(alpm_list_t *list)
	void *alpm_list_getdata(alpm_list_t *entry)

	int alpm_list_count(alpm_list_t *list)

	alpm_list_t *alpm_list_new()
	alpm_list_t *alpm_list_add(alpm_list_t *list, void *data)

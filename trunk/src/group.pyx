cdef class Group:
	def get_name(self):
		return alpm_grp_get_name(self.grp)

	def get_pkgs(self):
		cdef alpm_list_t *i

		ret = []

		i = alpm_list_first(alpm_grp_get_pkgs(self.grp))

		while i:
			ret.append(<char *>alpm_list_getdata(i))
			i = alpm_list_next(i)
			continue
		return ret


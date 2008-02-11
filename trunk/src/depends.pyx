cdef class Depends:
	def get_mod(self):
		return alpm_dep_get_mod(self.dep)

	def get_name(self):
		return alpm_dep_get_name(self.dep)

	def get_version(self):
		return alpm_dep_get_version(self.dep)

	def get_string(self):
		return alpm_dep_get_string(self.dep)

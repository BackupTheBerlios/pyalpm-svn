from package cimport Package
from list cimport alpm_list_t, alpm_list_new, alpm_list_first, alpm_list_getdata, alpm_list_next, alpm_list_free
from alpm import alpm_strerrolast

cdef void event_cb(pmtransevt_t event, void *data1, void *data2):
	#some conversions
	#py_event_cb(converted arguments)
	return

cdef void conv_cb(pmtransconv_t conv, void *data1, void *data2, void *data3, int *response):
	#some conversions
	#res = py_conv_cb(converted arguments)
	#response[0] = res
	return

cdef void progress_cb(pmtransprog_t prog, char *pkgname, int percent, int howmany, int remain):
	#some conversions
	#py_progress_cb(converted arguments)
	return

def py_event_cb(event, data1, data2):
	pass

def py_conv_cb(conv, data1, data2, data3):
	return 0

def py_progress_cb(prog, pkgname, percent, howmany, remain):
	pass


cdef class Transaction:

	def __init__(self, tr_type, flags, cb_event, cb_conv, cb_progress):

		global py_event_cb
		global py_conv_cb
		global py_progress_cb

		if type(cb_event).__name__ == "function":
			py_event_cb = cb_event

		if type(cb_conv).__name__ == "function":
			py_conv_cb = cb_conv

		if type(cb_progress).__name__ == "function":
			py_progress_cb = cb_progress

		alpm_trans_init(<pmtranstype_t>1, <pmtransflag_t>flags, <alpm_trans_cb_event>event_cb, <alpm_trans_cb_conv>conv_cb, <alpm_trans_cb_progress>progress_cb)

	def add_target (self, target):
		if type(target).__name__ == "Package":
			target = target.get_name()

		alpm_trans_addtarget(target)

	def prepare(self):
		cdef alpm_list_t *ptr

		ptr = alpm_list_new()
		if (alpm_trans_prepare(&ptr) == -1):
			raise RuntimeError, "Error preparing transaction: %s" %alpm_strerrorlast()

		alpm_list_free(ptr)
	
	def commit(self):
		cdef alpm_list_t *data

		data = alpm_trans_get_pkgs()
		if (alpm_trans_commit(&data) == -1):
			raise RuntimeError, "Error committing transaction: %" %alpm_strerrorlast()

		alpm_list_free(data)

	def get_type(self):
		return alpm_trans_get_type()

	def get_flags(self):
		return alpm_trans_get_flags()

	def get_targets(self):
		cdef alpm_list_t *tgt
		ret = []

		tgt = alpm_list_first(alpm_trans_get_targets())
		while tgt != NULL:
			ret.append(<char *>alpm_list_getdata(tgt))
			tgt = alpm_list_next(tgt)
			continue
		return ret

	def get_packages(self):
		cdef alpm_list_t *pkgs
		ret = []

		pkgs = alpm_list_first(alpm_trans_get_pkgs())
		while pkgs != NULL:
			ret.append(<char *>alpm_list_getdata(pkgs))
			pkgs = alpm_list_next(pkgs)
			continue
		return ret

	def sys_upgrade(self):
		if (alpm_trans_sysupgrade() == -1):
			raise RuntimeError, "Error preparing system upgrade %s" %alpm_strerrorlast()

	def __del__(self):
		alpm_trans_release()

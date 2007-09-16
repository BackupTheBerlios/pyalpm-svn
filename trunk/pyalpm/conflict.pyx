# Copyright (C) 2007 - Stefano Esposito <stefano.esposito87@gmail.com>
#
# This file is part of PyAlpm.
# PyAlpm is free software; you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation; either version 3 of the license, or
# (at your option) any later version.
# 
# PyAlpm is distributed in the hope that it will be usefull,
# bu WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PUORPOSE. See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not see <http://www.gnu.org/licenses>

cdef class Conflict:
				
				#we cast the return value to get rid of "discard qualifier" warnings at
				#compile time
				def get_target (self):
								return <char *>alpm_conflict_get_target (self.conflict)

				def get_type (self):
								return alpm_conflict_get_type (self.conflict)

				def get_file (self):
								return <char *>alpm_conflict_get_file (self.conflict)
				
				def get_ctarget (self):
								return <char *>alpm_conflict_get_ctarget (self.conflict)

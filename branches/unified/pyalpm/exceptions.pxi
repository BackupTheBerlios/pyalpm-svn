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

class MemError (MemoryError):
				pass

class BadPerms (Exception):
				def __str__(self):
								return "you do not have sufficient permissions!"

class NotAFile (Exception):
				def __init__(self, path):
								self.path = path

				def __str__ (self):
								return "could not find or read file %s" %self.path

class NotADir (Exception):
				def __init__(self, path):
								self.path = path
				def __str__(self):
								return "could not find or read directory %s" %self.path

class WrongArgs (Exception):
				def __str__(self):
								return "wrong arguments passed"

class NotInitialized (Exception):
				def __str__(self):
								return "alpm.init() not called!"

class AlreadyInitialized (Exception):
				def __str__(self):
								return "alpm.init() already called!"

class LockError (Exception):
				def __str__ (self):
								return "unable to lock database!"

class DbOpenError (Exception):
				def __init__ (self, db):
								self.db = db
				def __str__ (self):
								return "cannot open database %s" %self.db

class DbCreateError (Exception):
				def __init__ (self, db):
								self.db = db

				def __str__ (self):
								return "cannot create database %s" %self.db

class DbNotInitialized (Exception):
				def __init__ (self, db):
								self.db = db

				def __str__ (self):
								return "database %s not initialized" %self.db

class DbAlreadyInitialized (Exception):
				def __init__ (self, db):
								self.db = db

				def __str__ (self):
								return "database %s already initialized" %self.db

class DbNotFound (Exception):
				def __init__ (self, db):
								self.db
				def __str__ (self):
								return "could not find database %s" %self.db

class DbUpdateError (Exception):
				def __init__ (self, db):
								self.db = db
				def __str__ (self):
								return "could not update database %s" %self.db

class DbRemoveError (Exception):
				def __init__ (self, db):
								self.db = db
				def __str__ (self):
								return "could not remove entry from database %s" %self.db

class BadUrl (Exception):
				def __str__ (self):
								return "invalid url for server"

class SetOptError (Exception):
				def __init__ (self, what):
								self.what = what
				def __str__ (self):
								return "cannot set parameter %s: %s" %(self.what, alpm_strerror())

class TransAlreadyInitialized (Exception):
				def __str__ (self):
								return "transaction already initialized"

class TransNotInitialized (Exception):
				def __str__ (self):
								return "transaction not initialized"

class TransNotPrepared (Exception):
				def __str__ (self):
								return "transaction not preapared"

class TransAbort (Exception):
				def __str__ (self):
								return "transaction aborted"

class TransTypeError (Exception):
				def __str__ (self):
								return "operation not compatible with transaction type"

class TransCommittingError (Exception):
				def __str__ (self):
								return "could not commit transaction"

class TransDownloadError (Exception):
				def __str__ (self):
								return "some files could not be downloaded"

class PackageNotFound (Exception):
				def __init__ (self, pkg):
								self.pkg = pkg
				def __str__ (self):
								return "could not find or read package %s" %pkg

class PackageInvalid (Exception):
				def __str__ (self):
								return "invalid or corrupted package"

class PackageOpenError (Exception):
				def __init__ (self, pkg):
								self.pkg = pkg
				def __str__ (self):
								return "could not open package file %s" %self.pkg

class PackageLoadError (Exception):
				def __init__ (self, pkg):
								self.pkg = pkg
				def __str__ (self):
								return "could not load package data for package %s" %self.pkg

class PackageInstalled (Exception):
				def __init__ (self, pkg):
								self.pkg = pkg

				def __str__ (self):
								return "package %s already installed" %self.pkg

class PackageRefreshError (Exception):
				def __init__ (self, pkg):
								self.pkg = pkg
				def __str__(self):
								return "could not refresh package %s: not installed or newer version" %self.pkg

class PackageRemoveError (Exception):
				def __init__ (self, pkg):
								self.pkg = pkg
				def __str__ (self):
								return "cannot remove al file for package %s" %self.pkg

class PackageNameError (Exception):
				def __init__ (self, pkg):
								self.pkg = pkg

				def __str__ (self):
								return "%s is not a valid package name" %self.pkg

class PackageCorrupted (Exception):
				def __init__ (self, pkg):
								self.pkg = pkg
				def __str__ (self):
								return "package %s is corrupted" %self.pkg

class RepoNotFound (Exception):
				def __init__ (self, repo):
								self.repo = repo
				def __str__ (self):
								return "repo %s not found" %self.repo

class GroupNotFound (Exception):
				def __init__ (self, grp):
								self.grp = grp
				def __str__ (self):
								return "group %s not found" %self.group

class UnsatisfiedDeps (Exception):
				def __init__(self, missing):
								self.missing = missing
				def __str__(self):
								return "unsatisfied dependencies found!"

class ConflictingDeps (Exception):
				def __init__(self, missing):
								self.missing = missing
				def __str__(self):
								return "conflicting dependencies found!"

class ConflictingFile (Exception):
				def __init__(self, conflicts):
								self.conflicts = conflicts

				def __str__ (self):
								return "file conflicts found!"

class UserAbort (Exception):
				def __str__ (self):
								return "user aborted operation"

class InternalError (Exception):
				def __str__ (self):
								return "internal alpm error"

class LibarchiveError (Exception):
				def __str__ (self):
								return "libarchive internal error"

class PackageHold (RuntimeError):
				pass

class InvalidRegexError (Exception):
				def __str__ (self):
								return "invalid regular expression"

class ConnectionFailed (Exception):
				def __str__ (self):
								return "connection to remote host failed"

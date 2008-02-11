CFLAGS=-pthread -fno-strict-aliasing -DNDEBUG -g -O3 -Wall -Wstrict-prototypes -fPIC -I/usr/include/python2.5
LIBS=-pthread -shared -L/usr/lib -lpython2.5 -lalpm
OBJECTS=pyalpm.o alpm.o database.o group.o package.o transaction.o
all: pyalpm.so

pyalpm.so: $(OBJECTS)
	gcc $(LIBS) $(OBJECTS) -o $@
	

pyalpm.o: pyalpm.c
	gcc $(CFLAGS) -c $< -o $@

alpm.o: alpm.c
	gcc $(CFLAGS) -c $< -o $@

database.o: database.c
	gcc $(CFLAGS) -c $< -o $@

group.o: group.c
	gcc $(CFLAGS) -c $< -o $@

package.o: package.c
	gcc $(CFLAGS) -c $< -o $@

transaction.o: transaction.c
	gcc $(CFLAGS) -c $< -o $@

pyalpm.c:
	pyrexc pyalpm.pyx

alpm.c:
	pyrexc alpm.pyx

database.c:
	pyrexc database.pyx

group.c:
	pyrexc group.pyx

package.c:
	pyrexc package.pyx

transaction.c:
	pyrexc transaction.pyx

clean:
	rm -f *.o *.c *.so

install: all
	install -d $(DESTDIR)/usr/lib/python2.5/site-packages/alpm
	install -t $(DESTDIR)/usr/lib/python2.5/site-packages/alpm pyalpm.so __init__.py


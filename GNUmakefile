mirror = http://mirror.yandex.ru/mandriva/official/2011
arch = $(shell sed -r 's/.*arch=([^,]+).*$$/\1/' /etc/product.id)
targets = list.final.$(arch) list.with.add.$(arch) urls.bin.$(arch) srpms.$(arch) urls.srpm.$(arch)
a = main contrib non-free
b = release updates
p = $(foreach a1,$(addsuffix /,$(a)),$(addprefix SRPMS/$(a1),$(b)))

all: urpmi lists

lists: list urls.bin.$(arch) urls.srpm.$(arch)

urpmi:
	sudo urpmi.removemedia -a
	sudo urpmi.addmedia --wget --distrib --mirrorlist "$(mirror)/$(arch)/"
	for i in $(p); do sudo urpmi.addmedia --wget $${i//\//_} $(mirror)/$$i; done

urls.bin.$(arch): list.final.$(arch)
	urpmq --sources $$(cat $<) | sort -u > $@

urls.srpm.$(arch): srpms.$(arch)
	urpmq --sources $$(cat $<) | sort -u > $@

srpms.$(arch): list.final.$(arch) filter.srpms.sed
	urpmq --sourcerpm $$(cat $<) | sed -r 's/^[^ ]* +//;s/\.rpm$$//' | \
sed -f $(word 2,$^) | sort -u > $@

list.final.$(arch): list.with.add.$(arch)
	cat $< > $@.tmp0
	cat $< > $@.tmp1
	for i in $$(seq 1 20); do echo "iteration $$i"; \
cat $@.tmp1 | \
while read j; do urpmq --requires-recursive $$j; done | sed 's/|/\n/g' | sort -u > $@.tmp2; \
comm -1 -3 $@.tmp0 $@.tmp2 > $@.tmp1; \
wc -l $@*; \
[ "$$(cat $@.tmp1 | wc -l)" -eq "0" ] && break; \
cat $@.tmp0 > $@.tmp2; \
cat $@.tmp2 $@.tmp1 | sort -u > $@.tmp0; \
done
	cat $@.tmp0 | sort -u > $@
	rm $@.tmp0 $@.tmp1 $@.tmp2

list.with.add.$(arch): list list.add list.del
	-urpmq -a $$(cat $(wordlist 1,2,$^) | grep -vwf $(word 3,$^) | sort -u | grep -v '^lib') | \
sed 's/|/\n/g' | sort -u > $@

clean:
	-@rm $(targets)

.PHONY: all clean urpmi lists

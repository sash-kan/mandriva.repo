вводные:
1. имеется список пакетов, которые должны войти в репозиторий
этот список находится в файле list
(список взят из wiki:Список который предложен разработчиками MES весной 2011)
2.1. имеется две тестовые машины 32- и 64-битные
тогда на обоих надо запустить make в этом каталоге
2.2. имеется только одна тестовая машина
тогда make надо запустить дважды:
$ make arch=i586
$ make arch=x86_64
3. в качестве зеркала репозитория в GNUmakefile указан yandex·
если имеется локальное зеркало, лучше указать его url·
url должен заканчиваться на каталоге, в котором лежат подкаталоги SRPMS, i586 и x86_64·
чтобы не править сам мэйкфайл, можно указать url параметром, например:
$ make mirror=http://our.mirror/mandriva/official/2011
4. в конце концов будут получены два файла для каждой из архитектур:
urls.bin.i586 и urls.srpm.i586 — для 32-бит
urls.bin.x86_64 и urls.srpm.x86_64 — для 64-бит
теоретически urls.srpm.i586 и urls.srpm.x86_64 должны полностью совпадать,
но мало ли что в жизни случается…
у меня в данный момент такое несовпадение в две строчки:
$ diff -u urls.srpm.*
--- urls.srpm.i586      2011-10-24 15:00:14.000000000 +0400
+++ urls.srpm.x86_64    2011-10-24 14:57:05.000000000 +0400
@@ -120,6 +120,8 @@
 http://mirror.yandex.ru/mandriva/official/2011/SRPMS/contrib/release/tetex-3.0-55.src.rpm
 http://mirror.yandex.ru/mandriva/official/2011/SRPMS/contrib/release/thttpd-2.25b-10mdv2010.0.src.rpm
 http://mirror.yandex.ru/mandriva/official/2011/SRPMS/contrib/release/tinyproxy-1.8.2-1mdv2011.0.src.rpm
+http://mirror.yandex.ru/mandriva/official/2011/SRPMS/contrib/release/uClibc-openssl-0.9.7g-4mdv2007.1.src.rpm
+http://mirror.yandex.ru/mandriva/official/2011/SRPMS/contrib/release/uClibc-zlib-1.2.3-4mdv2007.1.src.rpm
 http://mirror.yandex.ru/mandriva/official/2011/SRPMS/contrib/release/unimrcp-deps-1.0.2-3.src.rpm
 http://mirror.yandex.ru/mandriva/official/2011/SRPMS/contrib/release/vlc-1.1.11-1.src.rpm
 http://mirror.yandex.ru/mandriva/official/2011/SRPMS/contrib/release/xfce4-notifyd-0.2.2-2.src.rpm

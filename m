From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Remove get_kernel_pages() for v6.3
Date: Sun, 19 Feb 2023 21:35:16 +0100
Message-ID: <Y/KIBDu3BiHdIsX7@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6280774811082242021=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6280774811082242021==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull these patches which clean up shm_get_kernel_pages() in the TEE
subsystem and ultimately remove get_kernel_pages(). The patches have only
been in linux-next for close to a week but you told me it was OK to send
them anyway.

I'm normally sending my pull requests to arm-soc, but with the short
time in linux-next and everything I decided to send it directly to you
this time.

Thanks,
Jens

The following changes since commit ceaa837f96adb69c0df0397937cd74991d5d821a:

  Linux 6.2-rc8 (2023-02-12 14:10:17 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/remove-get_=
kernel_pages-for-6.3

for you to fetch changes up to 816477edfba6e7ab9411acec5f07cfa00e0882f7:

  mm: Remove get_kernel_pages() (2023-02-13 14:16:41 +0100)

----------------------------------------------------------------
Remove get_kernel_pages()

Vmalloc page support is removed from shm_get_kernel_pages() and the
get_kernel_pages() call is replaced by calls to get_page(). With no
remaining callers of get_kernel_pages() the function is removed.

----------------------------------------------------------------
Ira Weiny (4):
      highmem: Enhance is_kmap_addr() to check kmap_local_page() mappings
      tee: Remove vmalloc page support
      tee: Remove call to get_kernel_pages()
      mm: Remove get_kernel_pages()

 drivers/tee/tee_shm.c            | 37 ++++++++++---------------------------
 include/linux/highmem-internal.h |  5 ++++-
 include/linux/mm.h               |  2 --
 mm/swap.c                        | 30 ------------------------------
 4 files changed, 14 insertions(+), 60 deletions(-)

--===============6280774811082242021==--


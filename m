From: Ira Weiny <ira.weiny@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 0/4] Remove get_kernel_pages()
Date: Mon, 03 Oct 2022 08:22:09 -0700
Message-ID: <Yzr+IU2IMkvJQqbu@iweiny-mobl>
In-Reply-To: <
 <CAFA6WYN+3inY6MYrMFY0qhmifCYtj_immFMFN6jC1BamQCYGWQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5978806839960061498=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5978806839960061498==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 03, 2022 at 02:55:02PM +0530, Sumit Garg wrote:
> Hi Ira,
>=20
> On Sun, 2 Oct 2022 at 05:53, <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > get_kernel_pages() only had one caller [shm_get_kernel_pages()] which did=
 not
> > need the functionality it provided.  Furthermore, it called kmap_to_page()
> > which we are looking to removed.
> >
> > Alter shm_get_kernel_pages() to no longer call get_kernel_pages() and rem=
ove
> > get_kernel_pages().  Along the way it was noted that shm_get_kernel_pages=
()
> > does not have any need to support vmalloc'ed addresses either.  Remove th=
at
> > functionality to clean up the logic.
> >
> > This series also fixes and uses is_kmap_addr().
>=20
> From the above description, I am failing to see the motivation behind
> this change. Can you elaborate here?

Al Viro found[1] that kmap_to_page() is broken.  But not only was it broken b=
ut
it presents confusion over how highmem should be used because kmap() and
friends should not be used for 'long term' mappings.

[1] https://lore.kernel.org/lkml/YzSSl1ItVlARDvG3(a)ZenIV

>=20
> Also, since you are targeting to remove kmap_to_page(), is there any
> alternative way to support highmem for future TEE bus drivers?  As I
> can see higmem being enabled for multiple Arm defconfigs [1] which can
> also support TEE (an example which already does it:
> arch/arm/configs/imx_v6_v7_defconfig).

With TEE how are the highmem pages used?  Right now the code does not seem to
use any user pages.  So I can't really say how this should work.  Why does the
kernel need a mapping of those pages?

Ira

>=20
> [1] git grep CONFIG_HIGHMEM arch/arm/
>=20
> -Sumit
>=20
> >
> > Ira Weiny (4):
> >   highmem: Enhance is_kmap_addr() to check kmap_local_page() mappings
> >   tee: Remove vmalloc page support
> >   tee: Remove call to get_kernel_pages()
> >   mm: Remove get_kernel_pages()
> >
> >  drivers/tee/tee_shm.c            | 41 ++++++++++++--------------------
> >  include/linux/highmem-internal.h |  5 +++-
> >  include/linux/mm.h               |  2 --
> >  mm/swap.c                        | 30 -----------------------
> >  4 files changed, 19 insertions(+), 59 deletions(-)
> >
> >
> > base-commit: 274d7803837da78dfc911bcda0d593412676fc20
> > --
> > 2.37.2
> >

--===============5978806839960061498==--


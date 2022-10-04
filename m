From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 0/4] Remove get_kernel_pages()
Date: Tue, 04 Oct 2022 12:02:55 +0530
Message-ID: 
 <CAFA6WYO3+Mvah+caBkcVkyVtEcTU4vFb=zpWmwbZGWonT+XmhA@mail.gmail.com>
In-Reply-To: <Yzr+IU2IMkvJQqbu@iweiny-mobl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6129838850510988813=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6129838850510988813==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Oct 2022 at 20:52, Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Mon, Oct 03, 2022 at 02:55:02PM +0530, Sumit Garg wrote:
> > Hi Ira,
> >
> > On Sun, 2 Oct 2022 at 05:53, <ira.weiny@intel.com> wrote:
> > >
> > > From: Ira Weiny <ira.weiny@intel.com>
> > >
> > > get_kernel_pages() only had one caller [shm_get_kernel_pages()] which d=
id not
> > > need the functionality it provided.  Furthermore, it called kmap_to_pag=
e()
> > > which we are looking to removed.
> > >
> > > Alter shm_get_kernel_pages() to no longer call get_kernel_pages() and r=
emove
> > > get_kernel_pages().  Along the way it was noted that shm_get_kernel_pag=
es()
> > > does not have any need to support vmalloc'ed addresses either.  Remove =
that
> > > functionality to clean up the logic.
> > >
> > > This series also fixes and uses is_kmap_addr().
> >
> > From the above description, I am failing to see the motivation behind
> > this change. Can you elaborate here?
>
> Al Viro found[1] that kmap_to_page() is broken.  But not only was it broken=
 but
> it presents confusion over how highmem should be used because kmap() and
> friends should not be used for 'long term' mappings.
>
> [1] https://lore.kernel.org/lkml/YzSSl1ItVlARDvG3(a)ZenIV
>

Thanks for the background info. This should be part of the cover letter.

> >
> > Also, since you are targeting to remove kmap_to_page(), is there any
> > alternative way to support highmem for future TEE bus drivers?  As I
> > can see higmem being enabled for multiple Arm defconfigs [1] which can
> > also support TEE (an example which already does it:
> > arch/arm/configs/imx_v6_v7_defconfig).
>
> With TEE how are the highmem pages used?  Right now the code does not seem =
to
> use any user pages.  So I can't really say how this should work.  Why does =
the
> kernel need a mapping of those pages?

Fair enough, I don't have a real kernel driver use-case for highmem
which is required to be registered with TEE.

-Sumit

>
> Ira
>
> >
> > [1] git grep CONFIG_HIGHMEM arch/arm/
> >
> > -Sumit
> >
> > >
> > > Ira Weiny (4):
> > >   highmem: Enhance is_kmap_addr() to check kmap_local_page() mappings
> > >   tee: Remove vmalloc page support
> > >   tee: Remove call to get_kernel_pages()
> > >   mm: Remove get_kernel_pages()
> > >
> > >  drivers/tee/tee_shm.c            | 41 ++++++++++++--------------------
> > >  include/linux/highmem-internal.h |  5 +++-
> > >  include/linux/mm.h               |  2 --
> > >  mm/swap.c                        | 30 -----------------------
> > >  4 files changed, 19 insertions(+), 59 deletions(-)
> > >
> > >
> > > base-commit: 274d7803837da78dfc911bcda0d593412676fc20
> > > --
> > > 2.37.2
> > >

--===============6129838850510988813==--


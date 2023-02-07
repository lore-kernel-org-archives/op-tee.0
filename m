From: Ira Weiny <ira.weiny@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/4] Remove get_kernel_pages()
Date: Tue, 07 Feb 2023 08:19:03 -0800
Message-ID: <63e279f730612_104ce22946f@iweiny-mobl.notmuch>
In-Reply-To: <
 <CAFA6WYM5tzs3T1tDgspA=R=VxfWrknm2YPHMCZihx405pF-ftA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6940423089794033780=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6940423089794033780==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Sumit Garg wrote:
> On Sat, 4 Feb 2023 at 09:36, Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > Sumit,
> >
> > I did not see a follow up on this series per your last email.[1]  I'd lik=
e to
> > move forward with getting rid of kmap_to_page().  So Hopefully this can l=
and
> > and you can build on this rather than the other way around?
>=20
> Apologies Ira for keeping you waiting. Actually I was fully involved
> with other high priority work with my upstream review backlog
> increasing. So I wasn't able to devote time to this work. Sure I will
> rebase my work on top of your changes.

No problem on my end.  I just wanted to ensure that I did not miss
something.

Thanks for the reviews!
Ira

>=20
> -Sumit
>=20
> >
> > All,
> >
> > Al Viro found[2] that kmap_to_page() is broken.  But not only is it broke=
n, it
> > presents confusion over how highmem should be used because kmap() and fri=
ends
> > should not be used for 'long term' mappings.
> >
> > get_kernel_pages() is a caller of kmap_to_page().  It only has one caller
> > [shm_get_kernel_pages()] which does not need the functionality.
> >
> > Alter shm_get_kernel_pages() to no longer call get_kernel_pages() and rem=
ove
> > get_kernel_pages().  Along the way it was noted that shm_get_kernel_pages=
()
> > does not have any need to support vmalloc'ed addresses either.  Remove th=
at
> > functionality to clean up the logic.
> >
> > This series also fixes is_kmap_addr() and uses it to ensure no kmap addre=
sses
> > slip in later.
> >
> > [1] https://lore.kernel.org/all/CAFA6WYMqEVDVW-ifoh-V9ni1zntYdes8adQKf2XX=
AUpqdaW53w(a)mail.gmail.com/
> > [2] https://lore.kernel.org/lkml/YzSSl1ItVlARDvG3(a)ZenIV
> >
> > To: Sumit Garg <sumit.garg@linaro.org>
> > To: Andrew Morton <akpm@linux-foundation.org>
> > Cc: "Al Viro" <viro@zeniv.linux.org.uk>
> > Cc: "Christoph Hellwig" <hch@lst.de>
> > Cc: linux-kernel(a)vger.kernel.org
> > Cc: op-tee(a)lists.trustedfirmware.org
> > Cc: linux-mm(a)kvack.org
> > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >
> > ---
> > Changes in v2:
> > - Al Viro: Avoid allocating the kiov.
> > - Sumit: Update cover letter to clarify the motivation behind removing
> >   get_kernel_pages()
> > - Link to v1: https://lore.kernel.org/r/20221002002326.946620-1-ira.weiny=
(a)intel.com
> >
> > ---
> > Ira Weiny (4):
> >       highmem: Enhance is_kmap_addr() to check kmap_local_page() mappings
> >       tee: Remove vmalloc page support
> >       tee: Remove call to get_kernel_pages()
> >       mm: Remove get_kernel_pages()
> >
> >  drivers/tee/tee_shm.c            | 37 ++++++++++------------------------=
---
> >  include/linux/highmem-internal.h |  5 ++++-
> >  include/linux/mm.h               |  2 --
> >  mm/swap.c                        | 30 ------------------------------
> >  4 files changed, 14 insertions(+), 60 deletions(-)
> > ---
> > base-commit: 0136d86b78522bbd5755f8194c97a987f0586ba5
> > change-id: 20230203-get_kernel_pages-199342cfba79
> >
> > Best regards,
> > --
> > Ira Weiny <ira.weiny@intel.com>



--===============6940423089794033780==--


From: Lorenzo Stoakes <lstoakes@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: FOLL_LONGTERM vs FOLL_EPHEMERAL Re: [PATCH] tee: add
 FOLL_LONGTERM for CMA case when alloc shm
Date: Tue, 23 May 2023 07:25:30 +0000
Message-ID: <106e7886-ef02-4979-b96d-66d33cfa119c@lucifer.local>
In-Reply-To: <1ced7f32-553e-2a5b-eec9-f794d7983d56@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3265191131967199300=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3265191131967199300==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 06:54:29PM -0700, John Hubbard wrote:
> On 5/18/23 06:56, David Hildenbrand wrote:
> > On 18.05.23 08:08, Sumit Garg wrote:
> > > On Thu, 18 May 2023 at 09:51, Christoph Hellwig <hch@infradead.org> w=
rote:
> > > >
> > > > On Wed, May 17, 2023 at 08:23:33PM +0200, David Hildenbrand wrote:
> > > > > In general: if user space controls it -> possibly forever -> long-t=
erm. Even
> > > > > if in most cases it's a short delay: there is no trusting on user s=
pace.
> > > > >
> > > > > For example, iouring fixed buffers keep pages pinned until user spa=
ce
> > > > > decides to unregistered the buffers -> long-term.
> > > > >
> > > > > Short-term is, for example, something like O_DIRECT where we pin ->=
 DMA ->
> > > > > unpin in essentially one operation.
> > > >
> > > > Btw, one thing that's been on my mind is that I think we got the
> > > > polarity on FOLL_LONGTERM wrong.=C2=A0 Instead of opting into the lon=
g term
> > > > behavior it really should be the default, with a FOLL_EPHEMERAL flag
> > > > to opt out of it.=C2=A0 And every users of this flag is required to h=
ave
> > > > a comment explaining the life time rules for the pin..

I couldn't agree more, based on my recent forays into GUP the interface
continues to strike me as odd:-

- FOLL_GET is a wing and a prayer that nothing that
  [folio|page]_maybe_dma_pinned() prevents happens in the brief period the
  page is pinned/manipulated. So agree completely with David's concept of
  unexporting that and perhaps carefully considering our use of
  it. Obviously the comments around functions like gup_remote() make clear
  that 'this page not be what you think it is' but I wonder whether many
  callers of GUP _truly_ take that on board.

- FOLL_LONGTERM is entirely optional for PUP and you can just go ahead and
  fragment page blocks to your heart's content. Of course this would be an
  abuse, but abuses happen.

- With the recent change to PUP/FOLL_LONGTERM disallowing dirty tracked
  file-backed mappings we're now really relying on this flag indicating a
  _long term_ pin semantically. By defaulting to this being switched on, we
  avoid cases of callers who might end up treating the won't
  reclaim/etc. aspect of PUP as all they care about while ignoring the
  MIGRATE_MOVABLE aspect.

>
> I see maybe 10 or 20 call sites today. So it is definitely feasible to add
> documentation at each, explaining the why it wants a long term pin.
>

Yeah, my efforts at e.g. dropping vmas has been eye-opening in actually
quite how often a refactoring like this often ends up being more
straightforward than you might imagine.

> > >
> > > It does look like a better approach to me given the very nature of
> > > user space pages.
> >
> > Yeah, there is a lot of historical baggage. For example, FOLL_GET should =
be inaccessible to kernel modules completely at one point, to be only used by=
 selected core-mm pieces.
>
> Yes. When I first mass-converted call sites from gup to pup, I just
> preserved FOLL_GET behavior in order to keep from changing too much at
> once. But I agree that that it would be nice to make FOLL_GET an
> mm internal-only flag like FOLL_PIN.

Very glad you did that work! And totally understandable as to you being
conservative with that, but I think we're at a point where there's more
acceptance of incremental improvements to GUP as a whole.

I have another patch series saved up for _yet more_ changes on this. But
mindful of churn I am trying to space them out... until Jason nudges me of
course :)

>
> >
> > Maybe we should even disallow passing in FOLL_LONGTERM as a flag and only=
 provide functions like pin_user_pages() vs. pin_user_pages_longterm(). Then,=
 discussions about conditional flag-setting are no more :)
> >
> > ... or even use pin_user_pages_shortterm() vs. pin_user_pages() ... to ma=
ke the default be longterm.
> >
>
> Yes, it is true that having most gup flags be internal to mm does tend
> to avoid some bugs. But it's also a lot of churn. I'm still on the fence
> as to whether it's really a good move to do this for FOLL_LONGTERM or
> not. But it's really easy to push me off of fences. :)

*nudge* ;)

>
> thanks,
> --
> John Hubbard
> NVIDIA
>

Looking at non-fast, non-FOLL_LONGTERM PUP callers (forgive me if I missed an=
y):-

- pin_user_pages_remote() in process_vm_rw_single_vec() for the
  process_vm_access functionality.

- pin_user_pages_remote() in user_event_enabler_write() in
  kernel/trace/trace_events_user.c.

- pin_user_pages_unlocked() in ivtv_udma_setup() in
  drivers/media/pci/ivtv/ivtv-udma.c and ivtv_yuv_prep_user_dma() in ivtv-yuv=
.c.

And none that actually directly invoke PUP without FOLL_LOGNTERM... That
suggests that we could simply disallow non-FOLL_LONGTERM non-fast PUP calls
altogether and move to pin_user_pages_longterm() [I'm happy to write a
patch series doing this].

The ivtv callers look like they really actually want FOLL_LONGTERM unless
I'm missing something so we should probably change that too?

I haven't surveyed the fast versions, but I think defaulting to
FOLL_LONGTERM on them also makes sense.

--===============3265191131967199300==--


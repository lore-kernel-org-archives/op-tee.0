From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Date: Thu, 13 Feb 2025 16:57:42 +0100
Message-ID: 
 <CAHUa44G9hw-z6wzxg=HkVAxPKEW1yES5JTEqRWMvJUJAtcUDkQ@mail.gmail.com>
In-Reply-To: <
 <CAPj87rM5Y=-Jgf4mwukicF6Yb-vccn2fpG2X1jNq0upH2+cAEQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1438806702306412169=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1438806702306412169==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 13, 2025 at 3:05=E2=80=AFPM Daniel Stone <daniel@fooishbar.org>=
 wrote:
>
> Hi,
>
> On Thu, 13 Feb 2025 at 12:40, Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> > On Thu, 13 Feb 2025 14:46:01 +0530 Sumit Garg <sumit.garg@linaro.org> w=
rote:
> > > Yeah but all the prior vendor specific secure/restricted DMA heaps
> > > relied on DT information.
> >
> > Right, but there's nothing in the DMA heap provider API forcing that.
>
> Yeah. DMA heaps are just a way to allocate memory from a specific
> place. It allows people to settle on having a single way to do
> allocations from weird platform-specific places; the only weird
> platform-specific part userspace needs to deal with is figuring out
> the name to use. The rest is at least a unified API: the point of
> dma-heaps was exactly to have a single coherent API for userspace, not
> to create one API for ZONE_CMA and DT ranges and everyone else doing
> their own thing.
>
> > > Rather than that it's better
> > > for the user to directly ask the TEE device to allocate restricted
> > > memory without worrying about how the memory restriction gets
> > > enforced.
> >
> > If the consensus is that restricted/protected memory allocation should
> > always be routed to the TEE, sure, but I had the feeling this wasn't as
> > clear as that. OTOH, using a dma-heap to expose the TEE-SDP
> > implementation provides the same benefits, without making potential
> > future non-TEE based implementations a pain for users. The dma-heap
> > ioctl being common to all implementations, it just becomes a
> > configuration matter if we want to change the heap we rely on for
> > protected/restricted buffer allocation. And because heaps have
> > unique/well-known names, users can still default to (or rely solely on)
> > the TEE-SPD implementation if they want.
> >
> > > There have been several attempts with DMA heaps in the past which all
> > > resulted in a very vendor specific vertically integrated solution. But
> > > the solution with TEE subsystem aims to make it generic and vendor
> > > agnostic.
> >
> > Just because all previous protected/restricted dma-heap effort
> > failed to make it upstream, doesn't mean dma-heap is the wrong way of
> > exposing this feature IMHO.
>
> To be fair, having a TEE implementation does give us a much better
> chance of having a sensible cross-vendor plan. And the fact it's
> already (sort of accidentally and only on one platform AFAICT) ready
> for a 'test' interface, where we can still exercise protected
> allocation paths but without having to go through all the
> platform-specific setup that is inaccessible to most people, is also
> really great! That's probably been the biggest barrier to having this
> tested outside of IHVs and OEMs.
>
> But just because TEE is one good backend implementation, doesn't mean
> it should be the userspace ABI. Why should userspace care that TEE has
> mediated the allocation instead of it being a predefined range within
> DT?

The TEE may very well use a predefined range that part is abstracted
with the interface.

> How does userspace pick which TEE device to use?

There's normally only one and even if there is more than one it should
be safe to assume that only one of them should be used when allocating
restricted memory (TEE_GEN_CAP_RSTMEM from TEE_IOC_VERSION).

>  What advantage
> does userspace get from having to have a different codepath to get a
> different handle to memory? What about x86?
>
> I think this proposal is looking at it from the wrong direction.
> Instead of working upwards from the implementation to userspace, start
> with userspace and work downwards. The interesting property to focus
> on is allocating memory, not that EL1 is involved behind the scenes.

From what I've gathered from earlier discussions, it wasn't much of a
problem for userspace to handle this. If the kernel were to provide it
via a different ABI, how would it be easier to implement in the
kernel? I think we need an example to understand your suggestion.

Cheers,
Jens

--===============1438806702306412169==--


From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
Date: Wed, 15 Dec 2021 13:25:16 +0100
Message-ID: 
 <CAHUa44Hm4WNg3JE6phOo_qcKmq3Pq8N1d6ntStQ4nh6DnpqLFw@mail.gmail.com>
In-Reply-To: <20211215101954.oggnubww6ywz6fu7@maple.lan>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2989368853653491202=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2989368853653491202==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 15, 2021 at 11:19 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Dec 14, 2021 at 12:33:08PM +0530, Sumit Garg wrote:
> > On Mon, 13 Dec 2021 at 18:34, Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > > On Mon, Dec 13, 2021 at 02:28:01PM +0530, Sumit Garg wrote:
> > > > On Fri, 10 Dec 2021 at 21:19, Daniel Thompson
> > > > <daniel.thompson@linaro.org> wrote:
> > > > > On Fri, Dec 10, 2021 at 03:08:21PM +0530, Sumit Garg wrote:
> > > > > > On Fri, 10 Dec 2021 at 13:40, Jerome Forissier <jerome@forissie=
r.org> wrote:
> > > > > > > On 12/10/21 06:00, Sumit Garg wrote:
> > > > > > > > On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@w=
indriver.com> wrote:
> > > > > IIUC this patch adds kmemleak_not_leak() at (pretty much) the last
> > > > > possible point before *ownership* of the SHM block is passed from k=
ernel
> > > > > to OP-TEE.
> > > >
> > > > I wouldn't say it's a transfer of ownership from kernel to OP-TEE but
> > > > rather a way for OP-TEE to access kernel's memory in order to pass
> > > > info or execute further RPC commands.
> > >
> > > The RPC handler allocates a pointer (e.g. now the RPC handler owns the
> > > allocated memory). The RPC handler then passes that pointer to OP-TEE a=
nd
> > > forgets what it's value was.
> > >
> > > That is a transfer of ownership: the RPC handler does not hold any poin=
ter
> > > to the memory and is incapable of freeing it. Moreover this situation is
> > > what kmemleak_no_leak() is for! Its job it to inform kmemleak that the
> > > pointer is owned/stored somewhere that is does not scan.
> >
> > Let me put this another way. If the memory allocator belongs to the
> > kernel then how does OP-TEE get to know which memory is currently
> > allocated and it is to be scanned?
>
> OP-TEE explicitly requested that the be allocated and responsible for
> figuring out where to store the pointer. How could it *not* know this
> information? More specifically OP-TEE is perfectly capable of recording
> what memory it has allocated and where to scan to find out if it has
> been lost.
>
>
> > I think the complete solution would be to extend kmemleak to support
> > OP-TEE memory scanning via OP-TEE invocation to check if it's holding
> > any kernel memory references.
>
> This is the part I get stuck on... and the reason I'm still posting on
> the thread.
>
> I struggle to see any value in using kmemleak to identify this type of
> leak. That is the fundamental issue. False positives from kmemleak are
> damaging to user confidence in the tool and are especially harmful when
> it is complex and time consuming to verify that is actually is a false
> positive (which would certainly be the case for OP-TEE false positives).
> In short it is *not* always the case failure-to-detect is worse than
> false-positive.
>
> As discussed already the firmware/kernel contract prevents kmemleak from
> working as it is designed to and I am unconvinced that relying on
> fragile timeouts is sufficient.
>
> Extending kmemleak to support OP-TEE memory scanning is also, IMHO,
> pointless. The reason for this is that OP-TEE cannot perform any scan on
> behalf of kmemleak without first validating the information provided to
> it by the kernel (to avoid information leaks). However if OP-TEE tracks
> enough state to validate the kernel input than it already has enough
> state to do a scan for leaks independently anyway (apart from being
> donated an execution context). Therefore it follows that any OP-TEE
> extension to handle leaks should be independent of kmemleak because it
> would still be useful to be able to ask OP-TEE to run a self-consistency
> check even if kmemleak is disabled.
>
> Or, in short, even if you implement improved leak detection for OP-TEE
> (whether that is based on timers or scanning) then kmemleak_not_leak()
> is still the right thing to do with pointers whose ownership we have
> transferred to OP-TEE.
>
>
> > > > > Sure, after we change ownership it could still be leaked... but it =
can
> > > > > no longer be leaked by the kernel because the kernel no longer owns=
 it!
> > > > > More importantly, it makes no sense to run the kernel memory detect=
or on the
> > > > > buffer because it simply can't work.
> > > > >
> > > > > After the RPC completes, doesn't it become impossible for kmemleak =
to
> > > > > scan to see if the pointer is lost[1]?
> > > >
> > > > Apart from the special OP-TEE prealloc SHM cache stuff, I can't think
> > > > of any scenario where an OP-TEE thread should hold off kernel's memory
> > > > pointers for more than 5 seconds before being passed onto kernel for
> > > > further RPC commands or RPC free action. So the kmemleak should be
> > > > able to detect if a pointer is lost.
> > >
> > > Or putting this a different way: there is known to be firmware in the
> > > field that allocates pointers for more then five seconds!
> >
> > If it's known that upstream OP-TEE doesn't hold any kernel memory
> > references for more than 5 seconds then IMO we should be fine to not
> > disable kmemleak until we have a future kmemleak extension. Otherwise
> > it would be very hard to keep track of kernel memory lost in this way.
>
> In essence I am arguing for using the right tool for the right job (and
> against turning down a correct patch because the right tool isn't yet
> implemented). A memory scanning leak detector is the wrong tool to
> search for leaks in memory that cannot be scanned.
>
> For me having to rely on fragile implied contracts and undocumented
> assumptions about timing further reinforces my view that kmemleak is not
> the wrong tool. Especially so when we know that those assumptions are
> not met by existing firmware.

I agree, this patch makes sense. It fixes a problem and I can't see a
downside with that. In a not too distant future we may change the way
this memory is passed to OP-TEE by keeping a reference in the driver,
but until then this patch will fix a problem.

Cheers,
Jens

--===============2989368853653491202==--


From: Sumit Garg <sumit.garg@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Date: Tue, 04 Mar 2025 13:15:54 +0530
Message-ID: <Z8avsigZJ4vqmiA4@sumit-X1>
In-Reply-To: <
 <CAHUa44FkG1NAWpoW8UVBywv44XW_mjAJa32PcC9mcmiOLdiRqw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1125941987809104700=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1125941987809104700==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 08:17:23AM +0100, Jens Wiklander wrote:
> Hi Daniel,
>=20
> On Fri, Feb 21, 2025 at 3:12=E2=80=AFPM Daniel Stone <daniel@fooishbar.or=
g> wrote:
> >
> > Hi Sumit,
> >
> > On Fri, 21 Feb 2025 at 11:24, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > On Tue, 18 Feb 2025 at 21:52, Daniel Stone <daniel@fooishbar.org> wro=
te:
> > > > dma-heaps was created to solve the problem of having too many
> > > > 'allocate $n bytes from $specialplace' uAPIs. The proliferation was
> > > > painful and making it difficult for userspace to do what it needed to
> > > > do. Userspace doesn't _yet_ make full use of it, but the solution is
> > > > to make userspace make full use of it, not to go create entirely
> > > > separate allocation paths for unclear reasons.
> > > >
> > > > Besides, I'm writing this from a platform that implements SVP not via
> > > > TEE. I've worked on platforms which implement SVP without any TEE,
> > > > where the TEE implementation would be at best a no-op stub, and at
> > > > worst flat-out impossible.
> > >
> > > Can you elaborate the non-TEE use-case for Secure Video Path (SVP) a
> > > bit more? As to how the protected/encrypted media content pipeline
> > > works? Which architecture support does your use-case require? Is there
> > > any higher privileged level firmware interaction required to perform
> > > media content decryption into restricted memory? Do you plan to
> > > upstream corresponding support in near future?
> >
> > You can see the MTK SVP patches on list which use the MTK SMC to mediate =
it.
> >
> > There are TI Jacinto platforms which implement a 'secure' area
> > configured statically by (IIRC) BL2, with static permissions defined
> > for each AXI endpoint, e.g. CPU write + codec RW + dispc read. I've
> > heard of another SoC vendor doing the same, but I don't think I can
> > share those details. There is no TEE interaction.
> >
> > I'm writing this message from an AMD laptop which implements
> > restricted content paths outside of TEE. I don't have the full picture
> > of how SVP is implemented on AMD systems, but I do know that I don't
> > have any TEE devices exposed.
> >
> > > Let me try to elaborate on the Secure Video Path (SVP) flow requiring
> > > a TEE implementation (in general terms a higher privileged firmware
> > > managing the pipeline as the kernel/user-space has no access
> > > permissions to the plain text media content):
> > >
> > > - [...]
> >
> > Yeah, I totally understand the TEE usecase. I think that TEE is a good
> > design to implement this. I think that TEE should be used for SVP
> > where it makes sense.
> >
> > Please understand that I am _not_ arguing that no-one should use TEE for =
SVP!
> >
> > > > So, again, let's
> > > > please turn this around: _why_ TEE? Who benefits from exposing this as
> > > > completely separate to the more generic uAPI that we specifically
> > > > designed to handle things like this?
> > >
> > > The bridging between DMA heaps and TEE would still require user-space
> > > to perform an IOCTL into TEE to register the DMA-bufs as you can see
> > > here [1]. Then it will rather be two handles for user-space to manage.
> >
> > Yes, the decoder would need to do this. That's common though: if you
> > want to share a buffer between V4L2 and DRM, you have three handles:
> > the V4L2 buffer handle, the DRM GEM handle, and the dmabuf you use to
> > bridge the two.
> >
> > > Similarly during restricted memory allocation/free we need another
> > > glue layer under DMA heaps to TEE subsystem.
> >
> > Yep.
> >
> > > The reason is simply which has been iterated over many times in the
> > > past threads that:
> > >
> > >     "If user-space has to interact with a TEE device for SVP use-case
> > > then why it's not better to ask TEE to allocate restricted DMA-bufs
> > > too"
> >
> > The first word in your proposition is load-bearing.
> >
> > Build out the usecase a little more here. You have a DRMed video
> > stream coming in, which you need to decode (involving TEE for this
> > usecase). You get a dmabuf handle to the decoded frame. You need to
> > pass the dmabuf across to the Wayland compositor. The compositor needs
> > to pass it to EGL/Vulkan to import and do composition, which in turn
> > passes it to the GPU DRM driver. The output of the composition is in
> > turn shared between the GPU DRM driver and the separate KMS DRM
> > driver, with the involvement of GBM.
> >
> > For the platforms I'm interested in, the GPU DRM driver needs to
> > switch into protected mode, which has no involvement at all with TEE -
> > it's architecturally impossible to have TEE involved without moving
> > most of the GPU driver into TEE and destroying performance. The
> > display hardware also needs to engage protected mode, which again has
> > no involvement with TEE and again would need to have half the driver
> > moved into TEE for no benefit in order to do so. The Wayland
> > compositor also has no interest in TEE: it tells the GPU DRM driver
> > about the protected status of its buffers, and that's it.
> >
> > What these components _are_ opinionated about, is the way buffers are
> > allocated and managed. We built out dmabuf modifiers for this usecase,
> > and we have a good negotiation protocol around that. We also really
> > care about buffer placement in some usecases - e.g. some display/codec
> > hardware requires buffers to be sourced from contiguous memory, other
> > hardware needs to know that when it shares buffers with another
> > device, it needs to place the buffers outside of inaccessible/slow
> > local RAM. So we built out dma-heaps, so every part of the component
> > in the stack can communicate their buffer-placement needs in the same
> > way as we do modifiers, and negotiate an acceptable allocation.
> >
> > That's my starting point for this discussion. We have a mechanism to
> > deal with the fact that buffers need to be shared between different IP
> > blocks which have their own constraints on buffer placement, avoiding
> > the current problem of having every subsystem reinvent their own
> > allocation uAPI which was burying us in impedance mismatch and
> > confusion. That mechanism is dma-heaps. It seems like your starting
> > point from this discussion is that you've implemented a TEE-centric
> > design for SVP, and so all of userspace should bypass our existing
> > cross-subsystem special-purpose allocation mechanism, and write
> > specifically to one implementation. I believe that is a massive step
> > backwards and an immediate introduction of technical debt.
> >
> > Again, having an implementation of SVP via TEE makes a huge amount of
> > sense. Having _most_ SVP implementations via TEE still makes a lot of
> > sense. Having _all_ SVP implementations eventually be via TEE would
> > still make sense. But even if we were at that point - which we aren't
> > - it still doesn't justify telling userspace 'use the generic dma-heap
> > uAPI for every device-specific allocation constraint, apart from SVP
> > which has a completely different way to allocate some bytes'.
>=20
> I must admit that I don't see how this makes a significant difference,
> but then I haven't hacked much in the stacks you're talking about, so
> I'm going to take your word for it.
>=20
> I've experimented with providing a dma-heap replacing the TEE API. The
> implementation is more complex than I first anticipated, adding about
> 400 lines to the patch set.

I did anticipated this but let's give it a try and see if DMA heaps
really adds any value from user-space point of view. If it does then it
will be worth the maintenence overhead.

> From user space, it looks like another
> dma-heap. I'm using the names you gave earlier,
> protected,secure-video, protected,trusted-ui, and
> protected,secure-video-record. However, I wonder if we shouldn't use
> "restricted" instead of "protected" since we had agreed to call it
> restricted memory earlier.

Let's stick with "restricted" memory buffer references only.

-Sumit

--===============1125941987809104700==--


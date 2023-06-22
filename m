From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 0/4] introduce tee-based EFI Runtime Variable Service
Date: Thu, 22 Jun 2023 22:03:47 +0300
Message-ID: <ZJSbE/82z+319sTL@hera>
In-Reply-To: <65d010fa-c801-eb4f-352f-8bfb52a67c85@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7240709921776387561=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7240709921776387561==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Jun 22, 2023 at 08:32:44PM +0200, Jan Kiszka wrote:
> On 22.06.23 17:04, Ilias Apalodimas wrote:
> > Hi Jan,
> >
> > On Thu, 22 Jun 2023 at 17:56, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 22.06.23 10:51, Masahisa Kojima wrote:
> >>> This series introduces the tee based EFI Runtime Variable Service.
> >>>
> >>> The eMMC device is typically owned by the non-secure world(linux in
> >>> this case). There is an existing solution utilizing eMMC RPMB partition
> >>> for EFI Variables, it is implemented by interacting with
> >>> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> >>> and tee-supplicant. The last piece is the tee-based variable access
> >>> driver to interact with OP-TEE and StandaloneMM.
> >>>
> >>> Changelog:
> >>> v5 -> v6
> >>> - new patch #4 is added in this series, #1-#3 patches are unchanged.
> >>>   automatically update super block flag when the efivarops support
> >>>   SetVariable runtime service, so that user does not need to manually
> >>>   remount the efivarfs as RW.
> >>
> >> But that is not yet resolving the architectural problem with that
> >> userspace daemon dependency. What are the next steps for that now?
> >
> > We are trying to find some cycles to work on that, however, I don't
> > have a time estimate on that.  But the question is different here.
> > Since this addresses the problems distros have wrt to SetVariableRT
> > (even for a limited set of platforms) are we ok pulling this in?  I
> > can't think of a technical reason we shouldn't.  The supplicant
> > limitations are known and the firrmwareTPM has a similar set of
> > problems.
>
> It will not change we have to do on the distro side because we have to
> deal not only with the startup issue and StMM but also with fTPM and
> with shutdown. Only an in-kernel supplicant for RPMB would resolve that
> according to my understanding.
>

Exactly and it's worth noting that even that will come with some minor
limitations.  E.g the randomseed variables set by the efistub currently
won't be supported as the modules will come alive way later.  But it's all
reasonable compromises for hardware that wasn't designed to have a
dedicated storage in the secure world and support runtime variables sanely.

> But the question is fair if we can evolve from this stage here to an
> in-kernel approach without causing breakages or other headache to
> distros adopting it (too early). That's why I asked for the roadmap.

Exactly and this is my point as well.  I can't see a technical difference
other than 'you won't need to launch the supplicant'.  The only thing we
need to keep in mind is introduce the fallback between the supplicant and
the (future) kernel supplicant gracefully.  People might still need to run
the supplicant for other reasons.  But if we design it with the kernel
module taking precedence over the supplicant we should be fine.

So since we lived with it a for a few years, I suggest we let it soak a bit
and get tested while we try to move the supplicant bits needed over to the
kernel. In the meantime patch #4 needs some adjustments, so I'll rethink
the supplicant vs kernel module scenario in case I missed something.

Thanks
/Ilias

>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>

--===============7240709921776387561==--


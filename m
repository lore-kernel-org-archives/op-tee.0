From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 0/4] introduce tee-based EFI Runtime Variable Service
Date: Fri, 23 Jun 2023 12:31:07 +0300
Message-ID: <ZJVmW6aa87swMy82@hera>
In-Reply-To: <8318ced2-9a4a-c0f3-f4ca-f56bf8beaa20@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2276876220776101491=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2276876220776101491==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


[...]

> >>>>
> >>>> But that is not yet resolving the architectural problem with that
> >>>> userspace daemon dependency. What are the next steps for that now?
> >>>
> >>> We are trying to find some cycles to work on that, however, I don't
> >>> have a time estimate on that.  But the question is different here.
> >>> Since this addresses the problems distros have wrt to SetVariableRT
> >>> (even for a limited set of platforms) are we ok pulling this in?  I
> >>> can't think of a technical reason we shouldn't.  The supplicant
> >>> limitations are known and the firrmwareTPM has a similar set of
> >>> problems.
> >>
> >> It will not change we have to do on the distro side because we have to
> >> deal not only with the startup issue and StMM but also with fTPM and
> >> with shutdown. Only an in-kernel supplicant for RPMB would resolve that
> >> according to my understanding.
> >>
> >
> > Exactly and it's worth noting that even that will come with some minor
> > limitations.  E.g the randomseed variables set by the efistub currently
> > won't be supported as the modules will come alive way later.  But it's all
> > reasonable compromises for hardware that wasn't designed to have a
> > dedicated storage in the secure world and support runtime variables sanel=
y.
>
> My feeling is that such simpler setups will be the minority, simply
> because eMMCs with RPMBs are standardized, often included anyway, so
> come "for free".
>

Yea maybe, I always have the (maybe false) hope that hardware will evolve
sanely.

> >
> >> But the question is fair if we can evolve from this stage here to an
> >> in-kernel approach without causing breakages or other headache to
> >> distros adopting it (too early). That's why I asked for the roadmap.
> >
> > Exactly and this is my point as well.  I can't see a technical difference
> > other than 'you won't need to launch the supplicant'.  The only thing we
> > need to keep in mind is introduce the fallback between the supplicant and
> > the (future) kernel supplicant gracefully.  People might still need to run
> > the supplicant for other reasons.  But if we design it with the kernel
> > module taking precedence over the supplicant we should be fine.
> >
> > So since we lived with it a for a few years, I suggest we let it soak a b=
it
> > and get tested while we try to move the supplicant bits needed over to the
> > kernel. In the meantime patch #4 needs some adjustments, so I'll rethink
> > the supplicant vs kernel module scenario in case I missed something.
>
> Were there distros adopting all this already? I thought this was a
> privilege of custom integrations where you can evolve things simply in
> lock-step? At least Debian wasn't considering all these dependencies
> yet, even though now providing tee-supplicant. We are patching it for
> now [1].

I've been working with Fedora and the OP-TEE community to get some of the
pieces in place. As a result, Fedora already compiles the TEE client without
RPMB emulation support [0]. We've also fixed the optee-client and removed the
compile time dependency of choosing the right RPMB.  The device the
supplicant now binds to is selectable at runtime [1]. With these two
already merged the user-space tee client is hardware agnostic (as it should
be).

There's two things missing from distros
- Lift the !PSTORE Kconfig limitation this patchset carries so distros can
  unconditionally enable the module in their builds.  But we can do this
  later while coordinating with distros that build the userspace packages
  correctly.
- Distros needs to scan for the rpmb they want to control in sysfs and
  launch the supplicant with the appropriate --rpmb-cid option

[0] https://src.fedoraproject.org/rpms/optee_client/blob/rawhide/f/optee_clie=
nt.spec
[1] commit 5a69d55d6596 ("tee-supplicant: add --rpmb-cid command line option")
    in the optee_client repo

Thanks
/Ilias
>
> Jan
>
> [1]
> https://github.com/BaochengSu/isar/commit/d7646e3bb9d882b26eaf2517fece62401=
0cdd46e
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>

--===============2276876220776101491==--


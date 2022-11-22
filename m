From: Jeffrey Kardatzke <jkardatzke@google.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: register_ddr() with larger than physical RAM size
Date: Tue, 22 Nov 2022 10:55:40 -0800
Message-ID: 
 <CA+ddPcMV4sLTOh+Zbz-iQRYPMa3AN-00G7JZ4q1ztihri4G9sQ@mail.gmail.com>
In-Reply-To: <
 <CAHUa44G598HQfo-N88FkS+_nD=k+QXC75E1SPNS_Vk4pxU4EzQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2319395250406409844=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2319395250406409844==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Jens,

Thanks for the explanation!

Cheers,
Jeff

On Tue, Nov 22, 2022 at 12:58 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi Jeffrey,
>
> On Fri, Nov 18, 2022 at 11:02 PM Jeffrey Kardatzke via OP-TEE
> <op-tee@lists.trustedfirmware.org> wrote:
> >
> > Hello,
> >
> > New to this list, I'm working on integrating Op-Tee into ChromeOS ARM
> > devices for the purpose of Widevine DRM.
> >
> > Does anybody know if Op-Tee creates mappings in the MMU that go beyond
> > the registered TZ memory region and the static non-secure shared
> > memory region?
> >
> > TL;DR
> >
> > Does anyone know if there would be problems associated with invoking
> > register_ddr()[1] with a size larger than the physical RAM size?  The
> > reason I want to do this is because we have multiple different SKUs
> > for the same reference board, and for ChromeOS we build per-board
> > images and not per-SKU images. We could use a DT to do this, but
> > that's running into other issues...so I'm trying to determine if this
> > easy fix will solve the problem w/out creating new ones.  (it does
> > work fine when I test it)
>
> register_ddr() defines the ranges that OP-TEE accepts as non-secure
> shared memory. I you add memory that doesn't exist then OP-TEE can be
> tricked into mapping memory that doesn't exist. When using such
> mappings you may get unexpected external aborts. However, as long as
> normal world doesn't use those addresses you will not notice any
> difference.
>
> If you could find a way of probing the amount of available memory at
> boot you could use that instead of a static registration a bit like
> how we read from DT.
>
> >
> > I understand that an exploited normal world could send a PA pointing
> > to a region outside of the physical bounds for dynamic shared memory,
> > and then Op-Tee would try to map that and undesirable things may
> > happen (but I don't think they would lead to secure world exploits
> > since the memory will be mapped as non-secure, so it shouldn't be any
> > worse that the normal world trying to access physical memory out of
> > bounds).
>
> Secure world panic() seems a likely worst-case scenario unless it
> triggers an unexpected bug in secure world.
>
> >
> > One of the main concerns is around whether Op-Tee is creating mappings
> > in the MMU that reference the whole nonsecure DDR size for some other
> > reason.  Then the CPU may do speculative execution and try to access
> > the physical memory at that invalid mapping and create problems, which
> > could then lead to failure when someone isn't trying to exploit the
> > system.
> >
> > Does anybody know if Op-Tee creates mappings in the MMU that go beyond
> > the registered TZ memory region and the static non-secure shared
> > memory region?
>
> That's only done if such addresses are supplied by normal world.
>
> Cheers,
> Jens
>
> >
> > [1] https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/plat-med=
iatek/main.c#L20
> >
> > Thanks,
> > --
> > Jeffrey Kardatzke
> > jkardatzke(a)google.com
> > Google, Inc.

--===============2319395250406409844==--


From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [EXTERNAL] Re: Current design of tee-supplicant can't support
 ftpm requests during kernel space bootup
Date: Wed, 27 Jul 2022 10:58:27 +0530
Message-ID: 
 <CAFA6WYNw=WMTPHG=g5TxAo8LCK14-ktsosFyBVqpkCuV3RaxVw@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CPUZP153MB069734A82D2FDF9B7F5BFD4FDC979=40PUZP153MB?=
 =?utf-8?q?0697=2EAPCP153=2EPROD=2EOUTLOOK=2ECOM=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6556749714504568401=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6556749714504568401==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Jul 2022 at 07:47, Judy Wang <wangjudy@microsoft.com> wrote:
>
> If a fast path to the MMC driver isn't an option due to concerns of affecti=
ng RPMB emulation codes.

RPMB emulation in user-mode supplicant is just there for testing
purposes before switching to real RPMB partition. So a fast path to
MMC driver for RPMB access should be the default option with an
opt-out choice via a config option like CONFIG_OPTEE_RPMB_EMULATION
which should be disabled by default.

-Sumit

> Any other suggestions we could solve this issue?
> Thank you.
>
> Judy.
>
> -----Original Message-----
> From: Sumit Garg <sumit.garg@linaro.org>
> Sent: Tuesday, July 26, 2022 12:37 PM
> To: J=C3=A9r=C3=B4me Forissier <jerome@forissier.org>
> Cc: Judy Wang <wangjudy@microsoft.com>; op-tee(a)lists.trustedfirmware.or=
g; Carl Lamb <Carl.Lamb@microsoft.com>; Tyler Hicks <Tyler.Hicks@microsof=
t.com>
> Subject: Re: [EXTERNAL] Re: Current design of tee-supplicant can't support =
ftpm requests during kernel space bootup
>
> [You don't often get email from sumit.garg(a)linaro.org. Learn why this is =
important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Mon, 25 Jul 2022 at 19:44, J=C3=A9r=C3=B4me Forissier <jerome@forissie=
r.org> wrote:
> >
> >
> > On Thu, Jul 21, 2022 at 11:46 AM Sumit Garg <sumit.garg@linaro.org> wro=
te:
> >>
> >> On Thu, 21 Jul 2022 at 14:41, Judy Wang <wangjudy@microsoft.com> wrote:
> >>
> >> > I can see the whole design is rooted with the idea of having tee-suppl=
icant as the servant, don't think it's worth to flip the whole design just to=
 fill the gap before user space is up. We haven't really come up with a desig=
n so will keep you posted.
> >>
> >> You don't need to flip the tee-supplicant design but rather just
> >> handle RPMB requests in the kernel itself if it's supported by MMC
> >> driver (you need a similar hook in the kernel as we have in u-boot
> >> [1]). All other OP-TEE RPC requests unhandled by the kernel can be
> >> forwarded to the user-mode tee-supplicant.
> >
> >
> > Correct but please keep in mind that we have RPMB emulation code inside t=
ee-supplicant, which is quite useful for testing. Therefore any "fast path" t=
o the MMC driver inside the OP-TEE driver should probably be opt-out.
> >
>
> Agree.
>
> -Sumit
>
> > --
> > Jerome

--===============6556749714504568401==--


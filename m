From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [EXTERNAL] Re: Current design of tee-supplicant can't support
 ftpm requests during kernel space bootup
Date: Mon, 08 Aug 2022 10:46:59 +0200
Message-ID: 
 <CAHUa44Fv=N3RfVLzg8qKL3ch_yMeukz_oxy-c4sWbDgO7JaKog@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYNw=WMTPHG=g5TxAo8LCK14-ktsosFyBVqpkCuV3RaxVw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7826895650045560314=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7826895650045560314==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 27, 2022 at 7:28 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Wed, 27 Jul 2022 at 07:47, Judy Wang <wangjudy@microsoft.com> wrote:
> >
> > If a fast path to the MMC driver isn't an option due to concerns of affec=
ting RPMB emulation codes.
>
> RPMB emulation in user-mode supplicant is just there for testing
> purposes before switching to real RPMB partition. So a fast path to
> MMC driver for RPMB access should be the default option with an
> opt-out choice via a config option like CONFIG_OPTEE_RPMB_EMULATION
> which should be disabled by default.

I agree, but the name of the config option can be discussed. I'd
prefer something that describes what it does from a kernel point of
view, perhaps CONFIG_OPTEE_RPMB_FASTPATH.

So far we have considered the problem of selecting the correct RPMB
device (out of many) a user space problem, but with the fast-path
option, we're moving the problem into kernel space. Tee-supplicant has
a --rpmb-cid option as one way of addressing this problem. I'm not
sure what's the best approach for the kernel driver.

Cheers,
Jens

>
> -Sumit
>
> > Any other suggestions we could solve this issue?
> > Thank you.
> >
> > Judy.
> >
> > -----Original Message-----
> > From: Sumit Garg <sumit.garg@linaro.org>
> > Sent: Tuesday, July 26, 2022 12:37 PM
> > To: J=C3=A9r=C3=B4me Forissier <jerome@forissier.org>
> > Cc: Judy Wang <wangjudy@microsoft.com>; op-tee(a)lists.trustedfirmware.=
org; Carl Lamb <Carl.Lamb@microsoft.com>; Tyler Hicks <Tyler.Hicks@micros=
oft.com>
> > Subject: Re: [EXTERNAL] Re: Current design of tee-supplicant can't suppor=
t ftpm requests during kernel space bootup
> >
> > [You don't often get email from sumit.garg(a)linaro.org. Learn why this i=
s important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On Mon, 25 Jul 2022 at 19:44, J=C3=A9r=C3=B4me Forissier <jerome@foriss=
ier.org> wrote:
> > >
> > >
> > > On Thu, Jul 21, 2022 at 11:46 AM Sumit Garg <sumit.garg@linaro.org> w=
rote:
> > >>
> > >> On Thu, 21 Jul 2022 at 14:41, Judy Wang <wangjudy@microsoft.com> wro=
te:
> > >>
> > >> > I can see the whole design is rooted with the idea of having tee-sup=
plicant as the servant, don't think it's worth to flip the whole design just =
to fill the gap before user space is up. We haven't really come up with a des=
ign so will keep you posted.
> > >>
> > >> You don't need to flip the tee-supplicant design but rather just
> > >> handle RPMB requests in the kernel itself if it's supported by MMC
> > >> driver (you need a similar hook in the kernel as we have in u-boot
> > >> [1]). All other OP-TEE RPC requests unhandled by the kernel can be
> > >> forwarded to the user-mode tee-supplicant.
> > >
> > >
> > > Correct but please keep in mind that we have RPMB emulation code inside=
 tee-supplicant, which is quite useful for testing. Therefore any "fast path"=
 to the MMC driver inside the OP-TEE driver should probably be opt-out.
> > >
> >
> > Agree.
> >
> > -Sumit
> >
> > > --
> > > Jerome

--===============7826895650045560314==--


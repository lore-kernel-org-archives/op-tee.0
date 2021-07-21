From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 0/8] tee: Improve support for kexec and kdump
Date: Wed, 21 Jul 2021 08:03:38 +0200
Message-ID: 
 <CAHUa44Ej85bbn8CzsJ24CWkeZQPMWC-w_m2ypP6nPjcEuErFBA@mail.gmail.com>
In-Reply-To: <944c1df8-3e9f-0026-c83c-d778f42fa1b3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2835713628735916577=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2835713628735916577==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Tyler,

With Florian's Ack on "PATCH v5 8/8] firmware: tee_bnxt: Release TEE
shm, session, and context during kexec" I think we have everything we
need for a pull request. I've pushed the patches to
https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=3Dtyhicks_k=
exec_v5

Would you mind testing that branch to make sure it still works as
intended? I'd appreciate if you could double check the tags too. I'll
send a pull request for v5.14 later this week if everything is OK.

Thanks,
Jens

On Tue, Jun 15, 2021 at 4:16 PM Florian Fainelli <f.fainelli@gmail.com> wro=
te:
>
>
>
> On 6/15/2021 6:37 AM, Tyler Hicks wrote:
> > On 2021-06-15 09:23:25, Jens Wiklander wrote:
> >> It looks like we're almost done now. Thanks for your patience to see
> >> this through.
> >>
> >> I suppose it makes most sense to take this via my tree, but before I
> >> can do that I'll need acks from the maintainers of
> >> drivers/char/tpm/tpm_ftpm_tee.c ("tpm_ftpm_tee: Free and unregister
> >> TEE shared memory during kexec") and
> >> drivers/firmware/broadcom/tee_bnxt_fw.c ("firmware: tee_bnxt: Release
> >> TEE shm, session, and context during kexec").
> >
> > @Rafa=C5=82 Mi=C5=82ecki, we just need an ack from you for the tee_bnxt_f=
w.c
> > change:
> >
> >  https://lore.kernel.org/lkml/20210614223317.999867-9-tyhicks(a)linux.mic=
rosoft.com/
>
> Rafal is listed as the maintainer of drivers/firmware/broadcom/ but he
> did not author that file, Vikas did, adding him.
> --
> Florian

--===============2835713628735916577==--


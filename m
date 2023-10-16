From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] tee: optee: Fix supplicant based device enumeration
Date: Mon, 16 Oct 2023 09:32:06 +0200
Message-ID: 
 <CAHUa44Gyzv23c+L7dKQXh0oVgbJ_96guOZwTb7o87f2Gy9b9Dg@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYOZPD+y0SOQTCih8qf5_FjX6DWtPTki13MM8J8V8LaHMQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7682775534809340679=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7682775534809340679==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On Thu, Oct 12, 2023 at 2:40=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Wed, 11 Oct 2023 at 20:15, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > On 29.08.23 13:03, Sumit Garg wrote:
> > > Hi Jan,
> > >
> > > On Fri, 28 Jul 2023 at 19:18, Sumit Garg <sumit.garg@linaro.org> wrot=
e:
> > >>
> > >> Currently supplicant dependent optee device enumeration only registers
> > >> devices whenever tee-supplicant is invoked for the first time. But it
> > >> forgets to remove devices when tee-supplicant daemon stops running and
> > >> closes its context gracefully. This leads to following error for fTPM
> > >> driver during reboot/shutdown:
> > >>
> > >> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke e=
rror: 0xffff3024
> > >>
> > >> Fix this by separating supplicant dependent devices so that the
> > >> user-space service can detach supplicant devices before closing the
> > >> supplicant. While at it use the global system workqueue for OP-TEE bus
> > >> scanning work rather than our own custom one.
> > >>
> > >> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> > >> Link: https://github.com/OP-TEE/optee_os/issues/6094
> > >
> > > I see you have marked this issue as resolved. It would be good to have
> > > your tested-by tag if it works for you.
> > >
> >
> > Sorry for this very late reply. We finally validated that this works
> > fine for us, though only over 6.1, our current test target. I hope we
> > can enable tip of tree soon as well. But I think I can still add my
> >
> > Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
> >
>
> Thanks.
>
> Jens,
>
> Can you queue up this fix?

Sure, please supply this as two patches. One for the work queue
changes and one for the device name change.

Thanks,
Jens

>
> -Sumit
>
> > Jan
> >
> > --
> > Siemens AG, Technology
> > Linux Expert Center
> >

--===============7682775534809340679==--


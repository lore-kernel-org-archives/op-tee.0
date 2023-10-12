From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] tee: optee: Fix supplicant based device enumeration
Date: Thu, 12 Oct 2023 18:09:51 +0530
Message-ID: 
 <CAFA6WYOZPD+y0SOQTCih8qf5_FjX6DWtPTki13MM8J8V8LaHMQ@mail.gmail.com>
In-Reply-To: <a9515560-32bc-4f3b-a36c-87f7242081a9@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6608957434672581538=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6608957434672581538==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Oct 2023 at 20:15, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 29.08.23 13:03, Sumit Garg wrote:
> > Hi Jan,
> >
> > On Fri, 28 Jul 2023 at 19:18, Sumit Garg <sumit.garg@linaro.org> wrote:
> >>
> >> Currently supplicant dependent optee device enumeration only registers
> >> devices whenever tee-supplicant is invoked for the first time. But it
> >> forgets to remove devices when tee-supplicant daemon stops running and
> >> closes its context gracefully. This leads to following error for fTPM
> >> driver during reboot/shutdown:
> >>
> >> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke err=
or: 0xffff3024
> >>
> >> Fix this by separating supplicant dependent devices so that the
> >> user-space service can detach supplicant devices before closing the
> >> supplicant. While at it use the global system workqueue for OP-TEE bus
> >> scanning work rather than our own custom one.
> >>
> >> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> Link: https://github.com/OP-TEE/optee_os/issues/6094
> >
> > I see you have marked this issue as resolved. It would be good to have
> > your tested-by tag if it works for you.
> >
>
> Sorry for this very late reply. We finally validated that this works
> fine for us, though only over 6.1, our current test target. I hope we
> can enable tip of tree soon as well. But I think I can still add my
>
> Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
>

Thanks.

Jens,

Can you queue up this fix?

-Sumit

> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center
>

--===============6608957434672581538==--


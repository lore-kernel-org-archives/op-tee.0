From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 1/2] optee: fix tee out of memory failure seen during
 kexec reboot
Date: Fri, 19 Mar 2021 08:00:22 +0100
Message-ID: 
 <CAHUa44FyGOj5=Z80km_2T-avKiJpGVD8cWjTC3ZCX8csazP3rw@mail.gmail.com>
In-Reply-To: <9a6c017c-d156-f939-f907-d6dfe83c41ac@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2339811914100422817=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2339811914100422817==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 16, 2021 at 2:21 PM Allen Pais <apais@linux.microsoft.com> wrot=
e:
>
>
>
> >>
> >> [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
> >> [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
> >>
> >> tee_shm_release() is not invoked on dma shm buffer.
> >>
> >> Implement .shutdown() method to handle the release of the buffers
> >> correctly.
> >>
> >> More info:
> >> https://github.com/OP-TEE/optee_os/issues/3637
> >>
> >> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> >> ---
> >>   drivers/tee/optee/core.c | 20 ++++++++++++++++++++
> >>   1 file changed, 20 insertions(+)
> >
> > This looks good to me. Do you have a practical way of testing this on
> > QEMU for instance?
> >
>
> Jens,
>
>    I could not reproduce nor create a setup using QEMU, I could only
> do it on a real h/w.
>
>    I have extensively tested the fix and I don't see any issues.

I did a few test runs too, seems OK.

Thanks,
Jens

--===============2339811914100422817==--


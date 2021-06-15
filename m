From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 0/8] tee: Improve support for kexec and kdump
Date: Tue, 15 Jun 2021 08:37:34 -0500
Message-ID: <20210615133734.GY4910@sequoia>
In-Reply-To: <
 <CAHUa44ErgoxT3L1W-ouoQwUg1fNC-zagOOgy=KBuGN_pETnYaw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2846998839981577850=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2846998839981577850==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2021-06-15 09:23:25, Jens Wiklander wrote:
> It looks like we're almost done now. Thanks for your patience to see
> this through.
>=20
> I suppose it makes most sense to take this via my tree, but before I
> can do that I'll need acks from the maintainers of
> drivers/char/tpm/tpm_ftpm_tee.c ("tpm_ftpm_tee: Free and unregister
> TEE shared memory during kexec") and
> drivers/firmware/broadcom/tee_bnxt_fw.c ("firmware: tee_bnxt: Release
> TEE shm, session, and context during kexec").

@Rafa=C5=82 Mi=C5=82ecki, we just need an ack from you for the tee_bnxt_fw.c
change:

 https://lore.kernel.org/lkml/20210614223317.999867-9-tyhicks(a)linux.microso=
ft.com/

Jarkko just gave us an ack for tpm_ftpm_tee.c on the v4 series:

 https://lore.kernel.org/lkml/20210615130411.hvpnaxnhimjloiz3(a)kernel.org/

The patch tpm_ftpm_tee.c patch didn't change from v4 to v5 and the
underlying concept of not using TEE_SHM_DMA_BUF remained the same so I
don't think we need a separate v5 ack.

Tyler

>=20
> Cheers,
> Jens
>=20

--===============2846998839981577850==--


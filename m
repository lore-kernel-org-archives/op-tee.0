From: Jarkko Sakkinen <jarkko@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 0/4] Introduce TEE based Trusted Keys support
Date: Thu, 04 Mar 2021 17:43:49 +0200
Message-ID: <YEEANW+khw3nJtcQ@kernel.org>
In-Reply-To: <
 <CAFA6WYO4HHhtymaUzmkuaCZybTAWBQ=4K9Dez1pe1kqo3AJhuA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7700358581813380386=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7700358581813380386==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 04, 2021 at 03:30:18PM +0530, Sumit Garg wrote:
> Hi Jarkko,
>=20
> On Mon, 1 Mar 2021 at 18:41, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Add support for TEE based trusted keys where TEE provides the functionali=
ty
> > to seal and unseal trusted keys using hardware unique key. Also, this is
> > an alternative in case platform doesn't possess a TPM device.
> >
> > This patch-set has been tested with OP-TEE based early TA which is already
> > merged in upstream [1].
> >
> > [1] https://github.com/OP-TEE/optee_os/commit/f86ab8e7e0de869dfa25ca05a37=
ee070d7e5b86b
> >
> > Changes in v9:
> > 1. Rebased to latest tpmdd/master.
> > 2. Defined pr_fmt() and removed redundant tags.
> > 3. Patch #2: incorporated misc. comments.
> > 4. Patch #3: incorporated doc changes from Elaine and misc. comments
> >    from Randy.
> > 5. Patch #4: reverted to separate maintainer entry as per request from
> >    Jarkko.
> > 6. Added Jarkko's Tested-by: tag on patch #2.
>=20
> It looks like we don't have any further comments on this patch-set. So
> would you be able to pick up this patch-set?

I'm cool with that - I can pick this for 5.13.

/Jarkko

--===============7700358581813380386==--


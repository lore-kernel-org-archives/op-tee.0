From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 0/4] Introduce TEE based Trusted Keys support
Date: Tue, 09 Mar 2021 14:40:07 +0530
Message-ID: 
 <CAFA6WYOxsYin8wBB_yU=S-bnqM-g5TFnTU_KXxc3wSBfx_N_6A@mail.gmail.com>
In-Reply-To: <YEEANW+khw3nJtcQ@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0377604468515503801=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0377604468515503801==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Mar 2021 at 21:14, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Thu, Mar 04, 2021 at 03:30:18PM +0530, Sumit Garg wrote:
> > Hi Jarkko,
> >
> > On Mon, 1 Mar 2021 at 18:41, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Add support for TEE based trusted keys where TEE provides the functiona=
lity
> > > to seal and unseal trusted keys using hardware unique key. Also, this is
> > > an alternative in case platform doesn't possess a TPM device.
> > >
> > > This patch-set has been tested with OP-TEE based early TA which is alre=
ady
> > > merged in upstream [1].
> > >
> > > [1] https://github.com/OP-TEE/optee_os/commit/f86ab8e7e0de869dfa25ca05a=
37ee070d7e5b86b
> > >
> > > Changes in v9:
> > > 1. Rebased to latest tpmdd/master.
> > > 2. Defined pr_fmt() and removed redundant tags.
> > > 3. Patch #2: incorporated misc. comments.
> > > 4. Patch #3: incorporated doc changes from Elaine and misc. comments
> > >    from Randy.
> > > 5. Patch #4: reverted to separate maintainer entry as per request from
> > >    Jarkko.
> > > 6. Added Jarkko's Tested-by: tag on patch #2.
> >
> > It looks like we don't have any further comments on this patch-set. So
> > would you be able to pick up this patch-set?
>
> I'm cool with that - I can pick this for 5.13.
>

Thanks.

-Sumit

> /Jarkko

--===============0377604468515503801==--


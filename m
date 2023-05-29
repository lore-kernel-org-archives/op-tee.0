From: Ard Biesheuvel <ardb@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 0/3] introduce tee-based EFI Runtime Variable Service
Date: Mon, 29 May 2023 15:29:03 +0200
Message-ID: 
 <CAMj1kXGDRDCOgVXAYU2wM1SsT9A20-dxCRqiOu3-FbjGTvWehw@mail.gmail.com>
In-Reply-To: <
 <CAHUa44EcVtMRp-894vQdHkNpnowvsKEQMZbr=axOJPig9zFhqQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7140088978286723536=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7140088978286723536==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 29 May 2023 at 11:05, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Fri, May 26, 2023 at 3:10=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Fri, 26 May 2023 at 03:08, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> > >
> > > This series introduces the tee based EFI Runtime Variable Service.
> > >
> > > The eMMC device is typically owned by the non-secure world(linux in
> > > this case). There is an existing solution utilizing eMMC RPMB partition
> > > for EFI Variables, it is implemented by interacting with
> > > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > > and tee-supplicant. The last piece is the tee-based variable access
> > > driver to interact with OP-TEE and StandaloneMM.
> > >
> > > Changelog:
> > > v4 -> v5
> > > - rebase to efi-next based on v6.4-rc1
> > > - set generic_ops.query_variable_info, it works as expected as follows.
> > > $ df -h /sys/firmware/efi/efivars/
> > > Filesystem      Size  Used Avail Use% Mounted on
> > > efivarfs         16K  1.3K   15K   8% /sys/firmware/efi/efivars
> >
> > Excellent, thanks a lot for double checking that.
> >
> > Jens, did you have any feedback on this? If not, I intend to queue it
> > up for v6.5
>
> Looks good to me.
>
> Thanks,
> Jens
>

Thanks

I've queued this up now.

--===============7140088978286723536==--

